//
//  BSBBusCollectionViewController.m
//  BusBus
//
//  Created by Fabian Canas on 5/17/14.
//
//

#import "BSBBusCollectionViewController.h"
#import "BSBBusDetailCell.h"

static NSString * const BSBBusCellReuseIdentifier = @"BSBBusDetailCell";

@interface BSBBusCollectionViewController ()

@end

@implementation BSBBusCollectionViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    
    if (self == nil) {
        return nil;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"BSBBusDetailCell" bundle:nil]
          forCellWithReuseIdentifier:BSBBusCellReuseIdentifier];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
