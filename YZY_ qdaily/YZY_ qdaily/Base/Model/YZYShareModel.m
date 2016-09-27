//
//  YZYShareModel.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "YZYShareModel.h"

@implementation YZYShareModel

- (void)dealloc {
    [_url release];
    [_title release];
    [_text release];
    [_image release];
    [super dealloc];
}

@end
