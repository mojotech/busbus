//
//  busbusViewController.m
//  busbus
//
//  Created by Sam Saccone on 9/19/13.
//  Copyright (c) 2013 Sam Saccone. All rights reserved.
//

#import "busbusViewController.h"
#import "Bus.h"

@interface busbusViewController ()
@property (strong, nonatomic) bustListTable *busListController;
@end

@implementation busbusViewController

- (void)viewDidLoad
{
    CLLocationCoordinate2D boston = CLLocationCoordinate2DMake(42.36, -71.06);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(boston, 1000, 1000);
    [map setRegion:region animated:NO];
    boston.latitude -= map.region.span.latitudeDelta * 0.3;
    [map setCenterCoordinate:boston];
    
    [super viewDidLoad];

	
    self.busListController = [[bustListTable alloc] init];

    [busList setDelegate:self.busListController];
    [busList setDataSource:self.busListController];
    
    
    // obviously this needs to be moved into a collection
    NSArray *buses = [self.busListController busList];
    
    for(NSInteger i = 0; i < buses.count; ++i) {
        MKPointAnnotation *marker = [[MKPointAnnotation alloc] init];
        Bus *bus = [buses objectAtIndex:i];
        
        [marker setCoordinate:bus.location];
        [marker setTitle:bus.id];
        
        [map addAnnotation:marker];
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
