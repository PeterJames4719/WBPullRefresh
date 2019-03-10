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

+ (instancetype)tipViewWithText:(NSString *)tip {
    WBPullRefreshDefaultTipView *tipView = [[WBPullRefreshDefaultTipView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    tipView.appearAnimationDuration = 0.25;
    tipView.disappearAnimationDuration = 0.25;
    tipView.textLabel.text = tip;
    return tipView;
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
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef RGBColorSpace=CGColorSpaceCreateDeviceRGB();
    CGFloat colors[]={  254/255.0,81/255.0,0/255.0,1.0,
        254/255.0,121/255.0,0.0,1.0};
    CGGradientRef gradient=CGGradientCreateWithColorComponents(RGBColorSpace, colors, NULL, 2);
    CGColorSpaceRelease(RGBColorSpace);
    CGPoint startPoint=CGPointMake(0, 20);
    CGPoint endPoint=CGPointMake(self.width, 20);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsAfterEndLocation);
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
