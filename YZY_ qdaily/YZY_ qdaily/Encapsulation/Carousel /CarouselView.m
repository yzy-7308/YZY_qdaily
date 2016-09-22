//
//  CarouselView.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "CarouselView.h"
#import "CarouselCollectionViewCell.h"
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

@property (nonatomic, retain)NSMutableArray *currentTitltArray;

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
        self.currentTitltArray = [NSMutableArray array];
        
        
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
        [_collectionView registerClass:[CarouselCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        
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

- (void)setTitleArray:(NSMutableArray *)titleArray {
    
    if (_titleArray != titleArray) {
        _titleArray = titleArray;
    }
    if (_currentTitltArray.count > 0) {
        [_currentTitltArray removeAllObjects];
        for (UILabel *subLabel in _collectionView.subviews) {
            if ([subLabel isKindOfClass:[UILabel class]]) {
                [subLabel removeFromSuperview];
            }
        }
    }
    [_currentTitltArray addObject:[_titleArray lastObject]];
    [_currentTitltArray addObjectsFromArray:_titleArray];
    [_currentTitltArray addObject:[_titleArray firstObject]];

    
}

- (void)setImageArray:(NSMutableArray *)imageArray {

    if (_imageArray != imageArray) {
        _imageArray = imageArray;
    }
    if (_currentImageArray.count > 0) {
        [_currentImageArray removeAllObjects];
        for (UIView *subView in _collectionView.subviews) {
            if ([subView isKindOfClass:[UIImageView class]]) {
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pageControl.currentPage = page;
    NSLog(@"%f",page);
    
}

// 结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_collectionView]) {
        NSInteger pageNumber = scrollView.contentOffset.x / scrollView.bounds.size.width;
        if (0 == pageNumber) {
            pageNumber = _imageArray.count;
        }else if (_imageArray.count + 1 == pageNumber) {
            pageNumber = 1;
        }
        _pageControl.currentPage = pageNumber - 1;
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width * pageNumber, 0);
        
        for (UIView *subview in scrollView.subviews) {
            if ([subview isKindOfClass:[UIScrollView class]]) {
                UIScrollView *subScrollView = (UIScrollView *)subview;
                subScrollView.zoomScale = 1.0f;
            }
        }
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _currentImageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CarouselCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.image = _currentImageArray[indexPath.item];
    cell.carouselTitle = _currentTitltArray[indexPath.item];
    cell.backgroundColor = [UIColor colorWithRed:1.0 green:0.528 blue:0.5525 alpha:1];
    return cell;
}

- (void)pageControlValueChanged:(UIPageControl *)pageControl {
    
    [_collectionView setContentOffset:CGPointMake((pageControl.currentPage + 1) * WIDTH, 0) animated:YES];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.bounds;


}

// 添加定时器

- (void)addTimer {
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(nextImage) userInfo:nil repeats:YES];

    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    //    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    
}

// timer:下一张图片
-(void)nextImage {
//        NSInteger page = self.pageControl.currentPage;
//        if (page == (_imageArray.count - 1)) {
//            page = 0;
//        }else{
//            page ++;
//        }
//        _collectionView.contentOffset = CGPointMake(page * WIDTH, 0);
    
    
    NSInteger pageNumber = _collectionView.contentOffset.x / WIDTH;
    
    if (_imageArray.count ==  pageNumber) {
        pageNumber = 0;
        _collectionView.contentOffset = CGPointMake(pageNumber * WIDTH, 0);
    }
    
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
