//
//  UIBarButtonItem+SetImage_Click.h
//  YZY_ qdaily
//
//  Created by dllo on 16/9/26.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Callback)();

@interface UIBarButtonItem (SetImage_Click)

+ (UIBarButtonItem *)getBarButtonItemWithImage: (UIImage *)image target:(Callback)block;

@end
