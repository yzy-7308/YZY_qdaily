//
//  ColumnTableViewCell.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/11.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "ColumnTableViewCell.h"
#import "YZYColumnModel.h"

@interface ColumnTableViewCell ()

@property (nonatomic, retain)UIImageView *myImageView;

@property (nonatomic, retain)UILabel *nameLabel;

@property (nonatomic, retain)UILabel *descLabel;

@property (nonatomic, retain)UILabel *dataLabel;

@property (nonatomic, retain)UIButton *button;

@end

@implementation ColumnTableViewCell

- (void)dealloc {
    [_yzy release];
    [_myImageView release];
    [_nameLabel release];
    [_descLabel release];
    [_dataLabel release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.myImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_myImageView];
        [_myImageView release];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_nameLabel sizeToFit];
        _nameLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:18];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel release];
        
        self.descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_descLabel sizeToFit];
        _descLabel.numberOfLines = 0;
        _descLabel.font = [UIFont systemFontOfSize:15];
        _descLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_descLabel];
        [_descLabel release];
        
        self.dataLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_dataLabel sizeToFit];
        _dataLabel.font = [UIFont systemFontOfSize:13];
        _dataLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_dataLabel];
        [_dataLabel release];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setImage:[UIImage imageNamed:@"columnInfoSubscribe"] forState:UIControlStateNormal];
        [self.contentView addSubview:_button];
        
    }
    return self;
}

- (void)layoutSubviews {
    [_myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(self.contentView.frame.size.height - 20));
        make.height.equalTo(@(self.contentView.frame.size.height - 20));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_myImageView.mas_right).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.height.equalTo(@20);
        make.right.equalTo(self.contentView.mas_right).offset(-80);
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_myImageView.mas_right).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-35);
        make.right.equalTo(self.contentView.mas_right).offset(-80);
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
    }];
    
    [_dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-80);
        make.height.equalTo(@15);
        make.left.equalTo(_myImageView.mas_right).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}

- (void)setYzy:(YZYColumnModel *)yzy {
    if (_yzy != yzy) {
        [_yzy release];
        _yzy = [yzy retain];
        [_myImageView sd_setImageWithURL:[NSURL URLWithString:_yzy.myImage]];
        _nameLabel.text = _yzy.name;
        _descLabel.text = _yzy.myDescription;
        _dataLabel.text = [NSString stringWithFormat:@"%@人已订阅, 更新至%@篇", _yzy.subscriber_num, _yzy.post_count];
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
