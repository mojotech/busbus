//
//  BusBusViewController.m
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import "BusBusViewController.h"
#import "BSBBus.h"
#import "BSBBusService.h"
#import "BSBBusPin.h"
#import "BSBBusCollectionViewController.h"

#import <MapKit/MapKit.h>

#import <OHMKit/ObjectMapping.h>
#import <QuartzCore/QuartzCore.h>

@interface BusBusViewController () <BSBBusCollectionDelegate>

@property (nonatomic, assign) BOOL busesHavePresented;
@property (nonatomic, strong) BSBBusCollectionViewController *bussesViewController;

- (void)dropBusLocationsOnMap;
- (void)moveCenterByOffset:(CGPoint)offset from:(CLLocationCoordinate2D)coordinate;

@end

@implementation BusBusViewController

+ (void)load
{
    OHMMappable([BusBusViewController class]);
    OHMSetArrayClasses([BusBusViewController class], @{NSStringFromSelector(@selector(buses)) : [BSBBus class]});
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[BSBBusService sharedManager] findCurrentLocation];
    
    [RACObserve([BSBBusService sharedManager], currentBusses) subscribeNext:^(NSArray *buses) {
        [self setValue:buses forKeyPath:NSStringFromSelector(@selector(buses))];
        [self dropBusLocationsOnMap];
    }];
    
    [self.mapView setDelegate:self];
    
    self.navigationItem.rightBarButtonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    
    [self instantiatePageViewController];
}

- (void)setBuses:(NSArray *)buses
{
    _buses = buses;
    [self.bussesViewController setBuses:buses];
}

- (void)instantiatePageViewController
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    self.bussesViewController = [[BSBBusCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    
    _bussesViewController.view.frame = (CGRectMake(0, 0, self.pageView.frame.size.width, self.pageView.frame.size.height));
    [self addChildViewController:_bussesViewController];
    [self.pageView addSubview:_bussesViewController.view];
    [_bussesViewController didMoveToParentViewController:self];
    
    self.bussesViewController.delegate = self;
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    BSBBusPin *pin;
    if(annotation != self.mapView.userLocation)
    {
        BSBBus *bus = (BSBBus *)annotation;
        
        static NSString *busPinIdentifier = @"busPinIdentifier";
        pin = (BSBBusPin *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:busPinIdentifier];
        if ( pin == nil ) {
            pin = [[BSBBusPin alloc] initWithAnnotation:annotation
                                        reuseIdentifier:busPinIdentifier];
        }
        
        NSString *busNumber = bus.routeID;
        
        pin.pinText = busNumber;
        pin.color = [BSBAppearance colorForBus:bus];
        
        pin.canShowCallout = NO;
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

@end
