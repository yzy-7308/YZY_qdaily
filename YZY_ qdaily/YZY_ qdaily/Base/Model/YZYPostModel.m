//
//  YZYPostModel.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "YZYPostModel.h"
#import "YZYCategoryModel.h"
#import "YZYColumnModel.h"


@implementation YZYPostModel

- (void)dealloc{
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.myId = (long)value;
    }
    if ([key isEqualToString:@"description"]) {
        self.myDescription = value;
    }
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"category"]) {
        self.category = [YZYCategoryModel modelWithDic:value];
        return;
    }
    if ([key isEqualToString:@"column"]) {
        self.column = [YZYColumnModel modelWithDic:value];
        return;
    }
    [super setValue:value forKey:key];
}


@end
