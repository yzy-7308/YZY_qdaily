//
//  YZYPostModel.h
//  YZY_ qdaily
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "BaseModel.h"

@class YZYCategoryModel;
@class YZYColumnModel;

@interface YZYPostModel : BaseModel

@property (nonatomic, assign)id myId;

@property (nonatomic, assign)NSInteger genre;

@property (nonatomic, copy)NSString *title;

@property (nonatomic, copy)NSString *myDescription;

@property (nonatomic, assign)NSInteger publish_time;

@property (nonatomic, copy)NSString *image;

@property (nonatomic, assign)NSInteger start_time;

@property (nonatomic, assign)NSInteger comment_count;

@property (nonatomic, assign)NSInteger praise_count;

@property (nonatomic, copy)NSString *super_tag;

@property (nonatomic, assign)NSInteger page_style;

@property (nonatomic, assign)NSInteger post_id;

@property (nonatomic, copy)NSString *appview;

@property (nonatomic, copy)NSString *film_length;

@property (nonatomic, copy)NSString *datatype;

@property (nonatomic, retain)YZYCategoryModel *category;

@property (nonatomic, retain)YZYColumnModel *column;

@property (nonatomic, assign)NSInteger record_count;

@end
