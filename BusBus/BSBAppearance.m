//
//  BSBAppearance.m
//  BusBus
//
//  Created by Fabian Canas on 5/17/14.
//
//

#import "BSBBus.h"

static NSMutableDictionary *motionEffectDictionary;

@implementation BSBAppearance

+ (UIMotionEffect *)motionEffectForDepth:(NSInteger)depth
{
    if (motionEffectDictionary == nil) {
        motionEffectDictionary = [NSMutableDictionary dictionary];
    }
    
    UIMotionEffect *cachedEffect = motionEffectDictionary[@(depth)];
    
    if (cachedEffect != nil) {
        return cachedEffect;
    }
    
    // Set vertical effect
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-depth);
    verticalMotionEffect.maximumRelativeValue = @(depth);
    
    // Set horizontal effect
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-depth);
    horizontalMotionEffect.maximumRelativeValue = @(depth);
    
    // Create group to combine both
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    motionEffectDictionary[@(depth)] = group;
    
    return group;
}

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
    return [UIColor colorWithRed:46. / 255. green:151. / 255. blue:251. / 255. alpha:1.0];
}

+ (UIColor *)colorForBus:(BSBBus *)bus
{
    NSDictionary *registeredBuses = @{@11:[self red],
                                      @749:[self orangered],
                                      @459:[self bluegreen],
                                      @93:[self greenblue],
                                      @424:[self cyan],
                                      @7:[self purple],};
    return registeredBuses[@([bus.routeID integerValue])]?:[self moduloColor:[bus.routeID integerValue]];
}

+ (UIColor *)moduloColor:(NSUInteger)index
{
    NSArray *colors = @[[self red],
                        [self orangered],
                        [self bluegreen],
                        [self greenblue],
                        [self slate],
                        [self cyan],
                        [self purple],
                        [self brown],
                        [self green],
                        ];
    return colors[index % colors.count];
}

+ (UIColor *)pinTextColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)red
{
    // 200 0   23
    return [UIColor colorWithRed:208. / 255 green:18./255 blue:44. / 255 alpha:1.0];
}

+ (UIColor *)orangered
{
    return [UIColor colorWithRed:251. / 255 green:94. / 255 blue:25./ 255 alpha:1.0];
}

+ (UIColor *)bluegreen
{
    return [UIColor colorWithRed:88. / 255 green:195. / 255 blue:232. / 255 alpha:1.0];
}

+ (UIColor *)greenblue
{
    return [UIColor colorWithRed:51. / 255 green:222. / 255 blue:138. / 255 alpha:1.0];
}

+ (UIColor *)slate
{
    return [UIColor colorWithRed:57. / 255 green:96. / 255 blue:129. / 255 alpha:1.0];
}

+ (UIColor *)cyan
{
    return [UIColor colorWithRed:45. / 255 green:253. / 255 blue:242. / 255 alpha:1.0];
}

+ (UIColor *)purple
{
    return [UIColor colorWithRed:149. / 255 green:51. / 255 blue:250. / 255 alpha:1.0];
}

+ (UIColor *)brown
{
    return [UIColor colorWithRed:153. / 255 green:110. / 255 blue:75. / 255 alpha:1.0];
}

+ (UIColor *)green
{
    return [UIColor colorWithRed:128. / 255 green:189. / 255 blue:123. / 255 alpha:1.0];
}

@end
