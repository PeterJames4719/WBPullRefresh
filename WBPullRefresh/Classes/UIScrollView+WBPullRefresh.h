//
//  UIScrollView+WBPullRefresh.h
//  WBPullRefresh
//
//  Created by wubing on 2017/8/7.
//  Copyright © 2017年 wubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBPullRefreshHeaderView.h"
#import "WBPullRefreshFooterView.h"

@interface UIScrollView(WBPullRefresh)
@property (strong, nonatomic) WBPullRefreshHeaderView *wb_headerView;
@property (strong, nonatomic) WBPullRefreshFooterView *wb_footerView;
@end
