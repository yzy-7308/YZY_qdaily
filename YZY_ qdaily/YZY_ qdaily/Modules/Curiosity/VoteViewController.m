//
//  VoteViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/5.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "VoteViewController.h"
#import "YZYBaseModel.h"
#import "YZYPostModel.h"
#import "HttpAPIConst.h"
#import "YZYquestionsModel.h"
#import "YZYoptionsModel.h"
#import "VoteCollectionViewCell.h"

static NSString *const cellIdentifier = @"cell";
static NSString *const header = @"header";
static NSString *const footer = @"footer";


@interface VoteViewController ()

<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, retain) UIImageView *myImageView;

@property (nonatomic, retain) YZYquestionsModel *xjj;

@property (nonatomic, retain)UIImageView *smallImageView;

@end

@implementation VoteViewController

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    [_xjj release];
    [_yzy release];
    [_smallImageView release];
    [_collectionView release];
    [_myImageView release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self create];
    [self getInfo];
    [self createFloating];
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];

}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)createFloating {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"navigation_back_round_normal"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    [button handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)getInfo {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@/app3/papers/detail/%@.json?", kDevelopHostUrl, _yzy.post.myId];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_xjj.options.count > 0) {
            [_xjj.options removeAllObjects];
        }
        NSDictionary *response = [responseObject objectForKey:@"response"];
        YZYBaseModel *yzy = [YZYBaseModel modelWithDic:response];
        self.xjj = [yzy.questions firstObject];
        [_collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}

- (void)create {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTH - 40, 90);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds  collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.contentInset = UIEdgeInsetsMake(HEIGHT / 4 , 0, 0, 0);
    _collectionView.allowsMultipleSelection = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[VoteCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [flowLayout release];
    [_collectionView release];
    // 头视图尺寸
    flowLayout.headerReferenceSize = CGSizeMake(100, 80);
    // 尾视图尺寸
    flowLayout.footerReferenceSize = CGSizeMake(100, 120);
    // 注册头视图
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header];
    // 注册尾视图
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footer];
    [self.view addSubview:_collectionView];
    
    self.myImageView = [[UIImageView alloc] init];
     [_myImageView sd_setImageWithURL:[NSURL URLWithString:_yzy.image]];
    _myImageView.frame = CGRectMake(0, - HEIGHT / 4, WIDTH, HEIGHT/ 4);
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
    smallLaebl.text = [NSString stringWithFormat:@"%@", _yzy.post.record_count];
    [self.view addSubview:smallLaebl];
    [smallLaebl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_smallImageView.mas_top).offset(5);
        make.left.equalTo(_smallImageView.mas_left).offset(5);
        make.right.equalTo(_smallImageView.mas_right).offset(-5);
        make.bottom.equalTo(_smallImageView.mas_bottom).offset(-30);
    }];
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    // 如果是header
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = _yzy.post.title;
        titleLabel.numberOfLines = 0;
        [titleLabel sizeToFit];
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.text = _yzy.post.myDescription;
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
    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footer forIndexPath:indexPath];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"投票" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 20;
    button.frame = CGRectMake(20, 20, 374, 40);
    [footerView addSubview:button];
    return footerView;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 返回item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _xjj.options.count;
}

// 设置collectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 从重用池取cell
    VoteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.yzy = _xjj.options[indexPath.item];
    cell.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat offsetH = offsetY + (HEIGHT / 4);
    if (offsetH < 0) {
        CGRect frame = _myImageView.frame;
        // tableView向下偏移多少, 高度就是多少
        frame.origin.y =  -(HEIGHT / 4) + offsetH;
        frame.size.height = (HEIGHT / 4) - offsetH;
        _myImageView.frame = frame;
    }else {
        _myImageView.frame = CGRectMake(0, -(HEIGHT / 4), WIDTH, (HEIGHT / 4));
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
