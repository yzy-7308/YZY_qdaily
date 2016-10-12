//
//  SettingTableViewCell.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/10.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "SettingTableViewCell.h"

@interface SettingTableViewCell ()

@property (nonatomic, retain)UILabel *nameLabel;

@property (nonatomic, retain)UILabel *rightLabel;

@property (nonatomic, retain)UIImageView *rightImageView;

@property (nonatomic, retain)UIView *myView;

@end

@implementation SettingTableViewCell

- (void)dealloc {
    [_myView release];
    [_name release];
    [_nameLabel release];
    [_right release];
    [_rightLabel release];
    [_rightView release];
    [_rightImageView release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = [UIColor whiteColor];
        [_nameLabel sizeToFit];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];
        
        self.rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightLabel.textColor = [UIColor whiteColor];
        [_rightLabel sizeToFit];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_rightLabel];

        self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_rightImageView];
        [_rightImageView release];
        
        self.myView = [[UIView alloc] initWithFrame:CGRectZero];
        _myView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_myView];
        [_myView release];
        
    }
    return self;
}

- (void)layoutSubviews {
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@20);
    }];
    
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_rightImageView.mas_right).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@20);
    }];
    
    [_myView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.mas_width);
        make.height.equalTo(@1);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
    }];
}

- (void)setName:(NSString *)name {
    if (_name != name) {
        [_name release];
        _name = [name copy];
        _nameLabel.text = _name;
    }
}

- (void)setRight:(NSString *)right {
    if (_right != right) {
        [_right release];
        _right = [right copy];
        _rightLabel.text = _right;
    }
}

- (void)setRightView:(NSString *)rightView {
    if (_rightView != rightView) {
        [_rightView release];
        _rightView = [rightView copy];
        _rightImageView.image = [UIImage imageNamed:_rightView];
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
