//
//  UIBarButtonItem+SetImage_Click.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/26.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "UIBarButtonItem+SetImage_Click.h"
#import "UIButton+Block.h"

@implementation UIBarButtonItem (SetImage_Click)

+ (UIBarButtonItem *)getBarButtonItemWithImage:(UIImage *)image target :(Callback)block {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 21, 21);
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        block();
    }];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barButtonItem;
}

+ (UIBarButtonItem *)getBarButtonItemWithButton:(UIButton *)button target:(Callback)block {
    [button setTitle:@"关闭" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barButtonItem;
}

@end
