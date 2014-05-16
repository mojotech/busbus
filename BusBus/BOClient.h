//
//  BOClient.h
//  BusBus
//
//  Created by Ryan on 3/31/14.
//
//

@import Foundation;
@import CoreLocation;
#import <ReactiveCocoa.h>

@interface BOClient : NSObject

- (RACSignal *)fetchBusLocationsNearUser: (CLLocationCoordinate2D)coordinate;

@end
