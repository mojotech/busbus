//
//  BOManager.m
//  BusBus
//
//  Created by Ryan on 4/2/14.
//
//

#import "BSBBusService.h"
#import "BSBBusStop.h"

#import <OHMKit/ObjectMapping.h>

@interface BSBBusService ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) BSBClient *client;

@property (nonatomic, strong) NSDate *lastBusFetchDate;
@property (nonatomic, strong) NSDate *lastStopFetchDate;

@end

@implementation BSBBusService

+ (void)load
{
    OHMMappable(self);
    OHMSetArrayClasses(self, @{NSStringFromSelector(@selector(busStops)) : [BSBBusStop class],
                               NSStringFromSelector(@selector(buses)) : [BSBBus class]});
}

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
        
        _sharedManager->_client = [BSBClient new];
        
        _sharedManager->_lastBusFetchDate = [NSDate distantPast];
        _sharedManager->_lastStopFetchDate = [NSDate distantPast];
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
    CLLocation *location = self.mockLocation?:[locations lastObject];
    // Negative horizontal accuracies indicate an invalid location.
    if (location.horizontalAccuracy > 0) {
        self.currentLocation = location;
        [self updateCurrentBusLocations];
        [self updateBusStops];
    }
}

- (void)updateCurrentBusLocations
{
    if ([self.lastBusFetchDate timeIntervalSinceNow] > -10) {
        return;
    }
    
    NSLog(@"fetch");
    
    [self.client fetchEntity:BSBServiceEntityBus
                nearLocation:self.currentLocation.coordinate
                      radius:1000
                  completion:^(NSArray *busLocations) {
                      [self setValue:busLocations forKey:NSStringFromSelector(@selector(buses))];
                      self.lastBusFetchDate = [NSDate date];
                  } failure:nil];
}

- (void)updateBusStops
{
    if ([self.lastStopFetchDate timeIntervalSinceNow] > -10000) {
        return;
    }
    
    NSLog(@"fetch");
    
    [self.client fetchEntity:BSBServiceEntityBusStop
                nearLocation:self.currentLocation.coordinate
                      radius:1000
                  completion:^(NSArray *busStops) {
                      [self setValue:busStops forKey:NSStringFromSelector(@selector(busStops))];
                      self.lastStopFetchDate = [NSDate date];
                  } failure:nil];
}

@end
