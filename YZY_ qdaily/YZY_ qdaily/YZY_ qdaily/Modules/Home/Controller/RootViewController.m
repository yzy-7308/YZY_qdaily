//
//  RootViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "RootViewController.h"
#import "CarouselView.h"
#import "HttpAPIConst.h"
#import "YZYBaseModel.h"
#import "ZeroTableViewCell.h"
#import "OneTableViewCell.h"
#import "TwoTableViewCell.h"
#import "NewsViewController.h"
#import "YZYPostModel.h"
#import "FloatingActionButton.h"
#import "MenuViewController.h"
#import "YZYLeftSidebar.h"
#import "VoteViewController.h"
#import "SaidViewController.h"


static NSString *const zeroTableViewCell = @"zeroCell";
static NSString *const oneTableViewCell = @"oneCell";
static NSString *const twoTableViewCell = @"twoCell";





@interface RootViewController ()

<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, retain)UITableView *tableView;

@property (nonatomic, retain)NSMutableArray *objectArray;

@property (nonatomic, retain)NSMutableArray *carouselArray;

@property (nonatomic, retain)NSMutableArray *leftArray;

@property (nonatomic, copy)NSString *number;

@property (nonatomic, assign) CGFloat start;

@property (nonatomic, retain) FloatingActionButton *menuButton;

@end

@implementation RootViewController

- (void)dealloc {
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    [_leftArray release];
    [_tableView release];
    [_objectArray release];
    [_carouselArray release];
    [_number release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
    self.objectArray = [NSMutableArray array];
    self.carouselArray = [NSMutableArray array];
    self.leftArray = [NSMutableArray array];
    [self getLeft_sidebar];
    [self createTableView];
    [self createFloatingButton];
    
    
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _start = scrollView.contentOffset.y;
}

// 结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (0 == _menuButton.alpha) {
        [UIView animateWithDuration:0.2f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _menuButton.alpha = 1;
        } completion:nil];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y > 300) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        [self setStatusBarBackgroundColor:[UIColor whiteColor]];
    }else {
        [self setStatusBarBackgroundColor:[UIColor clearColor]];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        if (_start < scrollView.contentOffset.y) {
            _menuButton.alpha = 0;
        }else if (_start > scrollView.contentOffset.y) {
            _menuButton.alpha = 1;
        }
    }];
    
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    _tableView.separatorStyle = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[ZeroTableViewCell class] forCellReuseIdentifier:zeroTableViewCell];
    [_tableView registerClass:[OneTableViewCell class] forCellReuseIdentifier:oneTableViewCell];
    [_tableView registerClass:[TwoTableViewCell class] forCellReuseIdentifier:twoTableViewCell];
    [_tableView release];
    
    // 刷新, 加载tablewView 方法
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(Refresh)];
    [_tableView.mj_header beginRefreshing];
    _tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(Loading)];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YZYBaseModel *yzy = _objectArray[indexPath.row];
    if (0 == yzy.type) {
        if(1000 == yzy.post.genre) {
            VoteViewController *vote = [[VoteViewController alloc] init];
            vote.yzy = _objectArray[indexPath.row];
            [self.navigationController pushViewController:vote animated:YES];
            [vote release];
        }else if (1001 == yzy.post.genre) {
            SaidViewController *said = [[SaidViewController alloc] init];
            said.myID = yzy.post.myId;
            [self.navigationController pushViewController:said animated:YES];
            [said release];
        }
    }else {
        NewsViewController *newsView = [[NewsViewController alloc] init];
        newsView.yzy = yzy;
        [self.navigationController pushViewController:newsView animated:YES];
        [newsView release];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZYBaseModel *yzy = _objectArray[indexPath.row];
    if (0 == yzy.type) {
        ZeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:zeroTableViewCell];
        cell.yzy = _objectArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (2 == yzy.type) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZYBaseModel *yzy = _objectArray[indexPath.item];
    if (0 == yzy.type) {
        return (HEIGHT - 50) / 2 - 10;
    }else if (2 == yzy.type) {
        return (HEIGHT - 50) / 2 + 10;
    }
    return 130;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectArray.count;
}

// 网络请求
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
            carouseView.dealWithYzy = ^(YZYBaseModel *yzy) {
                NewsViewController *newsView = [[NewsViewController alloc] init];
                newsView.yzy = yzy;
                [self.navigationController pushViewController:newsView animated:YES];
                [newsView release];
            };
            dispatch_async(dispatch_get_main_queue(), ^{
                _tableView.tableHeaderView = carouseView;
                [_tableView reloadData];
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
        }];
        
    });
    
}

- (void)hidden {
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
    
    //    [UIView animateWithDuration:3 animations:^{
    //        background.alpha = 0.0;
    //        // 背景色设置成clearColor，不然动画结束感觉ViewController是跳出来的。
    //        self.view.backgroundColor = [UIColor clearColor];
    //
    //    } completion:^(BOOL finished) {
    //
    //        [self.view removeFromSuperview];
    //    }];
}


- (void)createFloatingButton {
    self.menuButton = [[FloatingActionButton alloc] initWithFrame:CGRectMake(20, HEIGHT - 70, 50, 50)];
    UIImage *image = [UIImage imageNamed:@"Page_One_Logo"];
    UIImage *newImage = [self scaleFromImage:image toSize:CGSizeMake(22, 40)];
    [_menuButton setImage:newImage forState:UIControlStateNormal];
    [_menuButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        
        MenuViewController *menuVC = [[MenuViewController alloc] init];
        menuVC.leftArray = _leftArray;
        menuVC.VC = self;
        menuVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        menuVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:menuVC animated:NO completion:nil];
        [menuVC release];
    } ];
    [self.view bringSubviewToFront:_menuButton];
    [self.view addSubview:_menuButton];
    
}

- (UIImage *)scaleFromImage:(UIImage *)image toSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)getLeft_sidebar {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@/app3/homes/left_sidebar.json?", kDevelopHostUrl];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = [responseObject objectForKey:@"response"];
        for (NSDictionary *dic in array) {
            YZYLeftSidebar *left = [YZYLeftSidebar modelWithDic:dic];
            [_leftArray addObject:left];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"left_error : %@", error);
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
