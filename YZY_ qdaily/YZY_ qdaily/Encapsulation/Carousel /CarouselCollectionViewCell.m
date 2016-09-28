//
//  CarouselCollectionViewCell.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "CarouselCollectionViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "YZYBaseModel.h"
#import "YZYPostModel.h"


@interface CarouselCollectionViewCell ()

@property (nonatomic, retain)UIImageView *myImageView;

@property (nonatomic, retain)UILabel *myLabel;

@end

@implementation CarouselCollectionViewCell

- (void)dealloc {
    [_myImageView release];
    [_myLabel release];
    [super dealloc];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _myImageView.backgroundColor = [UIColor blackColor];
        _myImageView.alpha = 0.8;
        [self.contentView addSubview:_myImageView];
        _myImageView.userInteractionEnabled = YES;
        _myImageView.contentMode = UIViewContentModeScaleAspectFill;
        _myImageView.clipsToBounds = YES;
        // 轻拍手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_myImageView addGestureRecognizer:tap];
        [tap release];

        [_myImageView release];
        
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _myLabel.backgroundColor = [UIColor clearColor];
        _myLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
        _myLabel.textColor = [UIColor whiteColor];
        _myLabel.numberOfLines = 0;
        _myLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_myLabel];
        [_myLabel release];
    }
    return self;
}

- (void)setYzy:(YZYBaseModel *)yzy {
    if (_yzy != yzy) {
        [_yzy release];
        _yzy = [yzy retain];
        [_myImageView sd_setImageWithURL:[NSURL URLWithString:_yzy.image]];
        _myLabel.text = _yzy.post.title;
    }
}


- (void)layoutSubviews {
    
    _myImageView.frame = self.contentView.frame;
    [_myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-30);
        make.left.equalTo(self.mas_left).offset(30);
        make.right.equalTo(self.mas_right).offset(-30);
        make.top.equalTo(self.mas_bottom).offset(-120);
    }];
 
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    [self.yzyzyzy nursingNewsByCarousel:_yzy];
}


@end
