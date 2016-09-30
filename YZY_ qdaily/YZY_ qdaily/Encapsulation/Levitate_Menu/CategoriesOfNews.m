//
//  CategoriesOfNews.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/30.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "CategoriesOfNews.h"
#import "NewsCollectionViewCell.h"

static NSString *const cellIdentifier = @"newsCell";

@interface CategoriesOfNews ()

<
UICollectionViewDelegate,
UICollectionViewDataSource
>



@property (nonatomic, retain) UICollectionView *collectionView;

@end

@implementation CategoriesOfNews

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化collectionView
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = self.bounds.size;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.alpha = 0;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
        [_collectionView registerClass:[NewsCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        [flowLayout release];
        [_collectionView release];
    
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _iconArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.imageName = _iconArray[indexPath.item];
    cell.title = _titleArray[indexPath.item];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
    
}



@end
