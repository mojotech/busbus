//
//  BSBPassage.m
//  BusBus
//
//  Created by Fabian Canas on 5/18/14.
//
//

#import "BSBPassage.h"
#import <OHMKit/ObjectMapping.h>

@implementation BSBPassage

+ (void)load
{
    OHMMappable(self);
    OHMSetMapping(self, @{@"trip_update" : NSStringFromSelector(@selector(tripUpdate))});
}

@end
