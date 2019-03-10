//
//  UIView+WBRefresh_Extention.h
//  WBRefresh
//
//  Created by peter on 2017/8/8.
//  Copyright © 2017年 wubing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(wbLayout)
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@end


@interface UIScrollView (wbLayout)
@property (assign, nonatomic) CGFloat wb_insetT;
@property (assign, nonatomic) CGFloat wb_insetB;
@property (assign, nonatomic) CGFloat wb_insetL;
@property (assign, nonatomic) CGFloat wb_insetR;

@property (assign, nonatomic) CGFloat wb_offsetX;
@property (assign, nonatomic) CGFloat wb_offsetY;

@property (assign, nonatomic) CGFloat wb_contentW;
@property (assign, nonatomic) CGFloat wb_contentH;
@end
