//
//  NewsCollectionViewCell.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/30.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "NewsCollectionViewCell.h"
#import "YZYLeftSidebar.h"

@interface NewsCollectionViewCell ()

@property (retain, nonatomic) IBOutlet UIImageView *myImageView;

@property (retain, nonatomic) IBOutlet UILabel *myLabel;


@end

@implementation NewsCollectionViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)dealloc {
    [_yzy release];
    [_myImageView release];
    [_myLabel release];
    [super dealloc];
}

- (void)setYzy:(YZYLeftSidebar *)yzy {
    if (_yzy != yzy) {
        [_yzy release];
        _yzy = [yzy retain];
        [_myImageView sd_setImageWithURL:[NSURL URLWithString:_yzy.normal]];
        _myLabel.textAlignment = NSTextAlignmentLeft;
        _myLabel.font = [UIFont systemFontOfSize:18];
        _myLabel.textColor = [UIColor whiteColor];
        _myLabel.text = _yzy.title;

    }
}




@end
