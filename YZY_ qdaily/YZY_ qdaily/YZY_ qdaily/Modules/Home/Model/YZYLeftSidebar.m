//
//  YZYLeftSidebar.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/8.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "YZYLeftSidebar.h"

@implementation YZYLeftSidebar

- (void)dealloc {
    [_myId release];
    [_title release];
    [_normal release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.myId = value;
    }
}


@end
