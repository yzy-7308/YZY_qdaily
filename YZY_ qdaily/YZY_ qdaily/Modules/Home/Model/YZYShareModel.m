//
//  YZYShareModel.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "YZYShareModel.h"

@implementation YZYShareModel

- (void)dealloc {
    [_url release];
    [_title release];
    [_text release];
    [_myImage release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"image"]) {
        self.myImage = value;
    }
}



@end
