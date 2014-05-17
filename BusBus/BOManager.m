//
//  BOManager.m
//  BusBus
//
//  Created by Ryan on 4/2/14.
//
//

#import "BOManager.h"

@interface BOManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) BOClient *client;

@end

@implementation BOManager

- (instancetype)init {
    if (self = [super init]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        _client = [[BOClient alloc] init];
        
        [RACObserve(self, currentLocation) subscribeNext:^(CLLocation *lastLocation) {
            [self updateCurrentBusLocations];
        }];
    }
    return self;
}

- (void)findCurrentLocation {
    self.isFirstUpdate = YES;
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    if (self.isFirstUpdate) {
//        self.isFirstUpdate = NO;
//        return;
//    }
//    
    CLLocation *location = [locations lastObject];
    if (location.horizontalAccuracy > 0) {
        self.currentLocation = location;
//        [self.locationManager stopUpdatingLocation];
    }
}

- (void)updateCurrentBusLocations {
    [self.client fetchBusLocationsNearUser:self.currentLocation.coordinate
                                completion:^(NSArray *busLocations) {
//                                    NSLog(@"locations: %@", busLocations);
                                    self.currentBusses = busLocations;
                                } failure:nil];
}


+ (instancetype)sharedManager {
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

@end
