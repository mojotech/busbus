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
    self.stop.text = self.busStop;
}

- (void)customizeInterface
{
    self.label.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:84.0f];
    self.view.backgroundColor = [UIColor clearColor];
}

@end
