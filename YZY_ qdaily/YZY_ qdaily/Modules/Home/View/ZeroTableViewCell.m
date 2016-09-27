//
//  ZeroTableViewCell.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "ZeroTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "NSDate+Categories.h"
#import "YZYBaseModel.h"
#import "YZYPostModel.h"
#import "YZYColumnModel.h"

#define WIDTH self.contentView.bounds.size.width
#define HEIGHT self.contentView.bounds.size.height

@interface ZeroTableViewCell ()

@property (nonatomic, retain)UIView *view;

@property (nonatomic, retain)UIImageView *curiosityImageView;

@property (nonatomic, retain)UILabel *curiosityLabel;

@property (nonatomic, retain)UIImageView *myImageView;

@property (nonatomic, retain)UIButton *shareButton;

@property (nonatomic, retain)UILabel *titleLabel;

@property (nonatomic, retain)UILabel *descLabel;

@end

@implementation ZeroTableViewCell

- (void)dealloc{
    [_curiosityImageView release];
    [_curiosityLabel release];
    [_myImageView release];
    [_titleLabel release];
    [_descLabel release];
    [super dealloc];
    
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 2;//这里间距为10，可以根据自己的情况调整
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 2 * frame.origin.x;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.view = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_view];
        [_view release];
        self.curiosityImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_view addSubview:_curiosityImageView];
        [_curiosityImageView release];
    
        self.curiosityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _curiosityLabel.numberOfLines = 0;
        [_curiosityLabel sizeToFit];
        _curiosityLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        _curiosityLabel.textAlignment = NSTextAlignmentCenter;
        _curiosityLabel.textColor = [UIColor blackColor];
        [_view addSubview:_curiosityLabel];
        [_curiosityLabel release];
        
        self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:[UIImage imageNamed:@"feedShare"] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_view addSubview:_shareButton];
        
        self.myImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _myImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_myImageView];
        [_myImageView release];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:18];
        _titleLabel.textAlignment = NSTextAlignmentLeft ;
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel release];
        
        self.descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descLabel.numberOfLines = 0;
        _descLabel.font = [UIFont fontWithName:@"Georgia" size:13];
        _descLabel.textAlignment = NSTextAlignmentLeft;
        _descLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_descLabel];
        [_descLabel release];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.height.equalTo(@40);
    }];
    
    [_curiosityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_view.mas_left).offset(20);
        make.top.equalTo(_view.mas_top).offset(10);
        make.bottom.equalTo(_view.mas_bottom).offset(-10);
        make.width.equalTo(@20);
    }];
    
    [_curiosityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_curiosityImageView.mas_right).offset(10);
        make.top.equalTo(_view.mas_top).offset(10);
        make.bottom.equalTo(_view.mas_bottom).offset(-10);
        make.height.equalTo(@20);
    }];
    
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view.mas_top).offset(3);
        make.right.equalTo(_view.mas_right).offset(-20);
        make.height.equalTo(@36);
        make.width.equalTo(@28);
    }];
    
    [_myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-110);
    }];
    
    CGSize size = [_titleLabel sizeThatFits:CGSizeMake(_titleLabel.frame.size.width, MAXFLOAT)];
    _titleLabel.frame = CGRectMake(20, 260, 414 - 40, size.height);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myImageView.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
   

    
    
}

- (void)setYzy:(YZYBaseModel *)yzy {

    if (_yzy != yzy) {
        [_yzy release];
        _yzy = [yzy retain];
        [_myImageView sd_setImageWithURL:[NSURL URLWithString:_yzy.image]];
        [_curiosityImageView sd_setImageWithURL:[NSURL URLWithString:_yzy.post.column.icon]];
        _curiosityLabel.text = _yzy.post.column.name;
        _titleLabel.text = _yzy.post.title;
        _descLabel.text = _yzy.post.myDescription;
    }
    
}

- (void)shareButtonAction{
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
