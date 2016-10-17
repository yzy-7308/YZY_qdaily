//
//  CategoryViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/4.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@property (nonatomic, retain) UIView *myView;

@property (nonatomic, retain) CAGradientLayer * shadow;

@end

@implementation CategoryViewController

- (void)dealloc {
    [_titleString release];
    [_myView release];
    [_shadow release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
        self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    // 添加渐变色层
    _myView.backgroundColor = [UIColor whiteColor];
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
    
    self.navigationItem.title = _titleString;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
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
