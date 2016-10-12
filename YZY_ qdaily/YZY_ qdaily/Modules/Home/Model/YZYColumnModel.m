
//
//  YZYColumnModel.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 yzy. All rights reserved.
//



#import "YZYColumnModel.h"
#import "YZYShareModel.h"

@implementation YZYColumnModel

- (void)dealloc {
    
    [_myId release];
    [_subscriber_num release];
    [_post_count release];
    [_name release];
    [_myDescription release];
    [_icon release];
    [_myImage release];
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
        self.myId = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.myDescription = value;
    }
    if ([key isEqualToString:@"image"]) {
        self.myImage = value;
    }
}



@end


