//
//  FloatingActionButton.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "FloatingActionButton.h"

@interface FloatingActionButton ()

// 是否移动
@property (nonatomic, assign) BOOL isMoved;

@end

@implementation FloatingActionButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        self.layer.cornerRadius = self.frame.size.width / 2;
    }
    return self;
}

- (id)initInKeyWindowWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self performSelector:@selector(addButtonToKeyWindow) withObject:nil afterDelay:0.f];
        self.backgroundColor = [UIColor blackColor];
        self.layer.borderColor = [UIColor yellowColor].CGColor;
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.layer.borderWidth = 4.0f;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)addButtonToKeyWindow {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    // 当前触摸的点
    CGPoint current = [touch locationInView:self];
    // 上次触摸的点
    CGPoint previous = [touch previousLocationInView:self];
    CGPoint center = self.center;
    center.x += current.x - previous.x;
    center.y += current.y - previous.y;
    
    // 限制移动范围
    
    CGFloat xMin = self.frame.size.width * 0.5f;
    CGFloat xMax = WIDTH - xMin;
    
    CGFloat yMin = self.frame.size.height * 0.5f;
    CGFloat yMax = HEIGHT - self.frame.size.height * 0.5f;
    
    if (center.x > xMax) center.x = xMax;
    if (center.x < xMin) center.x = xMin;
    if (center.y > yMax) center.y = yMax;
    if (center.y < yMin) center.y = yMin;
    
    self.center = center;
    
    //移动距离大于0.5才判断为移动了(提高容错性)
    if (current.x-previous.x>=0.5 || current.y - previous.y>=0.5) {
        self.isMoved = YES;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.isMoved) {
        // 如果没有移动, 则调用父类方法, 触发button的点击事件
        [super touchesEnded:touches withEvent:event];
    }
    self.isMoved = NO;
    // 回到一定范围
    CGFloat x = self.frame.size.width * 0.5f;
    [UIView animateWithDuration:0.25f animations:^{
        CGPoint center = self.center;
        center.x = self.center.x > WIDTH * 0.5f ? WIDTH - x - 20: x + 20;
        self.center = center;
    }];
    
    // 关闭高亮状态
    [self setHighlighted:NO];
}

//外界因素取消touch事件，如进入电话
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
