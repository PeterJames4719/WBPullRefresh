//
//  WBPullRefreshHeaderView.h
//  WBPullRefresh
//
//  Created by wubing on 2017/8/7.
//  Copyright © 2017年 wubing. All rights reserved.
//

#import "WBPullRefreshView.h"
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface WBPullRefreshHeaderView : WBPullRefreshView
- (void)triggleRefresh;
+ (instancetype)headerViewWithHeight:(CGFloat)height contentView:(UIView <WBPullRefreshContentViewProtocol> *)contentView;
@end
