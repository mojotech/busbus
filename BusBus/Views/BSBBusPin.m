//
//  BSBBusPin.m
//  BusBus
//
//  Created by Fabian Canas on 5/16/14.
//
//

#import "BSBBusPin.h"

@import QuartzCore;

@interface BSBBusPin ()
@property (nonatomic, strong) UILabel *pinTextLabel;
@property (nonatomic, strong) CALayer *circleLayer;
@end

static CGFloat kBSBBusPinUnselectedRadius = 7;
static CGFloat kBSBBusPinSelectedRadius = 15;

@implementation BSBBusPin

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self == nil) {
        return nil;
    }

    self.frame = CGRectMake(0, 0, 30, 30);
    
    _circleLayer = [CALayer layer];
    _circleLayer.bounds = self.bounds;
    _circleLayer.position = CGPointMake(15, 15);
    _circleLayer.cornerRadius = 15.;
    _circleLayer.shadowColor = [UIColor blackColor].CGColor;
    _circleLayer.shadowRadius = 1.;
    _circleLayer.shadowOpacity = 0.7;
    _circleLayer.shadowOffset = CGSizeZero;
    [self.layer addSublayer:_circleLayer];

    _pinTextLabel = [[UILabel alloc] initWithFrame:self.bounds];
    [_pinTextLabel setFont:[BSBAppearance appFontOfSize:12]];
    [_pinTextLabel setTextColor:[BSBAppearance pinTextColor]];
    [_pinTextLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_pinTextLabel];

    [self configurePinLayer];

    return self;
}

- (void)setColor:(UIColor *)color
{
    _color = [color copy];
    self.circleLayer.backgroundColor = _color.CGColor;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self setSelected:NO];
}

- (void)configurePinLayer
{
    [self setSelected:NO];
    self.color = [UIColor redColor];
}

- (void)setPinText:(NSString *)pinText
{
    _pinText = [pinText copy];
    self.pinTextLabel.text = _pinText;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        self.circleLayer.affineTransform = CGAffineTransformIdentity;
        self.pinTextLabel.hidden = NO;
    } else {
        self.circleLayer.affineTransform = CGAffineTransformMakeScale(0.5, 0.5);;
        self.pinTextLabel.hidden = YES;
    }
}

- (CAKeyframeAnimation *)animationForSelectState:(BOOL)selected
{
    NSArray *frameValues;
    NSValue *small = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1)];
    NSValue *growOvershoot = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)];
    NSValue *growRebound = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1)];
    NSValue *full = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)];
    
    // Overshoot and rebound on shrink
    NSValue *shrinkOvershoot = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4, 0.4, 1)];
    NSValue *shrinkRebound = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1)];
    
    if (selected) {
        frameValues = @[small, growOvershoot, growRebound, full];
    } else {
        frameValues = @[full, shrinkOvershoot, shrinkRebound, small];
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    [animation setValues:frameValues];
    
    [animation setKeyTimes:@[@(0.0),@(0.5),@(0.9),@(1.0)]];
    animation.fillMode = kCAFillModeForwards;
    animation.duration = .2;
    return animation;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    self.pinTextLabel.hidden = !selected;
    [self setSelected:selected];
    
    if (animated == NO) {
        return;
    }
    [self.circleLayer addAnimation:[self animationForSelectState:selected] forKey:@"popup"];
    [self.pinTextLabel.layer addAnimation:[self animationForSelectState:selected] forKey:@"popup"];
}

@end
