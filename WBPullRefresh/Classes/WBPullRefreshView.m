//
//  WBPullRefreshView.m
//  WBPullRefresh
//
//  Created by wubing on 2017/8/7.
//  Copyright © 2017年 wubing. All rights reserved.
//

#import "WBPullRefreshView.h"

NSString *const WBPullRefreshKeyPathContentOffset = @"contentOffset";
NSString *const WBPullRefreshKeyPathContentInset = @"contentInset";
NSString *const WBPullRefreshKeyPathContentSize = @"contentSize";

@implementation WBPullRefreshView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.state = WBPullRefreshStateIdle;
    self.backgroundColor = [UIColor clearColor];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    [self removeObservers];
    
    if (newSuperview) {
        // 设置宽度
        CGRect tmpRect = self.frame;
        tmpRect.origin.x = 0;
        tmpRect.origin.y = -tmpRect.size.height;
        tmpRect.size.width = newSuperview.bounds.size.width;
        self.frame = tmpRect;
        
        _scrollView = (UIScrollView *)newSuperview;
        _scrollView.alwaysBounceVertical = YES;
        
        // 添加监听
        [self addObservers];
    }
}

- (void)setContentView:(UIView<WBPullRefreshContentViewProtocol> *)contentView {
    if (_contentView != contentView) {
        [_contentView removeFromSuperview];
        _contentView = nil;
        _contentView = contentView;
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:contentView];
    }
}

#pragma mark - KVO监听
- (void)addObservers {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:WBPullRefreshKeyPathContentOffset options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:WBPullRefreshKeyPathContentSize options:options context:nil];
}

- (void)removeObservers {
    [self.superview removeObserver:self forKeyPath:WBPullRefreshKeyPathContentOffset];
    [self.superview removeObserver:self forKeyPath:WBPullRefreshKeyPathContentSize];;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:WBPullRefreshKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    }
}

#pragma mark - Subclass implemente

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}
- (void)beginRefreshing{}
- (void)endRefreshing{}
- (void)showTipForTime:(CGFloat)time{}

@end



