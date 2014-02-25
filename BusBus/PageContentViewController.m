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
}

@end
