//
//  PageContentViewController.m
//  BusBus
//
//  Created by Ryan on 2/24/14.
//
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self customizeInterface];

    self.label.text = self.titleText;
}

- (void)customizeInterface
{
    self.label.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:84.0f];
    self.view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.8/1.0];
}

@end
