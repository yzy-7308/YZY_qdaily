//
//  YZYSearchesModel.h
//  YZY_ qdaily
//
//  Created by dllo on 16/10/10.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "BaseModel.h"
@class YZYPostModel;
@class YZYauthorModel;

@interface YZYSearchesModel : BaseModel

@property (nonatomic, retain)YZYPostModel *post;

@property (nonatomic, retain)YZYauthorModel *author;

@end
