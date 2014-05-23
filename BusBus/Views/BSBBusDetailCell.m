//
//  BSBBusDetailView.m
//  BusBus
//
//  Created by Fabian Canas on 5/16/14.
//
//

#import "BSBBusDetailCell.h"

#import "BSBBus.h"

@interface BSBBusDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *routeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stopLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation BSBBusDetailCell

- (void)setBus:(BSBBus *)bus
{
    self.routeLabel.text = bus.routeID;
    self.stopLabel.text = bus.nextStopName;
    self.progressView.progressTintColor = [BSBAppearance colorForBus:bus];
}

@end
