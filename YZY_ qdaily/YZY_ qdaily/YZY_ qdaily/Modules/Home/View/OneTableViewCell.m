//
//  OneTableViewCell.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "OneTableViewCell.h"
#import "YZYBaseModel.h"
#import "YZYPostModel.h"
#import "YZYCategoryModel.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "NSDate+Categories.h"

@interface OneTableViewCell ()

@property (nonatomic, retain)UILabel *titleLabel;

@property (nonatomic, retain)UILabel *categoryLabel;

@property (nonatomic, retain)UILabel *commentLabel;

@property (nonatomic, retain)UILabel *praiseLabel;

@property (nonatomic, retain)UILabel *timeLabel;

@property (nonatomic, retain)UIImageView *myImageView;

@property (nonatomic, retain)UIImageView *commentImageView;

@property (nonatomic, retain)UIImageView *praiseImageView;

@end

@implementation OneTableViewCell

- (void)dealloc{
    [_yzy release];
    [_titleLabel release];
    [_categoryLabel release];
    [_commentLabel release];
    [_commentImageView release];
    [_praiseLabel release];
    [_praiseImageView release];
    [_timeLabel release];
    [_myImageView release];
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
        self.myImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _myImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_myImageView];
        [_myImageView release];
        
        self.commentImageView  =[[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_commentImageView];
        [_commentImageView release];
        
        self.praiseImageView  =[[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_praiseImageView];
        [_praiseLabel release];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel release];
        
        self.categoryLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _categoryLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
        _categoryLabel.textAlignment = NSTextAlignmentCenter;
        _categoryLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_categoryLabel];
        [_categoryLabel release];
        
        self.commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _commentLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
        _commentLabel.textAlignment = NSTextAlignmentCenter;
        _commentLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_commentLabel];
        [_commentLabel release];
        
        self.praiseLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _praiseLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
        _praiseLabel.textAlignment = NSTextAlignmentCenter;
        _praiseLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_praiseLabel];
        [_praiseLabel release];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel release];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.left.equalTo(self.contentView.mas_centerX);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(_myImageView.mas_left).offset(-20);
        make.height.equalTo(@80);
    }];
    
    [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@30);
    }];
    
    [_commentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-13);
        make.left.equalTo(_categoryLabel.mas_right).offset(3);
        make.height.equalTo(@13);
        make.width.equalTo(@15);
    }];
    
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(_commentImageView.mas_right).offset(2);
        make.height.equalTo(@20);
        make.width.equalTo(@25);
    }];
    
    [_praiseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-13);
        make.left.equalTo(_commentLabel.mas_right).offset(3);
        make.height.equalTo(@13);
        make.width.equalTo(@15);
        
    }];
    
    [_praiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(_praiseImageView.mas_right).offset(2);
        make.height.equalTo(@20);
        make.width.equalTo(@25);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(_praiseLabel.mas_right).offset(2);
        make.right.equalTo(_myImageView.mas_left).offset(-20);
        make.height.equalTo(@20);
        
    }];
    
   
}

- (void)setYzy:(YZYBaseModel *)yzy {
    
    if (_yzy != yzy) {
        [_yzy release];
        _yzy = [yzy retain];
        [_myImageView sd_setImageWithURL:[NSURL URLWithString:_yzy.image]];
        _titleLabel.text = _yzy.post.title;
        _categoryLabel.text = _yzy.post.category.title;
        if (0 != _yzy.post.comment_count) {
            _commentImageView.image = [UIImage imageNamed:@"feedComment"];
            _commentLabel.text = [NSString stringWithFormat:@"%@", _yzy.post.comment_count];
        }else {
            _commentLabel.text = @"";
        }
        if (0 != _yzy.post.praise_count) {
            _praiseImageView.image = [UIImage imageNamed:@"feedPraise"];
            _praiseLabel.text = [NSString stringWithFormat:@"%@", _yzy.post.praise_count];
        }else {
            _praiseLabel.text = @"";
        }
 
        _timeLabel.text = [NSDate intervalSinceNow:_yzy.post.publish_time];
    

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
