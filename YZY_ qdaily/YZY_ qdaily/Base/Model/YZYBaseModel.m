//
//  YZYBaseModel.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "YZYBaseModel.h"
#import "YZYPostModel.h"

@implementation YZYBaseModel

- (void)dealloc {
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
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}


@end

