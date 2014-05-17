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
    
    static BOManager *_sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[BOManager alloc] init];
        _sharedManager->_locationManager = [[CLLocationManager alloc] init];
        _sharedManager->_locationManager.delegate = self;
        
        _sharedManager->_client = [[BOClient alloc] init];
        
        [RACObserve(_sharedManager, currentLocation) subscribeNext:^(CLLocation *lastLocation) {
            [_sharedManager updateCurrentBusLocations];
        }];
    });
    self = _sharedManager;
    
    return self;
}

- (void)findCurrentLocation {
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    // Negative horizontal accuracies indicate an invalid location.
    if (location.horizontalAccuracy > 0) {
        self.currentLocation = location;
    }
}

- (void)updateCurrentBusLocations {
    [self.client busLocationsNearLocation:self.currentLocation.coordinate
                                completion:^(NSArray *busLocations) {
                                    self.currentBusses = busLocations;
                                } failure:nil];
}

+ (instancetype)sharedManager {
    return [self new];
}

@end
