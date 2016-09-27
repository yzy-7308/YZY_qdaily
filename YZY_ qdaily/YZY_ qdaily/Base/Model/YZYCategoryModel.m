//
//  YZYCategoryModel.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "YZYCategoryModel.h"

@implementation YZYCategoryModel

- (void)dealloc {
    [_title release];
    [_normal release];
    [_normal_hl release];
    [_image_lab release];
    [_image_experiment release];
    [super dealloc];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.myId = (long)value;
    }
    
}

@end
