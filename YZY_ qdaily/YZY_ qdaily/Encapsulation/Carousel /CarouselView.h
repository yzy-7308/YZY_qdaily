//
//  CarouselView.h
//  YZY_ qdaily
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YZYBaseModel;


@interface CarouselView : UIView

@property (nonatomic, copy)NSMutableArray *YZYArray;

@property (nonatomic, copy) void (^dealWithYzy)(YZYBaseModel *yzy);

@end
