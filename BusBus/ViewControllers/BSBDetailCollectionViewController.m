//
//  BSBBusCollectionViewController.m
//  BusBus
//
//  Created by Fabian Canas on 5/17/14.
//
//

#import "BSBDetailCollectionViewController.h"
#import "BSBBusDetailCell.h"
#import "BSBBus.h"

#import <Masonry/Masonry.h>

static NSString * const BSBBusCellReuseIdentifier = @"BSBBusDetailCell";

@interface BSBDetailCollectionViewController () <UICollectionViewDelegateFlowLayout>

@end

@implementation BSBDetailCollectionViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    ((UICollectionViewFlowLayout *)layout).itemSize = CGSizeMake(320, 250);
    ((UICollectionViewFlowLayout *)layout).minimumInteritemSpacing = 0;
    ((UICollectionViewFlowLayout *)layout).minimumLineSpacing = 0;
    ((UICollectionViewFlowLayout *)layout).sectionInset = UIEdgeInsetsZero;
    
    if (self == nil) {
        return nil;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView setPagingEnabled:YES];
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"BSBBusDetailCell" bundle:nil]
          forCellWithReuseIdentifier:BSBBusCellReuseIdentifier];
    
    UIToolbar *blurringBackgroundView = [[UIToolbar alloc] initWithFrame:CGRectZero];
    [self.view addSubview:blurringBackgroundView];
    [self.view sendSubviewToBack:blurringBackgroundView];
    
    UIView *superview = self.view;
    
    [blurringBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.buses.count;
}

- (void)setBuses:(NSArray *)buses
{
    _buses = [buses copy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BSBBusDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BSBBusCellReuseIdentifier
                                                                           forIndexPath:indexPath];
    
    if (indexPath.item > self.buses.count) {
        return cell;
    }
    
    cell.backgroundColor = [BSBAppearance moduloColor:indexPath.row%2 + 1];
    
    BSBBus *bus = self.buses[indexPath.item];
    
    cell.routeLabel.text = bus.routeID;
    cell.stopLabel.text = bus.nextStopName;
    cell.progressView.progressTintColor = [BSBAppearance colorForBus:bus];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.collectionView.frame.size;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint scrollOffset = scrollView.contentOffset;
    CGSize infoViewSize = CGSizeMake(320, 250);
    scrollOffset.x += infoViewSize.width/2.;
    scrollOffset.y = infoViewSize.height/2.;
    NSIndexPath *path = [self.collectionView indexPathForItemAtPoint:scrollOffset];
    [self.delegate collectionViewSelectedBus:self.buses[path.item]];
}

@end
