//
//  NewsViewController.h
//  YZY_ qdaily
//
//  Created by dllo on 16/9/26.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "DetailsViewController.h"
@class YZYBaseModel;

@interface NewsViewController : DetailsViewController

<
UIWebViewDelegate
>

@property (nonatomic, retain) YZYBaseModel *yzy;


@end
