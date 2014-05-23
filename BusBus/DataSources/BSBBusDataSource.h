//
//  BSBBusDataSource.h
//  BusBus
//
//  Created by Fabian Canas on 5/22/14.
//
//

#import <Foundation/Foundation.h>

@interface BSBBusDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *buses;
@property (nonatomic, copy) NSString *cellReuseIdentifier;

@end
