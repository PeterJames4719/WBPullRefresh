//
//  WBPullRefreshContentView.h
//  WBPullRefresh
//
//  Created by wubing on 2017/8/8.
//  Copyright © 2017年 wubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBPullRefreshCustomProtocols.h"

@interface WBPullRefreshContentView : UIView <WBPullRefreshContentViewProtocol>
@property (nonatomic, strong) UIImageView *gifView;
@property (nonatomic, strong) NSArray *images;

+ (instancetype)contentViewWithHeight:(CGFloat)height imagesArray:(NSArray<UIImage *> *)images;
@end
