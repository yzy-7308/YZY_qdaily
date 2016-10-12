 //
//  SaidCollectionViewCell.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/7.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "SaidCollectionViewCell.h"
#import "YZYoptionsModel.h"
#import "YZYauthorModel.h"

@interface SaidCollectionViewCell ()

@property (nonatomic, retain)UIImageView *backImageView;

@property (nonatomic, retain)UIImageView *avatarImageView;

@property (nonatomic, retain)UILabel *nameLabel;

@property (nonatomic, retain)UILabel *contentLabel;

@property (nonatomic, retain)UIImageView *likeImageView;

@property (nonatomic, retain)UILabel *likeLabel;

@property (nonatomic, retain)UIButton *shareButton;



@end

@implementation SaidCollectionViewCell

- (void)dealloc {
    [_backImageView release];
    [_avatarImageView release];
    [_nameLabel release];
    [_contentLabel release];
    [_likeImageView release];
    [_likeLabel release];
    [_yzy release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.f green:arc4random() % 256 / 255.f blue:arc4random() % 256 / 255.f alpha:0.8];

        self.backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mobFeedCellPattern"]];
        [self.contentView addSubview:_backImageView];
        [_backImageView release];
        
        self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.layer.cornerRadius = 12.5;

        [self.contentView addSubview:_avatarImageView];
        [_avatarImageView release];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel release];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.numberOfLines = 0;
        [_contentLabel sizeToFit];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel release];
        
        self.likeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mobLike"]];
        [self.contentView addSubview:_likeImageView];
        [_likeImageView release];
        
        self.likeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _likeLabel.textColor = [UIColor whiteColor];
        _likeLabel.textAlignment = NSTextAlignmentLeft;
        _likeLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_likeLabel];
        [_likeLabel release];
        
        self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:[UIImage imageNamed:@"mobShare"] forState:UIControlStateNormal];
        [self.contentView addSubview:_shareButton];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _backImageView.frame = self.bounds;

    
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_avatarImageView.mas_centerY);
        make.left.equalTo(_avatarImageView.mas_right).offset(2);
        make.height.equalTo(@25);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    [_likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    [_likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_likeImageView.mas_centerY);
        make.left.equalTo(_likeImageView.mas_right).offset(2);
        make.height.equalTo(@20);
    }];
    
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
    }];
    
}

- (void)setYzy:(YZYoptionsModel *)yzy {
    if (_yzy != yzy) {
        [_yzy release];
        _yzy = [yzy retain];
         [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:_yzy.author.avatar]];
        _nameLabel.text = _yzy.author.name;
        _contentLabel.text = _yzy.content;
        _likeLabel.text = [NSString stringWithFormat:@"%ld赞", _yzy.praise_count];
    }
    
}

@end
