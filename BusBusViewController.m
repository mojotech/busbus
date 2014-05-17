//
//  BusBusViewController.m
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import "BusBusViewController.h"
#import "BSBBus.h"
#import "BOManager.h"
#import "BSBBusPin.h"
#import "BSBBusCollectionViewController.h"

#import <MapKit/MapKit.h>
#import <BlocksKit/BlocksKit.h>

#import <OHMKit/ObjectMapping.h>
#import <QuartzCore/QuartzCore.h>

@interface BusBusViewController ()

@property (nonatomic, strong) NSCache *busDetailCache;
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
    
    self.busDetailCache = [NSCache new];
    
    NSError *error = nil;
    [[BOManager sharedManager] findCurrentLocation];
    
    [RACObserve([BOManager sharedManager], currentBusses) subscribeNext:^(NSArray *buses) {
        [self setValue:buses forKeyPath:NSStringFromSelector(@selector(buses))];
        [self dropBusLocationsOnMap];
    }];
    
    if (error){
        NSLog(@"Model issue, whoops: %@", error);
    }
    
    self.pageView.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.86/1.0];

    [self.mapView setDelegate:self];
    
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
    
    _bussesViewController.view.frame = (CGRectMake(0, 0, self.pageView.frame.size.width, self.pageView.frame.size.width));
    [self addChildViewController:_bussesViewController];
    [self.pageView addSubview:_bussesViewController.view];
    [_bussesViewController didMoveToParentViewController:self];
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
        
        NSString *busNumber = [bus.busID substringFromIndex:1];
        
        pin.pinText = busNumber;
        pin.color = [BSBAppearance moduloColor:[busNumber integerValue]];
        
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
        
        [self.mapView showAnnotations:self.busPinAnnotations animated:YES];
    });
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
