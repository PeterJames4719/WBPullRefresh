//
//  CustomTipView.m
//  WBPullRefresh_Example
//
//  Created by 兵伍 on 2019/3/10.
//  Copyright © 2019年 bing. All rights reserved.
//

#import "CustomTipView.h"

@implementation CustomTipView

+ (instancetype)tipViewWithText:(NSString *)tip {
    CustomTipView *tipView = [[CustomTipView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    tipView.backgroundColor = [UIColor redColor];
    tipView.appearAnimationDuration = 0.25;
    tipView.disappearAnimationDuration = 0.25;
    tipView.textLabel.text = tip;
    return tipView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //self.textLabel.centerX = self.width / 2.0;
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

#pragma mark - WBPullRefreshTipViewProtocol

- (WBPullRefreshContentViewAnimationBlock)willAppearBlock
{
    return ^(UIView *contentView){
        self.width = contentView.width;
        self.bottom = contentView.bottom;
        self.transform = CGAffineTransformMakeScale(0.01, 1);
    };
}

- (WBPullRefreshContentViewAnimationBlock)appearBlock
{
    return ^(UIView *contentView){
        self.transform = CGAffineTransformIdentity;
    };
}

- (WBPullRefreshContentViewAnimationBlock)disappearBlock
{
    return ^(UIView *contentView){
        self.bottom = contentView.bottom;
    };
}


@end
