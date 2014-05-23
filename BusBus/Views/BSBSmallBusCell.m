//
//  BSBSmallBusCell.m
//  BusBus
//
//  Created by Fabian Canas on 5/19/14.
//
//

#import "BSBSmallBusCell.h"

@implementation BSBSmallBusCell

- (void)setBus:(BSBBus *)bus
{
    _bus = bus;

    UIColor *busColor = [BSBAppearance colorForBus:bus];

    self.dot.layer.cornerRadius = self.dot.bounds.size.width / 2.;
    self.dot.backgroundColor = busColor;

    self.label.text = bus.routeID;
    self.label.textColor = busColor;
}

@end
