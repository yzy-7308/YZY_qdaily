//
//  CarouselView.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "CarouselView.h"
#import "CarouselCollectionViewCell.h"
#import <Masonry.h>


static NSString *const cellIdentifier = @"cell";

@interface CarouselView ()

<
UICollectionViewDelegate,
UICollectionViewDataSource,
CarouselViewDelegate
>

@property (nonatomic, retain)UICollectionView *collectionView;

@property (nonatomic, retain)NSMutableArray *currentYZYArray;

@property (nonatomic, retain)UIPageControl *pageControl;

@property (nonatomic, retain)NSTimer *timer;

@end

@implementation CarouselView

- (void)dealloc {
    Block_release(_dealWithYzy);
    [_collectionView release];
    [_currentYZYArray release];
    [_pageControl release];
    [_timer release];
    [_YZYArray release];
    [super dealloc];
    
}

- (void)nursingNewsByCarousel:(YZYBaseModel *)yzy {
    self.dealWithYzy(yzy);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化可变数组
        self.currentYZYArray = [NSMutableArray array];

        // 初始化collectionView
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = self.bounds.size;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
        [_collectionView registerClass:[CarouselCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        [flowLayout release];
        [_collectionView release];
        
        // 初始化pageControl
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
//        _pageControl.hidesForSinglePage = YES;
        _pageControl.currentPage = 0;
        [_pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageControl];
        [_pageControl release];
        
        [self addTimer];
        
        
        
    }
    return self;
}

- (void)pageControlValueChanged:(UIPageControl *)pageControl {
    [_collectionView setContentOffset:CGPointMake((pageControl.currentPage + 1) * WIDTH, 0) animated:YES];
}

-(void)setYZYArray:(NSMutableArray *)YZYArray {
    if (_YZYArray != YZYArray) {
        [_YZYArray release];
        _YZYArray = [YZYArray retain];
        if (_currentYZYArray.count > 0) {
            [_currentYZYArray removeAllObjects];
            for (UIView *subView in _collectionView.subviews) {
                if ([subView isKindOfClass:[UILabel class]]) {
                    [subView removeFromSuperview];
                }
                if ([subView isKindOfClass:[UIImageView class]]) {
                    [subView removeFromSuperview];
                }
            }
        }
        
        [_currentYZYArray addObject:[_YZYArray lastObject]];
        [_currentYZYArray addObjectsFromArray:_YZYArray];
        [_currentYZYArray addObject:[_YZYArray firstObject]];
        
        _collectionView.contentSize = CGSizeMake(WIDTH * _currentYZYArray.count, HEIGHT);
        
        CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_YZYArray.count];
        _pageControl.frame = CGRectMake((WIDTH - pageControlSize.width) / 2, HEIGHT - pageControlSize.height - 5, pageControlSize.width, pageControlSize.height);
        _pageControl.numberOfPages = _YZYArray.count;

        _collectionView.contentOffset = CGPointMake(WIDTH, 0);
    }
}


// 结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_collectionView]) {
        NSInteger pageNumber = scrollView.contentOffset.x / WIDTH;
        if (0 == pageNumber) {
            pageNumber = _YZYArray.count;
        }else if (_YZYArray.count + 1 == pageNumber) {
            pageNumber = 1;
        }
        _pageControl.currentPage = pageNumber - 1;
        scrollView.contentOffset = CGPointMake(WIDTH * pageNumber, 0);
        
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _currentYZYArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CarouselCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.yzy = _currentYZYArray[indexPath.item];
        cell.yzyzyzy = self;
    return cell;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_collectionView.mas_bottom);
        make.centerX.equalTo(_collectionView.mas_centerX);
        make.width.equalTo(@50);
        make.height.equalTo(@20);
    }];
}

// 添加定时器

- (void)addTimer {
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:6.f target:self selector:@selector(nextImage) userInfo:nil repeats:YES];

    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    //    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    
}

// timer:下一张图片
-(void)nextImage {
        NSInteger pageNumber = self.pageControl.currentPage;
        if (pageNumber == (_YZYArray.count - 1)) {
            pageNumber = 0;
        }else{
            pageNumber ++;
        }
    _collectionView.contentOffset = CGPointMake(pageNumber * WIDTH, 0);
    
//    NSInteger pageNumber = _collectionView.contentOffset.x / WIDTH;
//    
//    if (_YZYArray.count ==  pageNumber) {
//        pageNumber = 0;
//        _collectionView.contentOffset = CGPointMake(pageNumber * WIDTH, 0);
//    }
    
    [_collectionView setContentOffset:CGPointMake((pageNumber + 1) * WIDTH, 0) animated:YES];
    _pageControl.currentPage = pageNumber;
    
}

//关闭定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //[self.timer invalidate];
    
    if ([scrollView isEqual:_collectionView]) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
    
    
}

// 结束拖拽是调用
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //[self addTimer];
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3.f]];
    
}


@end
