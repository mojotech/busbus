//
//  Bus.m
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import "Bus.h"

@implementation Bus


- (id)initWithRoute:(NSString *)bRoute
                lat:(NSString *)bLat
                lng:(NSString *)bLng
                nextStop:(NSString *)bNextStop

{
    self = [super init];
    if (self) {
        self.route = bRoute;
        self.lat = bLat;
        self.lng = bLng;
        self.nextStop = bNextStop;
    }
    return self;
}

@end
