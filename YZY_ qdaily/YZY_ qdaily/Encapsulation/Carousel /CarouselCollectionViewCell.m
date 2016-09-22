//
//  CarouselCollectionViewCell.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "CarouselCollectionViewCell.h"
#import <Masonry.h>

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
        _myImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_myImageView];
        _myImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _myLabel.backgroundColor = [UIColor whiteColor];
        _myLabel.font = [UIFont systemFontOfSize:24];
        _myLabel.textColor = [UIColor whiteColor];
        _myLabel.numberOfLines = 0;
        _myLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_myLabel];
        
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    
    _image = image;
    _myImageView.image = _image;
    
}

- (void)setCarouselTitle:(NSString *)carouselTitle {
    
    _carouselTitle = carouselTitle;
    _myLabel.text = _carouselTitle;
    
}

- (void)layoutSubviews {
    
    _myImageView.frame = self.bounds;
    [_myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-20);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(20);
    }];
    
    
}


@end
