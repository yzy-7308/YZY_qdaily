//
//  YZYauthorModel.h
//  YZY_ qdaily
//
//  Created by dllo on 16/10/7.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "YZYBaseModel.h"

@interface YZYauthorModel : YZYBaseModel

@property (nonatomic, retain)id myId;

@property (nonatomic, copy)NSString *myDescription;

@property (nonatomic, copy)NSString *avatar;

@property (nonatomic, copy)NSString *name;

@property (nonatomic, copy)NSString *background_image;

@end
