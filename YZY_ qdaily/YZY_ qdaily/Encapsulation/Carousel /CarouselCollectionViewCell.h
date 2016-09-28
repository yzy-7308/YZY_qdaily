//
//  CarouselCollectionViewCell.h
//  YZY_ qdaily
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YZYBaseModel;

@protocol CarouselViewDelegate <NSObject>

- (void)nursingNewsByCarousel:(YZYBaseModel  *)yzy;

@end

@interface CarouselCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain)YZYBaseModel *yzy;

@property (nonatomic, assign)id<CarouselViewDelegate>yzyzyzy;

@end
