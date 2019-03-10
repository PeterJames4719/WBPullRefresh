//
//  CustomTipView.h
//  WBPullRefresh
//
//  Created by wubing on 2017/8/10.
//  Copyright © 2017年 wubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBPullRefreshCustomProtocols.h"

@interface WBPullRefreshDefaultTipView : UIView <WBPullRefreshTipViewProtocol>
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, assign) CGFloat appearAnimationDuration;
@property (nonatomic, assign) CGFloat disappearAnimationDuration;

+ (instancetype)tipViewWithText:(NSString *)tip;
@end
