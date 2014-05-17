//
//  BSBBusCollectionViewController.m
//  BusBus
//
//  Created by Fabian Canas on 5/17/14.
//
//

#import "BSBBusCollectionViewController.h"
#import "BSBBusDetailCell.h"
#import "BSBBus.h"

static NSString * const BSBBusCellReuseIdentifier = @"BSBBusDetailCell";

@interface BSBBusCollectionViewController () <UICollectionViewDelegateFlowLayout>

@end

@implementation BSBBusCollectionViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    ((UICollectionViewFlowLayout *)layout).itemSize = CGSizeMake(320, 250);
    ((UICollectionViewFlowLayout *)layout).minimumInteritemSpacing = 0;
    ((UICollectionViewFlowLayout *)layout).minimumLineSpacing = 0;
    
    if (self == nil) {
        return nil;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView setPagingEnabled:YES];
    [self.collectionView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.6]];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"BSBBusDetailCell" bundle:nil]
          forCellWithReuseIdentifier:BSBBusCellReuseIdentifier];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.buses.count;
}

- (void)setBuses:(NSArray *)buses
{
    _buses = [buses copy];
    [self.collectionView reloadData];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BSBBusDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BSBBusCellReuseIdentifier
                                                                           forIndexPath:indexPath];
    
    if (indexPath.item > self.buses.count) {
        return cell;
    }
    
    cell.routeLabel.text = ((BSBBus *)self.buses[indexPath.item]).busID;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(320, 250);
}

@end
