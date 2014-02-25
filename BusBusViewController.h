//
//  BusBusViewController.h
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PageContentViewController.h"
#import "Bus.h"

@interface BusBusViewController : UIViewController <MKMapViewDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIView *pageView;

@property (nonatomic, strong) NSArray *busPinAnnotations;
@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) Bus *bus;

- (NSDictionary *)convertDummyJSONData;
- (void)dropBusLocationsOnMap;

@end
