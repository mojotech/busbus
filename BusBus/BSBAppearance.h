//
//  BSBAppearance.h
//  BusBus
//
//  Created by Fabian Canas on 5/17/14.
//
//

#import <Foundation/Foundation.h>

@class BSBBus;

@interface BSBAppearance : NSObject

+ (void)styleNavigationBar:(UINavigationBar *)navigationBar;

+ (UIColor *)tintColor;

+ (UIFont *)appFontOfSize:(CGFloat)size;

+ (UIFont *)appFont;

+ (UIFont *)lightAppFontOfSize:(CGFloat)size;

+ (UIColor *)pinTextColor;

+ (UIColor *)reddish;

+ (UIColor *)orangered;

+ (UIColor *)bluegreen;

+ (UIColor *)greenblue;

+ (UIColor *)pinkish;

+ (UIColor *)colorForBus:(BSBBus *)bus;

+ (UIColor *)moduloColor:(NSUInteger)index;

@end
