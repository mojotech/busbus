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

@interface BusBusViewController : UIViewController <MKMapViewDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIView *pageView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *busPinAnnotations;
@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) NSArray *buses;

@property (nonatomic, strong) UIView *pinView;

- (void)dropBusLocationsOnMap;
- (void)moveCenterByOffset:(CGPoint)offset from:(CLLocationCoordinate2D)coordinate;
- (UIImage *) imageWithView:(UIView *)view;

@end
