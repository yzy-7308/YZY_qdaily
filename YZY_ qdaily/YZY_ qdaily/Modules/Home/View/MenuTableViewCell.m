

//
//  MenuTableViewCell.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "MenuTableViewCell.h"

@interface MenuTableViewCell ()

@property (nonatomic, retain) UIImageView *myImageView;

@property (nonatomic, retain) UILabel *myLabel;

@property (nonatomic, retain) UIImageView *specImageView;

@end

@implementation MenuTableViewCell

- (void)dealloc {
    [_myLabel release];
    [_myImageView release];
    [_imageName release];
    [_title release];
    [_spec release];
    [_specImageView release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.myImageView = [[UIImageView alloc] init];
        _myImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_myImageView];
        [_myImageView release];
        
        self.myLabel = [[UILabel alloc] init];
        _myLabel.textAlignment = NSTextAlignmentCenter;
        _myLabel.font = [UIFont fontWithName:@"Zapfino" size:18];
        _myLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_myLabel];
        [_myLabel release];
        
        self.specImageView = [[UIImageView alloc] init];
        _specImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_specImageView];
        [_specImageView release];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@35);
        make.width.equalTo(@35);
    }];
    [_myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_myImageView.mas_right).offset(10);
        make.centerY.equalTo(_myImageView.mas_centerY).offset(2);
        make.height.equalTo(@60);
    }];
    
    [_specImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_myLabel.mas_right).offset(10);
        make.centerY.equalTo(_myImageView.mas_centerY);
        make.width.equalTo(@10);
        make.height.equalTo(@20);
    }];
    
}

- (void)setImageName:(NSString *)imageName {
    if (_imageName != imageName) {
        [_imageName release];
        _imageName = [imageName copy];
        _myImageView.image = [UIImage imageNamed:_imageName];
    }
}

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        [_title release];
        _title = [title copy];
        _myLabel.text = _title;
    }
}

- (void)setSpec:(NSString *)spec {
    if (_spec != spec) {
        [_spec release];
        _spec = [spec copy];
        _specImageView.image = [UIImage imageNamed:_spec];
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
