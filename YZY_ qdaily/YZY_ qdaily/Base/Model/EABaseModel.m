//
//  BaseModel.m
//  EAKit
//
//  Created by Eiwodetianna on 16/9/19.
//  Copyright © 2016年 Eiwodetianna. All rights reserved.
//

#import "EABaseModel.h"

@implementation EABaseModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (EABaseModel *)modelWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
