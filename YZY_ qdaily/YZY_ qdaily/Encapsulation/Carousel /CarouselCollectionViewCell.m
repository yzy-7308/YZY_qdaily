//
//  CarouselCollectionViewCell.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "CarouselCollectionViewCell.h"

@interface CarouselCollectionViewCell ()

@property (nonatomic, retain)UIImageView *myImageView;

@property (nonatomic, retain)UILabel *myLabel;

@end

@implementation CarouselCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_myImageView];
        _myImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _myLabel.font = [UIFont systemFontOfSize:24];
        _myLabel.textColor = [UIColor whiteColor];
        _myLabel.numberOfLines = 0;
        _myLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_myLabel];
        
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    
    
    
}

- (void)setCarouselTitle:(NSString *)carouselTitle {

    
    
}

- (void)layoutSubviews {

    
    
}


@end
