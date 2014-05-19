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

@end

@interface BSBRoute : NSObject

/**
 An array of BSBDirectedRoute objects
 */
@property (nonatomic, strong) NSArray *directions;

@end
