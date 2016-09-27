//
//  YZYColumnModel.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "YZYColumnModel.h"
#import "YZYShareModel.h"

@implementation YZYColumnModel

- (void)dealloc {
    
    [_name release];
    [_myDescription release];
    [_icon release];
    [_image release];
    [_image_large release];
    [_content_provider release];
    [_sort_time release];
    [_column_tag release];
    [_share release];
    [super dealloc];
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"share"]) {
        self.share = [YZYShareModel modelWithDic:value];
        return;
    }
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.myId = (long)value;
    }
    if ([key isEqualToString:@"description"]) {
        self.myDescription = value;
    }
}



@end
