//
//  WBPullRefreshContentView.m
//  WBPullRefresh
//
//  Created by wubing on 2017/8/8.
//  Copyright © 2017年 wubing. All rights reserved.
//

#import "WBPullRefreshDefaultContentView.h"
#import "UIView+wbLayout.h"

@implementation WBPullRefreshContentView

+ (instancetype)contentViewWithHeight:(CGFloat)height imagesArray:(NSArray<UIImage *> *)images {
    WBPullRefreshContentView *headerContentView = [[WBPullRefreshContentView alloc] initWithFrame:CGRectMake(0, 0, 0, height)];
    headerContentView.images = images;
    return headerContentView;
}

- (UIImageView *)gifView {
    if (!_gifView) {
        _gifView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
        [self addSubview:_gifView];
    }
    return _gifView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.gifView.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
}

#pragma mark - WBPullRefreshContentViewProtocol

- (void)progress:(CGFloat)progress {
    if (progress < 0 || progress > 1) {
        return;
    }
    NSInteger imgCount = self.images.count;
    if (imgCount == 0) {
        return;
    }
    
    NSInteger index = (NSInteger)(progress * (imgCount - 1));
    UIImage *img = self.images[index];
    self.gifView.image = img;
}

- (void)startLoading {
    self.gifView.animationImages = self.images;
    self.gifView.animationDuration = 0.627;
    [self.gifView startAnimating];
}

- (void)stopLoading {
    [self.gifView stopAnimating];
}

@end
