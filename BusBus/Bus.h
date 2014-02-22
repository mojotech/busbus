//
//  Bus.h
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <Mantle.h>

@interface Bus : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSArray *buses;

@end

@interface BusItem : MTLModel <MTLJSONSerializing>

@property(nonatomic, strong) NSNumber *latitude;
@property(nonatomic, strong) NSNumber *longitude;
@property(nonatomic, strong) NSNumber *id;
@property(nonatomic, strong) NSNumber *route;
@property(nonatomic, strong) NSString *address;

+ (NSDictionary *)JSONKeyPathsByPropertyKey;

@end
