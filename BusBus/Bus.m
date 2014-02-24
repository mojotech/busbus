//
//  Bus.m
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import "Bus.h"
#import <Mantle.h>

@implementation Bus

+ (NSValueTransformer *)busesTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BusItem class]];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"buses"          : @"buses"
             };
}

@end

@implementation BusItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"route"       : @"route",
             @"nextStop"    : @"address",
             @"latitude"    : @"latitude",
             @"longitude"   : @"longitude",
             @"id"          : @"id"
             };
}

@end