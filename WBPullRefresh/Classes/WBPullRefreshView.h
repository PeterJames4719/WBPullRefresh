//
//  WBPullRefreshView.h
//  WBPullRefresh
//
//  Created by wubing on 2017/8/7.
//  Copyright © 2017年 wubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBPullRefreshCustomProtocols.h"

/** 刷新控件的状态 */
typedef NS_ENUM(NSInteger, WBPullRefreshState) {
    /** 普通闲置状态 */
    WBPullRefreshStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
    WBPullRefreshStatePulling,
    /** 正在刷新中的状态 */
    WBPullRefreshStateRefreshing,
    /** 即将刷新的状态 */
    WBPullRefreshStateWillRefresh,
    /** 所有数据加载完毕，没有更多的数据了 */
    WBPullRefreshStateNoMoreData,
    WBPullRefreshStateShowingTip
};

@interface WBPullRefreshView : UIView
@property (strong, nonatomic) UIView <WBPullRefreshContentViewProtocol> *contentView;
@property (strong, nonatomic) UIView *tipView;
@property (weak, nonatomic, readonly) UIScrollView *scrollView;
@property (assign, nonatomic) WBPullRefreshState state;
@property (copy, nonatomic) void (^refreshingActionBlock) (void);
@property (assign, nonatomic) CGFloat tipHoldTime;
@property (copy, nonatomic) UIView * (^tipViewBlock) (void);

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
- (void)beginRefreshing;
- (void)endRefreshing;
- (void)showTipForTime:(CGFloat)time;

@end



