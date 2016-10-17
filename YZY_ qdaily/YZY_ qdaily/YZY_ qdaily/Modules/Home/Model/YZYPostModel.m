//
//  YZYPostModel.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "YZYPostModel.h"
#import "YZYCategoryModel.h"
#import "YZYColumnModel.h"


@implementation YZYPostModel

- (void)dealloc{
    [_record_count release];
    [_praise_count release];
    [_comment_count release];
    [_myId release];
    [_title release];
    [_myDescription release];
    [_myImage release];
    [_super_tag release];
    [_appview release];
    [_film_length release];
    [_datatype release];
    [_category release];
    [_column release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.myId = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.myDescription = value;
    }
    if ([key isEqualToString:@"image"]) {
        self.myImage = value;
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
