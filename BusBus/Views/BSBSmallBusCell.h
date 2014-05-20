//
//  BSBSmallBusCell.h
//  BusBus
//
//  Created by Fabian Canas on 5/19/14.
//
//

#import <UIKit/UIKit.h>

#import "BSBBus.h"

@interface BSBSmallBusCell : UICollectionViewCell

@property (nonatomic, strong) BSBBus *bus;

@property (nonatomic, weak) IBOutlet UILabel *label;
@property (nonatomic, weak) IBOutlet UIView *dot;

@end
