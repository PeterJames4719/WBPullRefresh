//
//  CustomTipView.m
//  WBPullRefresh
//
//  Created by wubing on 2017/8/10.
//  Copyright © 2017年 wubing. All rights reserved.
//

#import "WBPullRefreshDefaultTipView.h"
#import "UIView+wbLayout.h"

@interface WBPullRefreshDefaultTipView()
@end

@implementation WBPullRefreshDefaultTipView

+ (instancetype)tipViewWithText:(NSString *)tip bgColors:(NSArray<UIColor *> *)colors {
    return [self tipViewWithText:tip textColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:13] bgColors:colors];
}

+ (instancetype)tipViewWithText:(NSString *)tip textColor:(UIColor *)textColor textFont:(UIFont *)font bgColors:(NSArray<UIColor *> *)colors {
    WBPullRefreshDefaultTipView *tipView = [[WBPullRefreshDefaultTipView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    tipView.appearAnimationDuration = 0.25;
    tipView.disappearAnimationDuration = 0.25;
    tipView.textLabel.text = tip;
    tipView.textLabel.font = font;
    tipView.textLabel.textColor = textColor;
    tipView.colors = colors;
    return tipView;
}

- (void)setColors:(NSArray<UIColor *> *)colors {
    if (_colors != colors) {
        _colors = colors;
        if (colors.count == 1) {
            self.backgroundColor = [colors firstObject];
        }
        [self setNeedsDisplay];
    }
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor whiteColor];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:label];
        _textLabel = label;
    }
    return _textLabel;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.colors.count >= 2) {
        NSInteger count = self.colors.count;
        CGFloat c[count * 4];
        for (UIColor *color in self.colors) {
            NSInteger index = [self.colors indexOfObject:color];
            [color getRed:(c+index*4+0) green:(c+index*4+1) blue:(c+index*4+2) alpha:(c+index*4+3)];
        }
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGColorSpaceRef RGBColorSpace=CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient=CGGradientCreateWithColorComponents(RGBColorSpace, c, NULL, count);
        CGColorSpaceRelease(RGBColorSpace);
        CGPoint startPoint=CGPointMake(0, self.height / 2.0);
        CGPoint endPoint=CGPointMake(self.width, self.height / 2.0);
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsAfterEndLocation);
    }
}

#pragma mark - WBPullRefreshTipViewProtocol

- (WBPullRefreshContentViewAnimationBlock)willAppearBlock
{
    return ^(UIView *contentView){
        self.width = contentView.width;
        self.top = contentView.bottom;
    };
}

- (WBPullRefreshContentViewAnimationBlock)appearBlock
{
    return ^(UIView *contentView){
        self.bottom = 0;
    };
}

- (WBPullRefreshContentViewAnimationBlock)disappearBlock
{
    return ^(UIView *contentView){
        self.bottom = contentView.bottom;
    };
}



@end
