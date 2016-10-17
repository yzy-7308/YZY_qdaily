//
//  CategoriesOfNews.h
//  YZY_ qdaily
//
//  Created by dllo on 16/9/30.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YZYLeftSidebar;

@interface CategoriesOfNews : UIView

@property (nonatomic, retain)NSMutableArray *leftArray;

@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, copy) void (^JumpDetails)(YZYLeftSidebar *yzy);

@end
