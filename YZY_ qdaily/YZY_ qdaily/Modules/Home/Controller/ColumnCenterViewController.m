//
//  ColumnCenterViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/11.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "ColumnCenterViewController.h"
#import "ColumnCollectionViewCell.h"
#import "ColumnTableViewCell.h"
#import "HttpAPIConst.h"
#import "YZYColumnModel.h"

static NSString *const Identifier = @"collectionCell";
static NSString *const identifier = @"tableViewCell";


@interface ColumnCenterViewController ()

<
UICollectionViewDelegate,
UICollectionViewDataSource,
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate
>

@property (nonatomic, retain)UICollectionView *collectionView;

@property (nonatomic, retain)UIScrollView *scrollView;

@property (nonatomic, retain)UITableView *tabelView;

@property (nonatomic, retain)UIImageView *myImageView;

@property (nonatomic, retain)UIView *smallView;

@property (nonatomic, retain)UIView *myView;

@property (nonatomic, retain) CAGradientLayer * shadow;

@property (nonatomic, retain)NSMutableArray *objectArray;

@property (nonatomic, copy)NSString *number;

@property (nonatomic, retain)NSNumber *boolString;

@end

@implementation ColumnCenterViewController

- (void)dealloc {
    [_boolString release];
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    _tabelView.delegate = nil;
    _tabelView.dataSource = nil;
    _scrollView.delegate = nil;
    [_collectionView release];
    [_scrollView release];
    [_tabelView release];
    [_myView release];
    [_myImageView release];
    [_smallView release];
    [_shadow release];
    [_objectArray release];
    [_number release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.objectArray = [NSMutableArray array];
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    _myView.backgroundColor = [UIColor whiteColor];
    // 添加渐变色层
    self.shadow = [CAGradientLayer layer];
    _shadow.frame = _myView.bounds;
    [_myView.layer addSublayer:_shadow];
    //  设置渐变的方向
    _shadow.startPoint = CGPointMake(0, 0);
    _shadow.endPoint = CGPointMake(0, 1);
    //  设置渐变的颜色
    _shadow.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                       (__bridge id)[UIColor blackColor].CGColor];
    //  设置渐变分割点
    _shadow.locations = @[@(-2.0f), @(1.0f)];
    [self.view addSubview:_myView];
    
    self.navigationItem.title = @"栏目中心";
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"commentClose"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction)];
    self.navigationItem.leftBarButtonItem= leftBarButtonItem;
    [self create];
}

- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)create {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTH / 2, 40);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 40) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.scrollEnabled = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [_collectionView release];
    [_collectionView registerClass:[ColumnCollectionViewCell class] forCellWithReuseIdentifier:Identifier];
    
    self.smallView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH / 8, 104, WIDTH / 4, 2)];
    _smallView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_smallView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 106, WIDTH, HEIGHT - 106)];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(WIDTH * 2, HEIGHT - 106);
    [self.view addSubview:_scrollView];
    [_scrollView release];
    
    
    self.myImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NotLogin_image"]];
    _myImageView.center = CGPointMake(WIDTH / 2, _scrollView.frame.size.height / 2);
    [_scrollView addSubview:_myImageView];
    
    self.tabelView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT - 106) style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.rowHeight = 140;
    [_scrollView addSubview:_tabelView];
    [_tabelView release];
    [_tabelView registerClass:[ColumnTableViewCell class] forCellReuseIdentifier:identifier];
    // 刷新, 加载tablewView 方法
    _tabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(Refresh)];
    [_tabelView.mj_header beginRefreshing];
    _tabelView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(Loading)];
    
}

// 刷新
- (void)Refresh {
    
    [self getInfo:@"0"];
    [_tabelView.mj_header endRefreshing];
    
}

// 加载
- (void)Loading {
    if ([_boolString isEqual:@true]) {
        [self getInfo:_number];
    }
    [_tabelView.mj_footer endRefreshing];
}

#pragma mark - UIScrollView

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    if ([scrollView isEqual:_scrollView]) {
        if (scrollView.contentOffset.x < WIDTH) {
            NSIndexPath *index = [NSIndexPath indexPathForItem:0 inSection:0];
            ColumnCollectionViewCell *cell = (ColumnCollectionViewCell *)[_collectionView cellForItemAtIndexPath:index];
            cell.pieceLabel.textColor = [UIColor blackColor];
            NSIndexPath *index1 = [NSIndexPath indexPathForItem:1 inSection:0];
           ColumnCollectionViewCell *cellOther = (ColumnCollectionViewCell *)[_collectionView cellForItemAtIndexPath:index1];
            cellOther.pieceLabel.textColor = [UIColor grayColor];
        }else {
            NSIndexPath *index = [NSIndexPath indexPathForItem:1 inSection:0];
            ColumnCollectionViewCell *cell = (ColumnCollectionViewCell *)[_collectionView cellForItemAtIndexPath:index];
            cell.pieceLabel.textColor = [UIColor blackColor];
            NSIndexPath *index1 = [NSIndexPath indexPathForItem:0 inSection:0];
            ColumnCollectionViewCell *cellOther = (ColumnCollectionViewCell *)[_collectionView cellForItemAtIndexPath:index1];
            cellOther.pieceLabel.textColor = [UIColor grayColor];
        }
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:_scrollView]) {
        
        if (scrollView.contentOffset.x < WIDTH) {
            [UIView animateWithDuration:0.5f animations:^{
                _smallView.frame = CGRectMake(WIDTH / 8, 104, WIDTH / 4, 2);
            }];
        }else {
            [UIView animateWithDuration:0.5f animations:^{
                _smallView.frame = CGRectMake(WIDTH * 5 / 8, 104, WIDTH / 4, 2);
            }];
        }
    }
}

#pragma mark - UICollection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ColumnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    if (0 == indexPath.item) {
        cell.pieceLabel.text = @"我的订阅";
        
    }else {
        cell.pieceLabel.text = @"全部栏目";
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _scrollView.contentOffset = CGPointMake(WIDTH * indexPath.item, 0);
    ColumnCollectionViewCell *cell = (ColumnCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.pieceLabel.textColor = [UIColor blackColor];
    [UIView animateWithDuration:0.5f animations:^{
        _smallView.frame = CGRectMake(cell.center.x - (WIDTH / 8), 104, WIDTH / 4, 2);
    }];
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    ColumnCollectionViewCell *cell = (ColumnCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.pieceLabel.textColor = [UIColor grayColor];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ColumnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.yzy = _objectArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 网络请求

- (void)getInfo:(NSString *)number {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"%@/app3/columns/all_columns_index/%@.json?", kDevelopHostUrl, number];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (_objectArray.count > 0 && [number isEqual:@0] ) {
                [_objectArray removeAllObjects];
            }
            NSDictionary *response = [responseObject objectForKey:@"response"];
            self.boolString = [response objectForKey:@"has_more"];
            if ([_boolString isEqual:@true]) {
                self.number = [response objectForKey:@"last_key"];
            }
            for (NSDictionary *dic in [response objectForKey:@"columns"]) {
                YZYColumnModel *yzy = [YZYColumnModel modelWithDic:dic];
                [_objectArray addObject:yzy];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tabelView reloadData];
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
        }];
        
    });
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
