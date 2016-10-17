//
//  CategoriesViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/9.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "CategoriesViewController.h"
#import "YZYLeftSidebar.h"
#import "OneTableViewCell.h"
#import "TwoTableViewCell.h"
#import "HttpAPIConst.h"
#import "YZYBaseModel.h"
#import "NewsViewController.h"


static NSString *const oneTableViewCell = @"oneCell";
static NSString *const twoTableViewCell = @"twoCell";


@interface CategoriesViewController ()

<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, retain) UIView *myView;

@property (nonatomic, retain) CAGradientLayer * shadow;

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, copy)NSString *number;

@property (nonatomic, retain)NSMutableArray *objectArray;


@end

@implementation CategoriesViewController

- (void)dealloc {
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    [_yzy release];
    [_shadow release];
    [_tableView release];
    [_myView release];
    [_shadow release];
    [_objectArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;

    self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, -64, WIDTH, 64)];
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
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"commentClose"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction)];
    self.navigationItem.leftBarButtonItem= leftBarButtonItem;
    
    self.navigationItem.title = _yzy.title;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.objectArray = [NSMutableArray array];
    [self createTableView];

}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    _tableView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [self.view addSubview:_tableView];

    [_tableView registerClass:[OneTableViewCell class] forCellReuseIdentifier:oneTableViewCell];
    [_tableView registerClass:[TwoTableViewCell class] forCellReuseIdentifier:twoTableViewCell];
    [_tableView release];
    
    // 刷新, 加载tablewView 方法
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(Refresh)];
    [_tableView.mj_header beginRefreshing];
    _tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(Loading)];
    
}

// 刷新
- (void)Refresh {
    
    [self getInfo:@"0"];
    [_tableView.mj_header endRefreshing];
    
}

// 加载
- (void)Loading {
    
    [self getInfo:_number];
    [_tableView.mj_footer endRefreshing];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZYBaseModel *yzy = _objectArray[indexPath.item];
    if (2 == yzy.type) {
        return (HEIGHT - 50) / 2 + 10;
    }
    return 130;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZYBaseModel *yzy = _objectArray[indexPath.row];
     if (2 == yzy.type) {
        TwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:twoTableViewCell];
        cell.yzy = _objectArray[indexPath.item];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneTableViewCell];
    cell.yzy = _objectArray[indexPath.item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YZYBaseModel *yzy = _objectArray[indexPath.row];
    NewsViewController *newsView = [[NewsViewController alloc] init];
    newsView.yzy = yzy;
    [self.navigationController pushViewController:newsView animated:YES];
    [newsView release];
    
}

// 网络请求
- (void)getInfo:(NSString *)number {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"%@/app3/categories/index/%@/%@.json?", kDevelopHostUrl, _yzy.myId, number];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (_objectArray.count > 0 && [number isEqual:@"0"] ) {
                [_objectArray removeAllObjects];
            }
            NSDictionary *response = [responseObject objectForKey:@"response"];
            self.number = [response objectForKey:@"last_key"];
            NSArray *feeds = [response objectForKey:@"feeds"];
            for (NSDictionary *dic in feeds) {
                YZYBaseModel *yzy = [YZYBaseModel modelWithDic:dic];
                [_objectArray addObject:yzy];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_tableView reloadData];
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
        }];
        
    });
    
}


- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
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
