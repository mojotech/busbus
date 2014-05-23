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
#import "BSBBusService.h"
#import "BSBBusDataSource.h"

#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

static NSString * const BSBBusCellReuseIdentifier = @"BSBBusDetailCell";

@interface BSBDetailCollectionViewController () <UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) BSBBusDataSource *dataSource;
@end

@implementation BSBDetailCollectionViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    ((UICollectionViewFlowLayout *)layout).minimumInteritemSpacing = 0;
    ((UICollectionViewFlowLayout *)layout).minimumLineSpacing = 0;
    ((UICollectionViewFlowLayout *)layout).sectionInset = UIEdgeInsetsZero;
    
    if (self == nil) {
        return nil;
    }
    
    self.dataSource = [BSBBusDataSource new];
    
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
    self.dataSource.cellReuseIdentifier = @"BSBBusDetailCell";
    
    UIToolbar *blurringBackgroundView = [[UIToolbar alloc] initWithFrame:CGRectZero];
    [self.view addSubview:blurringBackgroundView];
    [self.view sendSubviewToBack:blurringBackgroundView];
    
    UIView *superview = self.view;
    
    [blurringBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview);
    }];
}

- (void)didMoveToParentViewController:(UIViewController *)parent{
    [super didMoveToParentViewController:parent];
    ((UICollectionViewFlowLayout *)self.collectionViewLayout).itemSize = self.collectionView.bounds.size;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource collectionView:collectionView numberOfItemsInSection:section];
}

- (void)setBuses:(NSArray *)buses
{
    _buses = [buses copy];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.dataSource.buses = _buses;
        [self.collectionView reloadData];
    });
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource collectionView:collectionView cellForItemAtIndexPath:indexPath];
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
