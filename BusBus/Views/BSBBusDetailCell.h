//
//  BSBBusDetailView.h
//  BusBus
//
//  Created by Fabian Canas on 5/16/14.
//
//

#import <UIKit/UIKit.h>

@interface BSBBusDetailCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *routeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stopLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end
