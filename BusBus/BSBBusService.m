//
//  BOManager.m
//  BusBus
//
//  Created by Ryan on 4/2/14.
//
//

#import "BSBBusService.h"

@interface BSBBusService ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) BOClient *client;
@end

@implementation BSBBusService

+ (instancetype)sharedManager
{
    return [self new];
}

- (instancetype)init
{
    static BSBBusService *_sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [super init];
        _sharedManager->_locationManager = [[CLLocationManager alloc] init];
        _sharedManager->_locationManager.delegate = self;
        
        _sharedManager->_client = [[BOClient alloc] init];
    });
    self = _sharedManager;
    
    return self;
}

- (void)findCurrentLocation
{
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    // Negative horizontal accuracies indicate an invalid location.
    if (location.horizontalAccuracy > 0) {
        self.currentLocation = location;
        [self updateCurrentBusLocations];
    }
}

- (void)updateCurrentBusLocations
{
    [self.client busLocationsNearLocation:self.currentLocation.coordinate
                                completion:^(NSArray *busLocations) {
                                    self.currentBusses = busLocations;
                                } failure:nil];
}

@end