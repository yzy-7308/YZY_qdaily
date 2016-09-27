//
//  YZYBaseModel.h
//  YZY_ qdaily
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "BaseModel.h"

@class YZYPostModel;

@interface YZYBaseModel : BaseModel

@property (nonatomic, copy)NSString *image;

@property (nonatomic, assign)NSInteger type;

@property (nonatomic, retain)YZYPostModel *post;


@end
