//
//  BusBusViewController.m
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import "BusBusViewController.h"
#import "BSBBus.h"
#import "BSBBusStop.h"
#import "BSBBusService.h"
#import "BSBBusDataSource.h"
#import "BSBBusPin.h"
#import "BSBDetailCollectionViewController.h"
#import "BSBBusLineViewController.h"

#import <Masonry/Masonry.h>

@import MapKit;

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BusBusViewController () <BSBBusCollectionDelegate>

@property (nonatomic, assign) BOOL busesHavePresented;
@property (nonatomic, strong) BSBDetailCollectionViewController *bussesViewController;
@property (nonatomic, strong) BSBBusLineViewController *busLineController;

@property (nonatomic, strong) NSArray *buses;
@property (nonatomic, strong) NSArray *busPinAnnotations;

@property (nonatomic, strong) NSArray *busStops;
@property (nonatomic, strong) BSBBusDataSource *dataSource;

- (void)dropBusLocationsOnMap;
- (void)moveCenterByOffset:(CGPoint)offset from:(CLLocationCoordinate2D)coordinate;

@end

@implementation BusBusViewController

- (instancetype)init
{
    self = [super init];
    
    if (self == nil) {
        return nil;
    }
    
    self.dataSource = [BSBBusDataSource new];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"BusBus";
    [BSBAppearance styleNavigationBar:self.navigationController.navigationBar];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
    
    self.pageView = [[UIView alloc] initWithFrame:CGRectNull];
    [self.view addSubview:self.pageView];
    
    UIView *superview = self.view;
    
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superview);
        make.leading.equalTo(superview);
        make.trailing.equalTo(superview);
        make.height.equalTo(@250);
    }];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview);
    }];
    
    [[BSBBusService sharedManager] findCurrentLocation];
    
    [RACObserve([BSBBusService sharedManager], buses) subscribeNext:^(NSArray *buses) {
        self.buses = buses;
        [self dropBusLocationsOnMap];
    }];
    
    [[RACObserve([BSBBusService sharedManager], busStops) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        [self.mapView removeAnnotations:self.busStops];
        [self setValue:x forKeyPath:NSStringFromSelector(@selector(busStops))];
        [self.mapView addAnnotations:self.busStops];
    }];
    
    [self.mapView setDelegate:self];
    
    self.navigationItem.rightBarButtonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    
    [self instantiatePageViewController];
}

- (void)setBuses:(NSArray *)buses
{
    _buses = buses;
    self.dataSource.buses = buses;
    [self.bussesViewController setBuses:buses];
    [self.busLineController setBuses:buses];
}

- (void)instantiatePageViewController
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    self.bussesViewController = [[BSBDetailCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    
    [self addChildViewController:_bussesViewController];
    [self.pageView addSubview:_bussesViewController.view];
    [_bussesViewController didMoveToParentViewController:self];
    
    [self.bussesViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.height.equalTo(@(250 - (kBSBBusLineGroupHeight + 0.5)));
    }];
    
    self.bussesViewController.delegate = self;
    
    // Need a separate flow layout
    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    self.busLineController = [[BSBBusLineViewController alloc] initWithCollectionViewLayout:flowLayout];
    
    [self addChildViewController:self.busLineController];
    [self.pageView addSubview:self.busLineController.view];
    [self.busLineController didMoveToParentViewController:self];
    
    [self.busLineController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.height.equalTo(@(kBSBBusLineGroupHeight));
        make.bottom.equalTo(self.bussesViewController.view.mas_top).with.mas_offset(@(-0.5));
    }];
    
    [self.view bringSubviewToFront:self.bussesViewController.view];
    
    self.busLineController.delegate = self;
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    BSBBusPin *pin;
    if(annotation == self.mapView.userLocation)
    {
        return nil;
    }
    if ([annotation isKindOfClass:[BSBBus class]]) {
        
        pin = [self.dataSource mapView:mapView viewForAnnotation:annotation];
        
    } else if ([annotation isKindOfClass:[BSBBusStop class]]) {
        MKAnnotationView *pin = [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"pandas"];
        
        if (pin == nil) {
            pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pandas"];
        }
        
        [pin setTintColor:[BSBAppearance tintColor]];
        
        return pin;
    }
    return pin;
}

- (void)dropBusLocationsOnMap
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.busPinAnnotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self.mapView removeAnnotation:obj];
        }];
        
        self.busPinAnnotations = [self.buses copy];
        
        __block MKMapRect zoomRect = MKMapRectNull;
        
        [self.busPinAnnotations enumerateObjectsUsingBlock:^(id <MKAnnotation> annotation, NSUInteger idx, BOOL *stop) {
            MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
            MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
            if (MKMapRectIsNull(zoomRect)) {
                zoomRect = pointRect;
            } else {
                zoomRect = MKMapRectUnion(zoomRect, pointRect);
            }
        }];
        
        if (self.busesHavePresented == NO && self.busPinAnnotations.count > 0) {
            [self.mapView showAnnotations:self.busPinAnnotations animated:YES];
            [self.mapView setVisibleMapRect:zoomRect
                                edgePadding:UIEdgeInsetsMake(10, 10, 250, 10)
                                   animated:YES];
            self.busesHavePresented = YES;
        } else {
            [self.mapView addAnnotations:self.busPinAnnotations];
        }
        
    });
}

- (void)collectionViewSelectedBus:(BSBBus *)bus
{
    [self moveCenterByOffset:CGPointMake(0, 125) from:bus.coordinate];
}

- (void)moveCenterByOffset:(CGPoint)offset from:(CLLocationCoordinate2D)coordinate
{
    CGPoint point = [self.mapView convertCoordinate:coordinate toPointToView:self.mapView];
    point.x += offset.x;
    point.y += offset.y;
    CLLocationCoordinate2D center = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    [self.mapView setCenterCoordinate:center animated:YES];
}

#ifdef DEBUG

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ([[BSBBusService sharedManager] mockLocation] != nil) {
        [[BSBBusService sharedManager] setMockLocation:nil];
        
        [[[UIAlertView alloc] initWithTitle:@"Mock Location Cleared"
                                    message:@"Now using your real location."
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil] show];
        
        return;
    }
    
    CLLocation *location =
    [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(42.355579, -71.062768)
                                  altitude:14
                        horizontalAccuracy:1
                          verticalAccuracy:10 timestamp:[NSDate date]];
    
    [[BSBBusService sharedManager] setMockLocation:location];
    
    [[[UIAlertView alloc] initWithTitle:@"Mock Location"
                                message:@"Using test location. This only affects BusBus network calls, not your \"user location\" on the map. Enjoy the Common!"
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles: nil] show];
}

#endif

@end
