//
//  YZYoptionsModel.h
//  YZY_ qdaily
//
//  Created by dllo on 16/10/6.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "BaseModel.h"
@class YZYauthorModel;

@interface YZYoptionsModel : BaseModel


@property (nonatomic, retain)id myId;

@property (nonatomic, copy)NSString *content;

@property (nonatomic, copy)NSString *myImage;

@property (nonatomic, retain)id praise_count;

@property (nonatomic, assign)NSInteger perfect;

@property (nonatomic, retain)YZYauthorModel *author;


@end
