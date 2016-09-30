//
//  NewsCollectionViewCell.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/30.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "NewsCollectionViewCell.h"

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
    [_myImageView release];
    [_myLabel release];
    [super dealloc];
}

- (void)setImageName:(NSString *)imageName {
    if (_imageName != imageName) {
        [_imageName release];
        _imageName = [imageName retain];
        _myImageView.image = [UIImage imageNamed:_imageName];
    }
}

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        [_title release];
        _title = [title retain];
        _myLabel.textAlignment = NSTextAlignmentCenter;
        _myLabel.font = [UIFont fontWithName:@"Zapfino" size:18];
        _myLabel.textColor = [UIColor whiteColor];
        _myLabel.text = _title;

    }
}

@end
