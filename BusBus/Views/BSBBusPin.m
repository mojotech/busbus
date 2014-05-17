//
//  BSBBusPin.m
//  BusBus
//
//  Created by Fabian Canas on 5/16/14.
//
//

#import "BSBBusPin.h"

@interface BSBBusPin ()
@property (nonatomic, strong) UILabel *pinTextLabel;
@end

@implementation BSBBusPin

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self == nil) {
        return nil;
    }
    
    self.frame = CGRectMake(0, 0, 30, 30);
    
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
    self.layer.backgroundColor = _color.CGColor;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

- (void)configurePinLayer
{
    self.color = [UIColor redColor];
    self.layer.cornerRadius = self.bounds.size.height/2;
}

- (void)setPinText:(NSString *)pinText
{
    _pinText = [pinText copy];
    self.pinTextLabel.text = _pinText;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
