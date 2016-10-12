//
//  CuriosityInstituteViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/4.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "CuriosityInstituteViewController.h"
#import "HttpAPIConst.h"
#import "YZYBaseModel.h"
#import "YZYPostModel.h"
#import "CuriosityTableViewCell.h"
#import "VoteViewController.h"
#import "SaidViewController.h"

static NSString *const zeroTableViewCell = @"zeroCell";

@interface CuriosityInstituteViewController ()

<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, retain) UIView *myView;

@property (nonatomic, retain) CAGradientLayer * shadow;

@property (nonatomic, retain)UITableView *tableView;

@property (nonatomic, retain)NSMutableArray *objectArray;

@property (nonatomic, copy)NSString *number;

@end

@implementation CuriosityInstituteViewController

- (void)dealloc {
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    [_myView release];
    [_shadow release];
    [_tableView release];
    [_objectArray release];
    [_number release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    self.objectArray = [NSMutableArray array];
    self.navigationItem.title = @"好奇心研究所";
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"commentClose"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction)];
    self.navigationItem.leftBarButtonItem= leftBarButtonItem;

    [self createTableView];
}

- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

// 网络请求
- (void)getInfo:(NSString *)number {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"%@/app3/papers/index/%@.json?", kDevelopHostUrl, number];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([number isEqual:@0] ) {
                [_objectArray removeAllObjects];
            }
            NSDictionary *response = [responseObject objectForKey:@"response"];
            self.number = [response objectForKey:@"last_key"];
            for (NSDictionary *dic in [response objectForKey:@"feeds"]) {
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

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT- 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[CuriosityTableViewCell class] forCellReuseIdentifier:zeroTableViewCell];
    
    [_tableView release];
    
    // 刷新, 加载tablewView 方法
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(Refresh)];
    [_tableView.mj_header beginRefreshing];
    _tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(Loading)];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return (HEIGHT * 0.8) / 2 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CuriosityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:zeroTableViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.yzy = _objectArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YZYBaseModel *yzy = _objectArray[indexPath.row];
    if(1000 == yzy.post.genre) {
        VoteViewController *vote = [[VoteViewController alloc] init];
        vote.yzy = _objectArray[indexPath.row];
        [self.navigationController pushViewController:vote animated:YES];
        [vote release];
    }else if (1001 == yzy.post.genre) {
        SaidViewController *said = [[SaidViewController alloc] init];
        said.yzy = yzy;
        said.myID = yzy.post.myId;
        [self.navigationController pushViewController:said animated:YES];
        [said release];
    }
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
