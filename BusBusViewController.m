
//
//  BusBusViewController.m
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import "BusBusViewController.h"
#import "Bus.h"
#import <MapKit/MapKit.h>
#import <Mantle.h>

@implementation BusBusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSError *error = nil;

    self.bus = [MTLJSONAdapter modelOfClass: [Bus class] fromJSONDictionary:[self convertDummyJSONData] error: &error];

    if (error){
        NSLog(@"Model issue, whoops: %@", error);
    }

    [self setDummyLocationToBoston];
    [self dropBusLocationsOnMap];
    [self instantiatePageViewController];
}

- (void)instantiatePageViewController
{
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;

    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    startingViewController.view.frame = (CGRectMake(0, 0, self.pageView.frame.size.width, self.pageView.frame.size.width));
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    self.pageViewController.view.frame = (CGRectMake(0, 0, self.pageView.frame.size.width, self.pageView.frame.size.width));
    [self addChildViewController:_pageViewController];
    [self.pageView addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

}

- (void)dropBusLocationsOnMap
{
    NSMutableArray *tempBusPinAnnoations = [[NSMutableArray alloc] init];
    int i;
    for (i = 0; i < [self.bus.buses count]; i++)
    {
        double fLat = [self.bus.buses[i][@"latitude"] doubleValue];
        double fLng = [self.bus.buses[i][@"longitude"] doubleValue];
        CLLocationDegrees *lat = &fLat;
        CLLocationDegrees *lng = &fLng;
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];

        [tempBusPinAnnoations addObject:point];
        point.coordinate = CLLocationCoordinate2DMake(*lat, *lng);
    }

    self.busPinAnnotations = [[NSArray alloc] initWithArray:tempBusPinAnnoations];

    [self.mapView showAnnotations:self.busPinAnnotations animated:YES];
}

- (NSDictionary *)convertDummyJSONData
{

    NSString *stringOfJSON = @"{\"buses\":[{\"id\":0,\"route\":\"170\",\"address\":\"Tehama Street\",\"registered\":\"2006-04-20T11:40:17 +04:00\",\"latitude\":42.402965,\"longitude\":-71.03627},{\"id\":1,\"route\":\"184\",\"address\":\"Himrod Street\",\"registered\":\"2012-06-29T08:45:47 +04:00\",\"latitude\":42.3488,\"longitude\":-71.1600},{\"id\":2,\"route\":\"147\",\"address\":\"Ocean Court\",\"registered\":\"2012-07-23T16:23:04 +04:00\",\"latitude\":42.3652687,\"longitude\":-71.0754089},{\"id\":3,\"route\":\"187\",\"address\":\"Schenck Street\",\"registered\":\"1990-03-10T16:45:38 +05:00\",\"latitude\":42.36484527,\"longitude\":-71.075546},{\"id\":4,\"route\":\"181\",\"address\":\"Beaumont Street\",\"registered\":\"2001-11-26T10:07:16 +05:00\",\"latitude\":42.3367881,\"longitude\":-71.0895233},{\"id\":5,\"route\":\"175\",\"address\":\"Schweikerts Walk\",\"registered\":\"2010-12-07T02:09:31 +05:00\",\"latitude\":42.292160034,\"longitude\":-71.0691680},{\"id\":6,\"route\":\"136\",\"address\":\"Dunne Place\",\"registered\":\"2011-05-15T17:26:23 +04:00\",\"latitude\":42.42391204,\"longitude\":-71.0823822},{\"id\":7,\"route\":\"149\",\"address\":\"Onderdonk Avenue\",\"registered\":\"1996-12-16T05:55:15 +05:00\",\"latitude\":42.328723,\"longitude\":-71.0900955},{\"id\":8,\"route\":\"104\",\"address\":\"Jerome Avenue\",\"registered\":\"2001-07-29T13:28:08 +04:00\",\"latitude\":42.398036,\"longitude\":-71.130851},{\"id\":9,\"route\":\"110\",\"address\":\"Dwight Street\",\"registered\":\"2012-01-12T15:25:48 +05:00\",\"latitude\":42.412990,\"longitude\":-71.191760}]}";

    NSData *data = [stringOfJSON dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    return dictionary;
}

- (void)setDummyLocationToBoston
{
    CLLocationCoordinate2D boston = CLLocationCoordinate2DMake(42.36, -71.06);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(boston, 1000, 1000);
    [self.mapView setRegion:region animated:NO];
    boston.latitude -= self.mapView.region.span.latitudeDelta * 0.3;
    [self.mapView setCenterCoordinate:boston];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.bus.buses count] == 0) || (index >= [self.bus.buses count])) {
        return nil;
    }

    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.titleText = self.bus.buses[index][@"address"];
    pageContentViewController.pageIndex = index;

    double fLat = [self.bus.buses[index][@"latitude"] doubleValue];
    double fLng = [self.bus.buses[index][@"longitude"] doubleValue];
    CLLocationDegrees *lat = &fLat;
    CLLocationDegrees *lng = &fLng;
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake(*lat, *lng);

    [self.mapView setCenterCoordinate:point.coordinate animated:YES];

    return pageContentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController *) viewController).pageIndex;
    
    if((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;

    if (index == NSNotFound) {
        return nil;
    }

    index++;
    if (index == [self.bus.buses count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.bus.buses count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
