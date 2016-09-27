//
//  RootViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "RootViewController.h"
#import "CarouselView.h"
#import <AFNetworking.h>
#import "HttpAPIConst.h"
#import "YZYBaseModel.h"
#import "ZeroTableViewCell.h"
#import "OneTableViewCell.h"
#import "TwoTableViewCell.h"
#import <Masonry.h>
#import <MJRefresh.h>

static NSString *const zeroTableViewCell = @"zeroCell";
static NSString *const oneTableViewCell = @"oneCell";
static NSString *const twoTableViewCell = @"twoCell";


#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

// Zapfino 字体
@interface RootViewController ()

<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, retain)UITableView *tableView;

@property (nonatomic, retain)NSMutableArray *objectArray;

@property (nonatomic, retain)NSMutableArray *carouselArray;

@property (nonatomic, copy)NSString *number;

@end

@implementation RootViewController

- (void)viewWillAppear:(BOOL)animated {
    
//    [self performSelector:@selector(hidden) withObject:nil afterDelay:0.5];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = YES;
    self.objectArray = [NSMutableArray array];
    self.carouselArray = [NSMutableArray array];
    
    [self createTableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[ZeroTableViewCell class] forCellReuseIdentifier:zeroTableViewCell];
    [_tableView registerClass:[OneTableViewCell class] forCellReuseIdentifier:oneTableViewCell];
    [_tableView registerClass:[TwoTableViewCell class] forCellReuseIdentifier:twoTableViewCell];
    [_tableView release];
    
    
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(Refresh)];
    [_tableView.mj_header beginRefreshing];
    _tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(Loading)];
    
    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZYBaseModel *yzy = _objectArray[indexPath.item];
     if (0 == yzy.type) {
        ZeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:zeroTableViewCell];
        cell.yzy = _objectArray[indexPath.item];
        return cell;
     }else if (2 == yzy.type) {
         TwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:twoTableViewCell];
         cell.yzy = _objectArray[indexPath.item];
         return cell;
     }
    OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneTableViewCell];
    cell.yzy = _objectArray[indexPath.item];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZYBaseModel *yzy = _objectArray[indexPath.item];
    if (0 == yzy.type) {
        return HEIGHT / 2 - 10;
    }else if (2 == yzy.type) {
        return HEIGHT / 2 + 10;
    }
    return 135;
    
}

- (void)Refresh {
    
    [self getInfo:@"0"];
    [_tableView.mj_header endRefreshing];
    
}

- (void)Loading {
    
    [self getInfo:_number];
    [_tableView.mj_footer endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectArray.count;
}

- (void)getInfo:(NSString *)number {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"%@/app3/homes/index/%@.json?", kDevelopHostUrl, number];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (_carouselArray.count > 0 && [number isEqualToString:@"0"] ) {
                [_objectArray removeAllObjects];
                [_carouselArray removeAllObjects];
            }
            
            NSDictionary *response = [responseObject objectForKey:@"response"];
            self.number = [response objectForKey:@"last_key"];
            NSArray *feeds = [response objectForKey:@"feeds"];
            for (NSDictionary *dic in feeds) {
                YZYBaseModel *yzy = [YZYBaseModel modelWithDic:dic];
                [_objectArray addObject:yzy];
            }
            NSArray *banners = [response objectForKey:@"banners"];
            for (NSDictionary *dic in banners) {
                YZYBaseModel *yzy = [YZYBaseModel modelWithDic:dic];
                [_carouselArray addObject:yzy];
            }
            CarouselView *carouseView = [[CarouselView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT / 10 * 4.13)];
            carouseView.YZYArray = _carouselArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                _tableView.tableHeaderView = carouseView;
                [_tableView reloadData];
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
        }];
        
    });
    
   
 
}

- (void) hidden {
    // 启动动画
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LaunchImage-700"]];
    background.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:background];
    [background release];
    
    [UIView animateWithDuration:2.f animations:^{
        background.alpha = 0.0;
    } completion:^(BOOL finished) {
        [background removeFromSuperview];
    }];
    
    [UIView animateWithDuration:3 animations:^{
        background.alpha = 0.0;
        // 背景色设置成clearColor，不然动画结束感觉ViewController是跳出来的。
        self.view.backgroundColor = [UIColor clearColor];
        
    } completion:^(BOOL finished) {
        
        [self.view removeFromSuperview];
    }];
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
