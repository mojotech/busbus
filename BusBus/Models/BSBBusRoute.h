//
//  BSBRoute.h
//  BusBus
//
//  Created by Fabian Canas on 5/18/14.
//
//

#import <Foundation/Foundation.h>

@interface BSBDirectedRoute : NSObject

@property (nonatomic, copy) NSString *directionID;
@property (nonatomic, copy) NSString *directionName;

/**
 An array of BSBBusStop objects
 */
@property (nonatomic, strong) NSArray *stops;

/**
 An array of NSStrings that are Bus IDs
 */
@property (nonatomic, strong) NSArray *stopIDs;

@end

@interface BSBBusRoute : NSObject

/**
 An array of BSBDirectedRoute objects - Mapped from "direction"
 */
@property (nonatomic, strong) NSArray *directions;
@property (nonatomic, copy) NSString *routeName;
@property (nonatomic, copy) NSString *routeID;

@end
