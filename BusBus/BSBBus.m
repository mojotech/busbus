//
//  Bus.m
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import "BSBBus.h"
#import <OHMKit/ObjectMapping.h>

@interface BSBBus ()
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

@property (nonatomic, readwrite, strong) MKPointAnnotation *annotation;
@end

@implementation BSBBus

+ (void)load
{
    OHMMappable(self);
    OHMSetMapping(self, @{@"nextStop" : NSStringFromSelector(@selector(address))});
}

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}

- (MKPointAnnotation *)annotation
{
    if (_annotation == nil) {
        _annotation = [[MKPointAnnotation alloc] init];
        _annotation.coordinate = self.coordinate;
    }
    return _annotation;
}

@end