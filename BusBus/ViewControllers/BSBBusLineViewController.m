//
//  BSBBusLineViewController.m
//  BusBus
//
//  Created by Fabian Canas on 5/19/14.
//
//

#import "BSBBusLineViewController.h"
#import <Masonry/Masonry.h>
#import "BSBSmallBusCell.h"

static NSString * const BSBBusLineCellReuseIdentifier = @"BSBBusLineCellReuseIdentifier";

@interface BSBBusLineViewController () <UICollectionViewDelegateFlowLayout>

@end

@implementation BSBBusLineViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
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
    
//    CGFloat leftRightInset = (320 - kBSBBusLineGroupHeight)/2;
    
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"BSBSmallBusCell" bundle:nil]
          forCellWithReuseIdentifier:BSBBusLineCellReuseIdentifier];
    
//    self.collectionView.contentInset = UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset);
    
    UIToolbar *blurringBackgroundView = [[UIToolbar alloc] initWithFrame:CGRectZero];
    [self.view addSubview:blurringBackgroundView];
    [self.view sendSubviewToBack:blurringBackgroundView];
    
    UIView *superview = self.view;
    
    [blurringBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview);
    }];
}

//- (void)didMoveToParentViewController:(UIViewController *)parent{
//    [super didMoveToParentViewController:parent];
//    ((UICollectionViewFlowLayout *)self.collectionViewLayout).itemSize = self.collectionView.bounds.size;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     BSBSmallBusCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BSBBusLineCellReuseIdentifier
                                                                       forIndexPath:indexPath];
    
    BSBBus *bus = [self itemAtIndex:indexPath.item];
    
    cell.bus = bus;
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.buses.count == 0) {
        return 0;
    }
    
    NSUInteger multiplier = MAX(2, ceil( (self.view.bounds.size.width * 2) / ( self.buses.count * kBSBBusLineGroupHeight ) )) ;
    
    NSLog(@"mult: %d", (int) multiplier);
    
    return multiplier * self.buses.count;
}

- (void)setBuses:(NSArray *)buses
{
    _buses = [buses copy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat widthForEvenSpacing = (self.collectionView.bounds.size.width / self.buses.count);
    
    if (widthForEvenSpacing < kBSBBusLineGroupHeight) {
        widthForEvenSpacing = kBSBBusLineGroupHeight;
    }
    
    return CGSizeMake(widthForEvenSpacing, kBSBBusLineGroupHeight);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGPoint offsetInOut = *targetContentOffset;
    
    offsetInOut.x = (NSInteger)(offsetInOut.x / kBSBBusLineGroupHeight) * kBSBBusLineGroupHeight + kBSBBusLineGroupHeight/2.;
    
    *targetContentOffset = offsetInOut;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint scrollOffset = scrollView.contentOffset;
    CGRect bounds = self.view.bounds;
    
    scrollOffset.x += CGRectGetMidX(bounds);
    scrollOffset.y = kBSBBusLineGroupHeight / 2;
    
    NSIndexPath *path = [self.collectionView indexPathForItemAtPoint:scrollOffset];
    [self.delegate collectionViewSelectedBus:[self itemAtIndex:path.item]];
}

- (BSBBus *)itemAtIndex:(NSUInteger)index
{
    NSArray *buses = self.buses;
    return buses[index%buses.count];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGPoint offset = scrollView.contentOffset;
//    NSUInteger busCount = self.buses.count;
//    
//    NSUInteger indexAtCenter =
//    
//    
//    
//    NSUInteger itemIndexAtLeft = offset.x / kBSBBusLineGroupHeight;
//    NSUInteger itemIndexAtRight = (offset.x + self.view.bounds.size.width) / kBSBBusLineGroupHeight;
//    
//    
//    
//    if (itemIndexAtLeft < (busCount / 2) ) {
//        offset.x += busCount * kBSBBusLineGroupHeight;
//        [scrollView setContentOffset:offset];
//    } else if (itemIndexAtRight > ((busCount + busCount/2) + 1)) {
//        offset.x -= (busCount * kBSBBusLineGroupHeight - 1);
//        [scrollView setContentOffset:offset];
//    }
//    
}

@end
