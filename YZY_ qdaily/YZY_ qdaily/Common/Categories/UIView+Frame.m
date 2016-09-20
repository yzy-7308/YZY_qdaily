//
//  UIView+SetFrame.m
//  LazyLoadingTest1
//
//  Created by Eiwodetianna on 15/1/15.
//  Copyright (c) 2015年 Eiwodetianna. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setX:(CGFloat)x {
    CGRect frame        = self.frame;
    frame.origin.x      = x;
    self.frame          = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame        = self.frame;
    frame.origin.y      = y;
    self.frame          = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center      = self.center;
    center.x            = centerX;
    self.center         = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center      = self.center;
    center.y            = centerY;
    self.center         = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame        = self.frame;
    frame.size.width    = width;
    self.frame          = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame        = self.frame;
    frame.size.height   = height;
    self.frame          = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size {
    CGRect frame        = self.frame;
    frame.size          = size;
    self.frame          = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame        = self.frame;
    frame.origin        = origin;
    self.frame          = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

//更改约束的方法
- (void)setContraint:(NSLayoutAttribute)attribute value:(CGFloat)value {
    for (NSLayoutConstraint* constraint in self.constraints) {
        if (constraint.firstAttribute == attribute) {
    constraint.constant = value;
        }
    }
}

@end
