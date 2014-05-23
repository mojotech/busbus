//
//  BSBAppearance.m
//  BusBus
//
//  Created by Fabian Canas on 5/17/14.
//
//

#import "BSBAppearance.h"

#import "BSBBus.h"

@implementation BSBAppearance

+ (void)styleNavigationBar:(UINavigationBar *)navigationBar
{
    [navigationBar setTitleTextAttributes:@{NSFontAttributeName : [BSBAppearance lightAppFontOfSize:26]}];
}

+ (UIFont *)lightAppFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:[self lightAppFontName] size:size];
}

+ (UIFont *)appFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:[self appFontName] size:size];
}

+ (UIFont *)appFont
{
    return [self appFontOfSize:17];
}

+ (NSString *)appFontName
{
    return @"HelveticaNeue-Light";
}

+ (NSString *)lightAppFontName
{
    return @"HelveticaNeue-UltraLight";
}

#pragma mark - Color

+ (UIColor *)tintColor
{
    return [UIColor colorWithRed:46./255. green:151./255. blue:251./255. alpha:1.0];
}

+ (UIColor *)colorForBus:(BSBBus *)bus
{
    return [self moduloColor:[bus.routeID integerValue]];
}

+ (UIColor *)moduloColor:(NSUInteger)index
{
    NSArray *colors = @[[self reddish],
                        [self orangered],
                        [self bluegreen],
                        [self greenblue],
                        [self pinkish]
                        ];
    return colors[index%colors.count];
}

+ (UIColor *)pinTextColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)reddish
{
    // 200 0   23
    return [UIColor colorWithRed:200./255 green:0 blue:23./255 alpha:1.0];
}

+ (UIColor *) orangered
{
    return [UIColor colorWithRed:254./255 green:67./255 blue:0 alpha:1.0];
}

+ (UIColor *) bluegreen
{
    return [UIColor colorWithRed:28./255 green:224./255 blue:113./255 alpha:1.0];
}

+ (UIColor *) greenblue
{
    return [UIColor colorWithRed:64./255 green:181./255 blue:231./255 alpha:1.0];
}

+ (UIColor *) pinkish
{
    return [UIColor colorWithRed:136./255 green:91./255 blue:53./255 alpha:1.0];
}



@end
