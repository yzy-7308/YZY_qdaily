//
//  YZYSearchesModel.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/10.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "YZYSearchesModel.h"
#import "YZYPostModel.h"
#import "YZYauthorModel.h"

@implementation YZYSearchesModel

- (void)dealloc {
    [_post release];
    [_author release];
    [super dealloc];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"author"]) {
        self.author = [YZYauthorModel modelWithDic:value];
        return;
    }
    if ([key isEqualToString:@"post"]) {
        self.post = [YZYPostModel modelWithDic:value];
        return;
    }
    [super setValue:value forKey:key];
}

@end
