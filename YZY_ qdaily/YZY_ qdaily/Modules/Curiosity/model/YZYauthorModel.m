//
//  YZYauthorModel.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/7.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "YZYauthorModel.h"

@implementation YZYauthorModel

- (void)dealloc {
    [_background_image release];
    [_myId release];
    [_myDescription release];
    [_avatar release];
    [_name release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.myId = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.myDescription = value;
    }
    
}

@end
