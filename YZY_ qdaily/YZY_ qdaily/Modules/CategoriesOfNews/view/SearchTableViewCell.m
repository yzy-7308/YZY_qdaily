//
//  SearchTableViewCell.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/11.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "SearchTableViewCell.h"
#import "YZYSearchesModel.h"
#import "YZYPostModel.h"
#import "YZYauthorModel.h"
#import "YZYCategoryModel.h"
#import "NSDate+Categories.h"


@interface SearchTableViewCell ()

@property (nonatomic, retain)UIImageView *LogoImageView;

@property (nonatomic, retain)UILabel *categoryName;

@property (nonatomic, retain)UILabel *authorAndTime;

@property (nonatomic, retain)UILabel *titleLabel;

@property (nonatomic, retain)UILabel *descLabel;

@end

@implementation SearchTableViewCell

- (void)dealloc {
    [_yzy release];
    [_LogoImageView release];
    [_categoryName release];
    [_authorAndTime release];
    [_titleLabel release];
    [_descLabel release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.LogoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_LogoImageView];
        [_LogoImageView release];
        
        self.categoryName = [[UILabel alloc] initWithFrame:CGRectZero];
        _categoryName.font = [UIFont systemFontOfSize:15];
        _categoryName. textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_categoryName];
        
        self.authorAndTime = [[UILabel alloc] initWithFrame:CGRectZero];
        _authorAndTime.font = [UIFont systemFontOfSize:15];
        _authorAndTime.textColor = [UIColor lightGrayColor];
        _authorAndTime.textAlignment = NSTextAlignmentRight;
        [_authorAndTime sizeToFit];
        [self.contentView addSubview:_authorAndTime];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 1;
        [_titleLabel sizeToFit];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel release];
        
        self.descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descLabel.font = [UIFont systemFontOfSize:15];
        _descLabel.textAlignment = NSTextAlignmentLeft;
        _descLabel.numberOfLines = 2;
        [_descLabel sizeToFit];
        [self.contentView addSubview:_descLabel];
        [_descLabel release];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_LogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
    }];
    
    [_categoryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_LogoImageView.mas_centerY);
        make.left.equalTo(_LogoImageView.mas_right).offset(15);
        make.height.equalTo(@15);
    }];
    
    [_authorAndTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(_categoryName.mas_centerY);
        make.height.equalTo(@15);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(_categoryName.mas_bottom).offset(10);
        make.height.equalTo(@20);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
    }];
}

- (void)setYzy:(YZYSearchesModel *)yzy {
    if (_yzy != yzy) {
        [_yzy release];
        _yzy = [yzy retain];
        [_LogoImageView sd_setImageWithURL:[NSURL URLWithString:_yzy.post.category.normal]];
        _categoryName.text = _yzy.post.category.title;
        _authorAndTime.text = [NSString stringWithFormat:@"%@  |  %@", _yzy.author.name, [NSDate intervalSinceNow:_yzy.post.publish_time]];
        _titleLabel.text = _yzy.post.title;
        _descLabel.text = _yzy.post.myDescription;
    }
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
