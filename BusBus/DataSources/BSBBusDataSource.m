//
//  BSBBusDataSource.m
//  BusBus
//
//  Created by Fabian Canas on 5/22/14.
//
//

#import "BSBBusDataSource.h"
#import "BSBBusPresenter.h"

@implementation BSBBusDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.buses.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell<BSBBusPresenter> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellReuseIdentifier
                                                                       forIndexPath:indexPath];
    
    if (indexPath.item > self.buses.count) {
        return cell;
    }
    
    BSBBus *bus = self.buses[indexPath.item];
    cell.bus = bus;
    
    return cell;
}

@end
