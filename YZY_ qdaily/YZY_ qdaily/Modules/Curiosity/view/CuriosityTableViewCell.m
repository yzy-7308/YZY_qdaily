//
//  CuriosityTableViewCell.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/5.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "CuriosityTableViewCell.h"
#import "YZYBaseModel.h"
#import "YZYPostModel.h"
#import "YZYCategoryModel.h"

@interface CuriosityTableViewCell ()

@property (nonatomic, retain)UIImageView *myImageView;

@property (nonatomic, retain)UIImageView *smallImageView;

@property (nonatomic, retain)UILabel *smallLaebl;

@property (nonatomic, retain)UILabel *titleLabel;

@property (nonatomic, retain)UILabel *descLabel;

@property (nonatomic, retain)UIImageView *typeImageView;

@end

@implementation CuriosityTableViewCell

- (void)dealloc {
    [_yzy release];
    [_typeImageView release];
    [_myImageView release];
    [_smallImageView release];
    [_smallLaebl release];
    [_titleLabel release];
    [_descLabel release];
    [super dealloc];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.myImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _myImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_myImageView];
        [_myImageView release];
        
        self.smallImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_smallImageView];
        [_smallImageView release];
        
        self.smallLaebl = [[UILabel alloc] initWithFrame:CGRectZero];
        _smallLaebl.font = [UIFont fontWithName:@"Georgia" size:15];
        _smallLaebl.textColor = [UIColor orangeColor];
        _smallLaebl.textAlignment = NSTextAlignmentCenter;
        [_smallImageView addSubview:_smallLaebl];
        [_smallLaebl release];
        
        self.typeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_myImageView addSubview:_typeImageView];
        [_typeImageView release];

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
    [_myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-(self.contentView.frame.size.height / 2.265));
    }];
    
    [_smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_myImageView.mas_right).offset(-10);
        make.top.equalTo(_myImageView.mas_top).offset(10);
        make.width.equalTo(@70);
        make.height.equalTo(@50);
    }];
    
    [_smallLaebl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_smallImageView.mas_top).offset(5);
        make.left.equalTo(_smallImageView.mas_left).offset(5);
        make.right.equalTo(_smallImageView.mas_right).offset(-5);
        make.bottom.equalTo(_smallImageView.mas_bottom).offset(-30);
    }];
    
    [_typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_myImageView.mas_left).offset(20);
        make.bottom.equalTo(_myImageView.mas_bottom).offset(-25);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myImageView.mas_bottom).offset(20);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.equalTo(@25);
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
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
        _smallImageView.image = [UIImage imageNamed:@"Lab_Vote_Join"];
        _smallLaebl.text = [NSString stringWithFormat:@"%@", _yzy.post.record_count];
        [_typeImageView sd_setImageWithURL:[NSURL URLWithString:_yzy.post.category.image_lab]];
        _titleLabel.text = _yzy.post.title;
        _descLabel.text = _yzy.post.myDescription;
    }
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 2;//这里间距为10，可以根据自己的情况调整
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 2 * frame.origin.x;
    [super setFrame:frame];
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
