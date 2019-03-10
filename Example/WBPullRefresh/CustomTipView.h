//
//  CustomTipView.h
//  WBPullRefresh_Example
//
//  Created by 兵伍 on 2019/3/10.
//  Copyright © 2019年 bing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WBPullRefresh/WBPullRefresh.h>
#import <WBEfficientBox/UIView+wbLayout.h>

@interface CustomTipView : UIView<WBPullRefreshTipViewProtocol>
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, assign) CGFloat appearAnimationDuration;
@property (nonatomic, assign) CGFloat disappearAnimationDuration;

+ (instancetype)tipViewWithText:(NSString *)tip;
@end


