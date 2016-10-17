//
//  ColumnCollectionViewCell.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/11.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "ColumnCollectionViewCell.h"

@interface ColumnCollectionViewCell ()


@end

@implementation ColumnCollectionViewCell

- (void)dealloc {
    [_pieceLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pieceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _pieceLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_pieceLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _pieceLabel.frame = self.bounds;
}



@end
