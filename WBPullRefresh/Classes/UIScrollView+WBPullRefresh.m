//
//  UIScrollView+WBPullRefresh.m
//  WBPullRefresh
//
//  Created by wubing on 2017/8/7.
//  Copyright © 2017年 wubing. All rights reserved.
//

#import "UIScrollView+WBPullRefresh.h"
#import <objc/runtime.h>

@implementation UIScrollView(WBPullRefresh)

- (void)setWb_headerView:(WBPullRefreshHeaderView *)wb_headerView {
    if (wb_headerView != self.wb_headerView) {
        [self.wb_headerView removeFromSuperview];
        [self insertSubview:wb_headerView atIndex:0];
        objc_setAssociatedObject(self, @selector(wb_headerView), wb_headerView, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (WBPullRefreshHeaderView *)wb_headerView {
    return objc_getAssociatedObject(self, @selector(wb_headerView));
}

- (void)setWb_footerView:(WBPullRefreshFooterView *)wb_footerView {
    if (wb_footerView != self.wb_footerView) {
        [self.wb_footerView removeFromSuperview];
        [self insertSubview:wb_footerView atIndex:0];
        objc_setAssociatedObject(self, @selector(wb_footerView), wb_footerView, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (WBPullRefreshFooterView *)wb_footerView {
    return objc_getAssociatedObject(self, @selector(wb_footerView));
}

@end


