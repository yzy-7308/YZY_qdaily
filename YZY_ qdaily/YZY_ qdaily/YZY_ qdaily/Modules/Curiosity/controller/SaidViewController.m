//
//  SaidViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/7.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "SaidViewController.h"
#import "YZYBaseModel.h"
#import "YZYPostModel.h"
#import "HttpAPIConst.h"
#import "YZYoptionsModel.h"
#import "SaidCollectionViewCell.h"

static NSString *const cellIdentifier = @"cell";
static NSString *const header = @"header";

@interface SaidViewController ()

<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, retain) UIImageView *myImageView;

@property (nonatomic, retain)UIImageView *smallImageView;

@property (nonatomic, copy)NSNumber *number;

@property (nonatomic, retain)NSMutableArray *objectArray;

@property (nonatomic, retain)NSMutableArray *barrageArray;

@property (nonatomic, retain)YZYPostModel *xjj;

@end

@implementation SaidViewController

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    [_barrageArray release];
    [_xjj release];
    [_collectionView release];
    [_myImageView release];
    [_smallImageView release];
    [_number release];
    [_objectArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
    self.navigationController.navigationBar.hidden = YES;
    self.barrageArray = [NSMutableArray array];
    self.objectArray = [NSMutableArray array];
    [self getImage];
    [self create];
}

- (void)create {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((WIDTH - 50) / 2,(WIDTH - 50) / 2);
    //    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds  collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.contentInset = UIEdgeInsetsMake(HEIGHT / 2.5 , 0, 0, 0);
    _collectionView.allowsMultipleSelection = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[SaidCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [flowLayout release];
    [_collectionView release];
    // 头视图尺寸
    flowLayout.headerReferenceSize = CGSizeMake(100, 80);
    
    // 注册头视图
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header];
    
    [self.view addSubview:_collectionView];
    
    
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(Refresh)];
    [_collectionView.mj_header beginRefreshing];
    _collectionView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(Loading)];
}

// 刷新
- (void)Refresh {
    
    [self getInfo:0];
    [_collectionView.mj_header endRefreshing];
    
}

// 加载
- (void)Loading {
    
    [self getInfo:_number];
    [_collectionView.mj_footer endRefreshing];
}

- (void)getInfo:(NSNumber *)number {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@/app3/options/index/%@/%@.json?", kDevelopHostUrl, _myID, number];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *response = [responseObject objectForKey:@"response"];
        self.number = [response objectForKey:@"last_key"];
        for (NSDictionary *dic in [response objectForKey:@"options"]) {
            YZYoptionsModel *yzy = [YZYoptionsModel modelWithDic:dic];
            [_objectArray addObject:yzy];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_collectionView reloadData];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}

- (void)getImage {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@/app3/papers/detail/%@.json?", kDevelopHostUrl, _myID];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *response = [responseObject objectForKey:@"response"];
        self.xjj = [YZYPostModel modelWithDic:[response objectForKey:@"post"]];
        NSLog(@"aaa :%@", _xjj);
        self.myImageView = [[UIImageView alloc] init];
        [_myImageView sd_setImageWithURL:[NSURL URLWithString:_xjj.myImage]];
        NSLog(@"%@", _xjj.myImage);
        _myImageView.frame = CGRectMake(0, - HEIGHT / 2.5, WIDTH, HEIGHT/ 2.5);
        _myImageView.contentMode = UIViewContentModeScaleAspectFill;
        _myImageView.clipsToBounds = YES;
        [_collectionView addSubview:_myImageView];
        [self.view addSubview:_collectionView];
        
        self.smallImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Lab_Vote_Join"]];
        [self.view addSubview:_smallImageView];
        [_smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(30);
            make.right.equalTo(self.view.mas_right).offset(-20);
            make.width.equalTo(@70);
            make.height.equalTo(@50);
        }];
        
        UILabel *smallLaebl = [[UILabel alloc] init];
        smallLaebl.font = [UIFont fontWithName:@"Georgia" size:15];
        smallLaebl.textColor = [UIColor orangeColor];
        smallLaebl.textAlignment = NSTextAlignmentCenter;
        smallLaebl.text = [NSString stringWithFormat:@"%@", _xjj.record_count];
        [self.view addSubview:smallLaebl];
        [smallLaebl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_smallImageView.mas_top).offset(5);
            make.left.equalTo(_smallImageView.mas_left).offset(5);
            make.right.equalTo(_smallImageView.mas_right).offset(-5);
            make.bottom.equalTo(_smallImageView.mas_bottom).offset(-30);
        }];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"navigation_back_round_normal"] forState:UIControlStateNormal];
        [self.view addSubview:button];
        [self.view bringSubviewToFront:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(20);
            make.bottom.equalTo(self.view.mas_bottom).offset(-20);
            make.width.equalTo(@50);
            make.height.equalTo(@50);
        }];
        [button handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        
        for (NSDictionary *dic in [response objectForKey:@"options"]) {
            YZYoptionsModel *yzy = [YZYoptionsModel modelWithDic:dic];
            [_barrageArray addObject:yzy];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat offsetH = offsetY + (HEIGHT / 2.5);
    if (offsetH < 0) {
        CGRect frame = _myImageView.frame;
        // tableView向下偏移多少, 高度就是多少
        frame.origin.y =  -(HEIGHT / 2.5) + offsetH;
        frame.size.height = (HEIGHT / 2.5) - offsetH;
        _myImageView.frame = frame;
    }else {
        _myImageView.frame = CGRectMake(0, -(HEIGHT / 2.5), WIDTH, (HEIGHT / 2.5));
    }
    if (scrollView.contentOffset.y > 0) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        [self setStatusBarBackgroundColor:[UIColor whiteColor]];
    }else {
        [self setStatusBarBackgroundColor:[UIColor clearColor]];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
    
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _objectArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SaidCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.yzy = _objectArray[indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = _xjj.title;
    titleLabel.numberOfLines = 0;
    [titleLabel sizeToFit];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.text = _xjj.myDescription;
    descLabel.numberOfLines = 0;
    [descLabel sizeToFit];
    descLabel.textColor = [UIColor grayColor];
    descLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    [headerView addSubview:titleLabel];
    [headerView addSubview:descLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(20);
        make.top.equalTo(headerView.mas_top).offset(5);
        make.width.equalTo(@(WIDTH - 40));
        make.height.equalTo(@30);
    }];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(20);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.width.equalTo(@(WIDTH - 40));
        make.bottom.equalTo(headerView.mas_bottom).offset(-20);
    }];
    return headerView;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
