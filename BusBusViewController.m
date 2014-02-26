
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


    // This needs to be placed in to a method that returns a CCLocationCoordinate2DMake
    double fLat = [self.bus.buses[0][@"latitude"] doubleValue];
    double fLng = [self.bus.buses[0][@"longitude"] doubleValue];
    CLLocationDegrees *lat = &fLat;
    CLLocationDegrees *lng = &fLng;
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake(*lat, *lng);
    [self.mapView setCenterCoordinate:point.coordinate animated:YES];
    
    self.pageView.backgroundColor = [UIColor clearColor];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = (UITouch *)[touches anyObject];
    float start = [touch locationInView:self.view].y;
    if(start > 30 && self.pageView.center.y < 0)//touch was not in upper area of view AND pulldownView not visible
    {
        start = -1; //start is a CGFloat member of this view
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    float start = 0.0;
    
    if(start < 0)
    {
        return;
    }
    UITouch *touch = (UITouch *)[touches anyObject];
    CGFloat now = [touch locationInView:self.view].y;
    CGFloat diff = now - start;
    BOOL directionUp = diff < 0;//directionUp is a BOOL member of this view
    float nuCenterY = self.pageView.center.y + diff;
    self.pageView.center = CGPointMake(self.pageView.center.x, nuCenterY);
    start = now;
}


-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    BOOL directionUp = '\0';
    float start;
    if (directionUp)
    {
        //animate pulldownView out of visibel area
        [UIView animateWithDuration:.3 animations:^{self.pageView.center = CGPointMake(self.pageView.center.x, -roundf(self.view.bounds.size.height/2.));}];
    }
    else if(start>=0)
    {
        //animate pulldownView with top to mainviews top
        [UIView animateWithDuration:.3 animations:^{self.pageView.center = CGPointMake(self.pageView.center.x, roundf(self.pageView.bounds.size.height/2.));}];
    }
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

    NSString *stringOfJSON = @"{\"buses\":[{\"id\":0,\"route\":\"170\",\"address\":\"Northern Ave Opp Federal Court House \",\"registered\":\"2006-04-20T11:40:17 +04:00\",\"latitude\":42.402965,\"longitude\":-71.03627},{\"id\":1,\"route\":\"184\",\"address\":\"Northern Ave & Tide St\",\"registered\":\"2012-06-29T08:45:47 +04:00\",\"latitude\":42.3488,\"longitude\":-71.1600},{\"id\":2,\"route\":\"147\",\"address\":\"Devonshire St & State St \",\"registered\":\"2012-07-23T16:23:04 +04:00\",\"latitude\":42.3652687,\"longitude\":-71.0754089},{\"id\":3,\"route\":\"187\",\"address\":\"Causeway St. & North Station\",\"registered\":\"1990-03-10T16:45:38 +05:00\",\"latitude\":42.36484527,\"longitude\":-71.075546},{\"id\":4,\"route\":\"181\",\"address\":\"Northern Ave & Tide St\",\"registered\":\"2001-11-26T10:07:16 +05:00\",\"latitude\":42.3367881,\"longitude\":-71.0895233},{\"id\":5,\"route\":\"175\",\"address\":\"Summer St & South Station\",\"registered\":\"2010-12-07T02:09:31 +05:00\",\"latitude\":42.292160034,\"longitude\":-71.0691680},{\"id\":6,\"route\":\"136\",\"address\":\"Dunne Place\",\"registered\":\"2011-05-15T17:26:23 +04:00\",\"latitude\":42.42391204,\"longitude\":-71.0823822},{\"id\":7,\"route\":\"149\",\"address\":\"Onderdonk Avenue\",\"registered\":\"1996-12-16T05:55:15 +05:00\",\"latitude\":42.328723,\"longitude\":-71.0900955},{\"id\":8,\"route\":\"104\",\"address\":\"Jerome Avenue\",\"registered\":\"2001-07-29T13:28:08 +04:00\",\"latitude\":42.398036,\"longitude\":-71.130851},{\"id\":9,\"route\":\"110\",\"address\":\"Dwight Street\",\"registered\":\"2012-01-12T15:25:48 +05:00\",\"latitude\":42.412990,\"longitude\":-71.191760}]}";

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
    pageContentViewController.titleText = self.bus.buses[index][@"route"];
    pageContentViewController.busStop   = self.bus.buses[index][@"address"];
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
