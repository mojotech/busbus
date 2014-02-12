
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.busListController = [[BusListTable alloc] init];

    [busListTable setDelegate:self.busListController];
    [busListTable setDataSource:self.busListController];
}
@end
