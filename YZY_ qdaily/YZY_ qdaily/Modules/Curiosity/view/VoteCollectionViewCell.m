//
//  VoteCollectionViewCell.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/5.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "VoteCollectionViewCell.h"
#import "YZYoptionsModel.h"

@interface VoteCollectionViewCell ()

@property (nonatomic, retain) UIImageView *myImageView;

@property (nonatomic, retain) UILabel *myLabel;

@property (nonatomic, retain) UIImageView *statusImageView;

@end

@implementation VoteCollectionViewCell

- (void)dealloc {
    [_yzy release];
    [_myImageView release];
    [_myLabel release];
    [_statusImageView release];
    [super dealloc];
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 2;//这里间距为10，可以根据自己的情况调整
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 2 * frame.origin.x;
    [super setFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_myImageView];
        [_myImageView release];
        
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _myLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        _myLabel.numberOfLines = 0;
        [_myLabel sizeToFit];
        _myLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_myLabel];
        [_myLabel release];
        
        self.statusImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_statusImageView];
        [_statusImageView release];
    }
    return self;
}

- (void)setYzy:(YZYoptionsModel *)yzy {
    if (_yzy != yzy) {
        [_yzy release];
        _yzy = [yzy retain];
        [_myImageView sd_setImageWithURL:[NSURL URLWithString:_yzy.myImage]];
        _myLabel.text = _yzy.content;
        _statusImageView.image = [UIImage imageNamed:@"voteOptionCheckMulti"];
        
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.equalTo(@90);
        make.height.equalTo(@90);
    }];
    
    [_myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(_myImageView.mas_right).offset(5);
        make.width.equalTo(@(self.contentView.frame.size.width - 160));
    }];
    
    [_statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
    }];
    
    
}

@end
