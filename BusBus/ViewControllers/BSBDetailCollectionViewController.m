//
//  BSBBusCollectionViewController.m
//  BusBus
//
//  Created by Fabian Canas on 5/17/14.
//
//

#import "BSBDetailCollectionViewController.h"
#import "BSBBus.h"
#import "BSBBusService.h"

#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BSBDetailCollectionViewController ()<UICollectionViewDelegateFlowLayout>

@end

@implementation BSBDetailCollectionViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    ((UICollectionViewFlowLayout *) layout).minimumInteritemSpacing = 0;
    ((UICollectionViewFlowLayout *) layout).minimumLineSpacing = 0;
    ((UICollectionViewFlowLayout *) layout).sectionInset = UIEdgeInsetsZero;

    if (self == nil) {
        return nil;
    }
    
    [RACObserve([BSBBusService sharedManager], buses) subscribeNext:^(id x) {
        self.buses = x;
    }];

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

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    [super didMoveToParentViewController:parent];
    ((UICollectionViewFlowLayout *) self.collectionViewLayout).itemSize = self.collectionView.bounds.size;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource collectionView:collectionView numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource collectionView:collectionView cellForItemAtIndexPath:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.collectionView.frame.size;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint scrollOffset = scrollView.contentOffset;
    CGSize infoViewSize = CGSizeMake(320, 250);
    scrollOffset.x += infoViewSize.width / 2.;
    scrollOffset.y = infoViewSize.height / 2.;
    NSIndexPath *path = [self.collectionView indexPathForItemAtPoint:scrollOffset];
    [self.delegate collectionViewSelectedBus:self.buses[path.item]];
}

@end
