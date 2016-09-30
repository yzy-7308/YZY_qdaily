//
//  YZYColumnModel.h
//  YZY_ qdaily
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "BaseModel.h"

@class YZYShareModel;

@interface YZYColumnModel : BaseModel

@property (nonatomic, assign)NSInteger myId;

@property (nonatomic, copy)NSString *name;

@property (nonatomic, copy)NSString *myDescription;

@property (nonatomic, copy)NSString *icon;

@property (nonatomic, copy)NSString *image;

@property (nonatomic, copy)NSString *image_large;

@property (nonatomic, copy)NSString *content_provider;

@property (nonatomic, assign)NSInteger show_type;

@property (nonatomic, assign)NSInteger genre;

@property (nonatomic, assign)NSInteger subscriber_num;

@property (nonatomic, assign)NSInteger post_count;

@property (nonatomic, copy)NSString *sort_time;

@property (nonatomic, copy)NSString *column_tag;

@property (nonatomic, retain)YZYShareModel *share;

@property (nonatomic, assign)BOOL subscribe_status;


@end
