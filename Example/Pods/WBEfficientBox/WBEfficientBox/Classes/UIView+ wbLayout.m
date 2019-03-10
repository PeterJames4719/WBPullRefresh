//
//  UIView+WBRefresh_Extention.m
//  WBRefresh
//
//  Created by peter on 2017/8/8.
//  Copyright © 2017年 wubing. All rights reserved.
//

#import "UIView+wbLayout.h"

#pragma mark - UIView(wbLayout)

@implementation UIView(wbLayout)

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)newheight {
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)newwidth {
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat)top {
    return CGRectGetMinY(self.frame);
}

- (void)setTop:(CGFloat)newtop {
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)left {
    return CGRectGetMinX(self.frame);
}

- (void)setLeft:(CGFloat)newleft {
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)newbottom {
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)right {
    return CGRectGetMaxX(self.frame);
}

- (void)setRight:(CGFloat)newright {
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerX {
    return CGRectGetMidX(self.frame);
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)centerY {
    return CGRectGetMidY(self.frame);
}


@end

#pragma mark - UIScrollView (wbLayout)

@implementation UIScrollView (wbLayout)

- (void)setWb_insetT:(CGFloat)wb_insetT
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = wb_insetT;
    self.contentInset = inset;
}

- (CGFloat)wb_insetT
{
    return self.contentInset.top;
}

- (void)setWb_insetB:(CGFloat)wb_insetB
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = wb_insetB;
    self.contentInset = inset;
}

- (CGFloat)wb_insetB
{
    return self.contentInset.bottom;
}

- (void)setWb_insetL:(CGFloat)wb_insetL
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = wb_insetL;
    self.contentInset = inset;
}

- (CGFloat)wb_insetL
{
    return self.contentInset.left;
}

- (void)setWb_insetR:(CGFloat)wb_insetR
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = wb_insetR;
    self.contentInset = inset;
}

- (CGFloat)wb_insetR
{
    return self.contentInset.right;
}

- (void)setWb_offsetX:(CGFloat)wb_offsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = wb_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)wb_offsetX
{
    return self.contentOffset.x;
}

- (void)setWb_offsetY:(CGFloat)wb_offsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = wb_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)wb_offsetY
{
    return self.contentOffset.y;
}

- (void)setWb_contentW:(CGFloat)wb_contentW
{
    CGSize size = self.contentSize;
    size.width = wb_contentW;
    self.contentSize = size;
}

- (CGFloat)wb_contentW
{
    return self.contentSize.width;
}

- (void)setWb_contentH:(CGFloat)wb_contentH
{
    CGSize size = self.contentSize;
    size.height = wb_contentH;
    self.contentSize = size;
}

- (CGFloat)wb_contentH
{
    return self.contentSize.height;
}
@end
