//
//  BSBBusLineViewController.m
//  BusBus
//
//  Created by Fabian Canas on 5/19/14.
//
//

#import "BSBBusLineViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Masonry/Masonry.h>

#import "BSBBusService.h"
#import "BSBBusDataSource.h"

@interface BSBBusLineViewController ()<UICollectionViewDelegateFlowLayout>
@end

@implementation BSBBusLineViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    ((UICollectionViewFlowLayout *) layout).minimumInteritemSpacing = 0;
    ((UICollectionViewFlowLayout *) layout).minimumLineSpacing = 0;
    ((UICollectionViewFlowLayout *) layout).sectionInset = UIEdgeInsetsZero;

    if (self == nil) {
        return nil;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];

    [self.collectionView registerNib:[UINib nibWithNibName:@"BSBSmallBusCell" bundle:nil]
          forCellWithReuseIdentifier:BSBBusCellReuseIdentifier];

    UIToolbar *blurringBackgroundView = [[UIToolbar alloc] initWithFrame:CGRectZero];
    [self.view addSubview:blurringBackgroundView];
    [self.view sendSubviewToBack:blurringBackgroundView];

    UIView *superview = self.view;

    [blurringBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview);
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource collectionView:self.collectionView cellForItemAtIndexPath:indexPath];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource collectionView:collectionView numberOfItemsInSection:section];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kBSBBusLineGroupHeight, kBSBBusLineGroupHeight);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGPoint offsetInOut = *targetContentOffset;

    offsetInOut.x = ((NSInteger) targetContentOffset->x) % (NSInteger) kBSBBusLineGroupHeight + kBSBBusLineGroupHeight / 2.;

    *targetContentOffset = offsetInOut;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint scrollOffset = scrollView.contentOffset;
    CGRect bounds = self.collectionView.bounds;

    scrollOffset.x += CGRectGetMidX(bounds);
    scrollOffset.y = CGRectGetMidY(bounds);

    NSIndexPath *path = [self.collectionView indexPathForItemAtPoint:scrollOffset];
    [self.delegate collectionViewSelectedBus:[self.dataSource busAtIndexPath:path]];
}

@end
