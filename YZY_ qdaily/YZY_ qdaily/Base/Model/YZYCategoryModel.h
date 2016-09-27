//
//  YZYCategoryModel.h
//  YZY_ qdaily
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "BaseModel.h"

@interface YZYCategoryModel : BaseModel

@property (nonatomic, assign)NSInteger myId;

@property (nonatomic, copy)NSString *title;

@property (nonatomic, copy)NSString *normal;

@property (nonatomic, copy)NSString *normal_hl;

@property (nonatomic, copy)NSString *image_lab;

@property (nonatomic, copy)NSString *image_experiment;

@end
