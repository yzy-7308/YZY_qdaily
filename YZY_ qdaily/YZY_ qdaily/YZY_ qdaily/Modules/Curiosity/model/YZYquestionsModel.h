//
//  YZYquestionsModel.h
//  YZY_ qdaily
//
//  Created by dllo on 16/10/6.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "BaseModel.h"

@interface YZYquestionsModel : BaseModel

@property (nonatomic, retain)id myId;

@property (nonatomic, copy)NSString *title;

@property (nonatomic, copy)NSString *content;

@property (nonatomic, retain)id genre;

@property (nonatomic, retain)NSMutableArray *options;


@end
