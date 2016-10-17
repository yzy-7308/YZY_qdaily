//
//  YZYoptionsModel.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/6.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "YZYoptionsModel.h"
#import "YZYauthorModel.h"

@implementation YZYoptionsModel

- (void)dealloc {
    [_praise_count release];
    [_author release];
    [_myId release];
    [_content release];
    [_myImage release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.myId = value;
    }if ([key isEqualToString:@"image"]) {
        self.myImage = value;
    }
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"author"]) {
        self.author = [YZYauthorModel modelWithDic:value];
        return;
    }
    [super setValue:value forKey:key];
}

@end
