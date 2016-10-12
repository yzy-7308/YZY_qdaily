//
//  YZYquestionsModel.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/6.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "YZYquestionsModel.h"
#import "YZYoptionsModel.h"

@implementation YZYquestionsModel

- (void)dealloc {
    [_myId release];
    [_title release];
    [_content release];
    [_genre release];
    [_options release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.myId = value;
    }
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"options"]) {
        NSArray *Arr = value;
        NSMutableArray *array = [NSMutableArray array];
        for (NSMutableDictionary *dic in Arr) {
            YZYoptionsModel *yzy = [YZYoptionsModel modelWithDic:dic];
            [array addObject:yzy];
        }
        self.options = array;
        return;
    }
    
    [super setValue:value forKey:key];
}

@end
