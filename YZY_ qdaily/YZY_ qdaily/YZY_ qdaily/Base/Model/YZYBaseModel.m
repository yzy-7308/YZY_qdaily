//
//  YZYBaseModel.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "YZYBaseModel.h"
#import "YZYPostModel.h"
#import "YZYquestionsModel.h"

@implementation YZYBaseModel

- (void)dealloc {
    [_questions release];
    [_image release];
    [_post release];
    [super dealloc];
    
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)modelWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"post"]) {
        self.post = [YZYPostModel modelWithDic:value];
        return;
    }
    if ([key isEqualToString:@"questions"]) {
        NSArray *Arr = value;
        NSMutableArray *array = [NSMutableArray array];
        for (NSMutableDictionary *dic in Arr) {
            YZYquestionsModel *yzy = [YZYquestionsModel modelWithDic:dic];
            [array addObject:yzy];
        }
        self.questions = array;
        return;
    }

    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}


@end

