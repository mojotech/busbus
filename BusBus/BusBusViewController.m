
//
//  BusBusViewController.m
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import "BusBusViewController.h"
#import <MapKit/MapKit.h>

@interface BusBusViewController ()

@property (strong, nonatomic) BusListTable *busListController;

@end

@implementation BusBusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.busListController = [[BusListTable alloc] init];
    [busListTable setDelegate:self.busListController];
    [busListTable setDataSource:self.busListController];

    [self setDummyLocationToBoston];
}

- (void)setDummyLocationToBoston
{
    CLLocationCoordinate2D boston = CLLocationCoordinate2DMake(42.36, -71.06);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(boston, 1000, 1000);
    [mapView setRegion:region animated:NO];
    boston.latitude -= mapView.region.span.latitudeDelta * 0.3;
    [mapView setCenterCoordinate:boston];
}

@end