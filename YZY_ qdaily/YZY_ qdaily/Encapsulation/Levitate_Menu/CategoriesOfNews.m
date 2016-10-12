//
//  CategoriesOfNews.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/30.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "CategoriesOfNews.h"
#import "NewsCollectionViewCell.h"
#import "YZYLeftSidebar.h"

static NSString *const cellIdentifier = @"newsCell";

@interface CategoriesOfNews ()

<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@end

@implementation CategoriesOfNews

- (void)dealloc {
    Block_release(_JumpDetails);
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    [_leftArray release];
    [_collectionView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化collectionView
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
        [_collectionView registerNib:[UINib nibWithNibName:@"NewsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
        [flowLayout release];
        [_collectionView release];
    
    }
    return self;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.JumpDetails(_leftArray[indexPath.item]);
}

- (void)setLeftArray:(NSMutableArray *)leftArray {
    if (_leftArray != leftArray) {
        [_leftArray release];
        _leftArray = [leftArray retain];
        [_collectionView reloadData];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.bounds.size.width / 2, 66);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _leftArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.yzy = _leftArray[indexPath.item];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
    
}



@end
