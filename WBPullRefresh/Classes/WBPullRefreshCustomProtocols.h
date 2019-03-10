//
//  WBPullRefreshContentViewProtocol.h
//  WBPullRefresh
//
//  Created by wubing on 2017/8/8.
//  Copyright © 2017年 wubing. All rights reserved.
//

#ifndef WBPullRefreshContentViewProtocol_h
#define WBPullRefreshContentViewProtocol_h


@protocol WBPullRefreshContentViewProtocol <NSObject>

@required
- (void)progress:(CGFloat)progress;
- (void)startLoading;
- (void)stopLoading;

@end


typedef void (^WBPullRefreshContentViewAnimationBlock) (UIView *);

@protocol WBPullRefreshTipViewProtocol <NSObject>
@property (nonatomic, assign) CGFloat appearAnimationDuration;
@property (nonatomic, assign) CGFloat disappearAnimationDuration;

- (WBPullRefreshContentViewAnimationBlock)willAppearBlock;
- (WBPullRefreshContentViewAnimationBlock)appearBlock;
- (WBPullRefreshContentViewAnimationBlock)disappearBlock;

@end
#endif /* WBPullRefreshContentViewProtocol_h */
