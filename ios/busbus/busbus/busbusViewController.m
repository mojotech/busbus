//
//  busbusViewController.m
//  busbus
//
//  Created by Sam Saccone on 9/19/13.
//  Copyright (c) 2013 Sam Saccone. All rights reserved.
//

#import "busbusViewController.h"

@interface busbusViewController ()

@end

@implementation busbusViewController

- (void)viewDidLoad
{
    CLLocationCoordinate2D boston = CLLocationCoordinate2DMake(42.36, -71.06);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(boston, 1000, 1000);
    [map setRegion:region animated:TRUE];

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
