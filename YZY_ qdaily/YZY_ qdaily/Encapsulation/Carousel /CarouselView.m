//
//  CarouselView.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "CarouselView.h"
#define WIDTH self.bounds.size.width
#define HEIGHT self.bounds.size.height

static NSString *const cellIdentifier = @"cell";

@interface CarouselView ()

<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, retain)UICollectionView *collectionView;

@property (nonatomic, retain)NSMutableArray *currentImageArray;

@property (nonatomic, retain)UIPageControl *pageControl;

@property (nonatomic, retain)NSTimer *timer;

@end

@implementation CarouselView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化可变数组
        self.currentImageArray = [NSMutableArray array];
        
        // 初始化collectionView
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = self.bounds.size;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        
        // 初始化pageControl
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.hidesForSinglePage = YES;
        [_pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageControl];
        
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray {

    if (_imageArray != imageArray) {
        _imageArray = imageArray;
    }
    if (_currentImageArray.count > 0) {
        [_currentImageArray removeAllObjects];
        for (UIView *subView in _collectionView.subviews) {
            if ([subView isKindOfClass:[UIImageView class]] | [subView isKindOfClass:[UILabel class]]) {
                [subView removeFromSuperview];
            }
        }
    }
    [_currentImageArray addObject:[_imageArray lastObject]];
    [_currentImageArray addObjectsFromArray:_imageArray];
    [_currentImageArray addObject:[_imageArray firstObject]];
    _collectionView.contentSize = CGSizeMake(WIDTH * _currentImageArray.count, HEIGHT);
    
    CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_imageArray.count];
    _pageControl.frame = CGRectMake((WIDTH - pageControlSize.width) / 2, HEIGHT - pageControlSize.height - 5, pageControlSize.width, pageControlSize.height);
    _pageControl.numberOfPages = _imageArray.count;
    _pageControl.currentPage = 0;
    
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _currentImageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    return 0;
}

- (void)pageControlValueChanged:(UIPageControl *)pageControl {
    
    [_collectionView setContentOffset:CGPointMake((pageControl.currentPage + 1) * WIDTH, 0) animated:YES];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.bounds;


}

@end
