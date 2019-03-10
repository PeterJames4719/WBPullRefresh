//
//  WBPullRefreshHeaderView.m
//  WBPullRefresh
//
//  Created by wubing on 2017/8/7.
//  Copyright © 2017年 wubing. All rights reserved.
//

#import "WBPullRefreshHeaderView.h"
#import "UIView+wbLayout.h"

@implementation WBPullRefreshHeaderView

+ (instancetype)headerViewWithHeight:(CGFloat)height contentView:(UIView <WBPullRefreshContentViewProtocol> *)contentView {
    WBPullRefreshHeaderView *headerView = [[WBPullRefreshHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, height)];
    headerView.contentView = contentView;
    return headerView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.state == WBPullRefreshStateRefreshing) {
        return;
    }
    
    CGFloat offsetY = self.scrollView.contentOffset.y;
    CGFloat happenOffsetY = - self.scrollView.contentInset.top;
    if (offsetY > happenOffsetY) {
        return;
    }

    CGFloat normal2pullingOffsetY = happenOffsetY - self.bounds.size.height;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.bounds.size.height;
    
    if (self.scrollView.isDragging) {
        [self.contentView progress:pullingPercent];
        if (self.state == WBPullRefreshStateIdle && offsetY < normal2pullingOffsetY) {
            self.state = WBPullRefreshStatePulling;
        } else if (self.state == WBPullRefreshStatePulling && offsetY >= normal2pullingOffsetY) {
            self.state = WBPullRefreshStateIdle;
        }
    } else if (self.state == WBPullRefreshStatePulling) {
        [self beginRefreshing];
    } else if (pullingPercent < 1) {
        [self.contentView progress:pullingPercent];
    }
}

- (void)setState:(WBPullRefreshState)state {
    WBPullRefreshState oldState = self.state;
    if (state == oldState) return;
    [super setState:state];
    
    // 状态
    if (state == WBPullRefreshStateIdle) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.25 animations:^{
                self.scrollView.wb_insetT = 0;
                self.bottom = 0;
            } completion:^(BOOL finished) {
                [self.contentView stopLoading];
            }];
        });
    } else if (state == WBPullRefreshStateRefreshing) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.25 animations:^{
                CGFloat top = self.bounds.size.height;
                // 增加滚动区域top
                self.scrollView.wb_insetT = top;
                // 设置滚动位置
                [self.scrollView setContentOffset:CGPointMake(0, -top) animated:NO];
            } completion:^(BOOL finished) {
                if (self.refreshingActionBlock) {
                    [self.contentView startLoading];
                    self.refreshingActionBlock();
                }
            }];
        });
    } else if (state == WBPullRefreshStateShowingTip) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.contentView stopLoading];
    
            CGFloat appearDuration = 0.25;
            UIView *tipView = self.tipViewBlock();
            if (tipView) {
                [self.tipView removeFromSuperview];
                self.tipView = nil;
                self.tipView = tipView;
                [self.scrollView insertSubview:tipView atIndex:0];
                
                WBPullRefreshContentViewAnimationBlock tipWillAppearBlock;
                
                if ([tipView respondsToSelector:@selector(willAppearBlock)]) {
                    tipWillAppearBlock = [(id <WBPullRefreshTipViewProtocol>)tipView willAppearBlock];
                    appearDuration = [(id <WBPullRefreshTipViewProtocol>)tipView appearAnimationDuration];
                }
                
                if (tipWillAppearBlock) {
                    tipWillAppearBlock(self);
                } else {
                    tipView.width = self.width;
                    tipView.bottom = self.bottom;
                }
                
            }
            [UIView animateWithDuration:appearDuration > 0 ? appearDuration : 0.25 animations:^{
                CGFloat tmp = 0;
                if (self.tipView) {
                    tmp = self.tipView.height;
                    WBPullRefreshContentViewAnimationBlock tipAppearBlock;
                    if ([tipView respondsToSelector:@selector(appearBlock)]) {
                        tipAppearBlock = [(id <WBPullRefreshTipViewProtocol>)tipView appearBlock];
                    }
                    
                    if (tipAppearBlock) {
                        tipAppearBlock(self);
                    }
                }
                self.scrollView.wb_insetT = tmp;
                self.bottom = self.tipView.top;
            } completion:^(BOOL finished) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.tipHoldTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    WBPullRefreshContentViewAnimationBlock tipDisappearBlock;
                    CGFloat disappearDuration = 0.25;
                    if ([tipView respondsToSelector:@selector(disappearBlock)]) {
                        tipDisappearBlock = [(id <WBPullRefreshTipViewProtocol>)tipView disappearBlock];
                        disappearDuration = [(id <WBPullRefreshTipViewProtocol>)tipView disappearAnimationDuration];
                    }
                    
                    [UIView animateWithDuration:disappearDuration > 0 ? disappearDuration : 0.25 animations:^{
                        if (tipDisappearBlock) {
                            tipDisappearBlock(self);
                        }
                    } completion:^(BOOL finished) {
                        [self.tipView removeFromSuperview];
                        self.tipView = nil;
                    }];
                    
                    self.state = WBPullRefreshStateIdle;
                });
            }];
        });
    }
}

- (void)triggleRefresh {
    self.scrollView.contentOffset = CGPointMake(0, -self.contentView.bounds.size.height);
    self.state = WBPullRefreshStateRefreshing;
}

- (void)beginRefreshing {
    if (self.state == WBPullRefreshStateRefreshing) {
        return;
    }
    self.state = WBPullRefreshStateRefreshing;
}

- (void)endRefreshing {
    if (self.state == WBPullRefreshStateIdle) {
        return;
    }
    self.state = WBPullRefreshStateIdle;
}

- (void)showTipForTime:(CGFloat)time {
    if (self.state == WBPullRefreshStateIdle) {
        return;
    }
    self.tipHoldTime = time;
    self.state = WBPullRefreshStateShowingTip;
}

@end
