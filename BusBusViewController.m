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

#import <MapKit/MapKit.h>
#import <BlocksKit/BlocksKit.h>

#import <OHMKit/ObjectMapping.h>
#import <QuartzCore/QuartzCore.h>

@interface BusBusViewController ()

@property (nonatomic, strong) NSCache *busDetailCache;

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


    // This needs to be placed in to a method that returns a CCLocationCoordinate
    
    BSBBus *firstBus = self.buses.firstObject;
    [self moveCenterByOffset:CGPointMake(0, 100) from:firstBus.coordinate];
}

- (void)instantiatePageViewController
{
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;

    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    self.pageViewController.view.frame = (CGRectMake(0, 0, self.pageView.frame.size.width, self.pageView.frame.size.width));
    [self addChildViewController:_pageViewController];
    [self.pageView addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

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

#pragma mark - Paging

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (self.buses.count <= index) {
        return [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    }
    
    BSBBus *bus = [self.buses objectAtIndex:index];
    
    PageContentViewController *pageContentViewController = [self.busDetailCache objectForKey:bus.busID];
    
    if (pageContentViewController == nil) {
        pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
        pageContentViewController.titleText = bus.routeID;
        pageContentViewController.busStop   = bus.address;
        pageContentViewController.pageIndex = index;
        
        [self.busDetailCache setObject:pageContentViewController forKey:bus.busID];
    }
    
    [self moveCenterByOffset:CGPointMake(0, 100) from:bus.coordinate];

    return pageContentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController *) viewController).pageIndex;
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    index++;
    return [self viewControllerAtIndex:index];
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.buses count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
