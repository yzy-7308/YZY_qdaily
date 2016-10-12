//
//  AboutUsViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/4.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@property (nonatomic, retain)UIWebView *webView;

@property (nonatomic, retain) UIView *myView;

@property (nonatomic, retain) CAGradientLayer * shadow;

@end

@implementation AboutUsViewController

- (void)dealloc {
    _webView.delegate = nil;
    _webView.scrollView.delegate = nil;
    [_webView release];
    [_myView release];
    [_shadow release];
    [super dealloc];
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

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"关闭" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [_myView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_myView.mas_left).offset(20);
        make.top.equalTo(_myView.mas_top).offset(20);
        make.height.equalTo(@44);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"关于我们";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor whiteColor];
    [_myView addSubview:titleLabel];
    [titleLabel release];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_myView.mas_centerX);
        make.height.equalTo(@44);
        make.top.equalTo(_myView.mas_top).offset(20);
    }];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://app3.qdaily.com/app3/homes/aboutus.html"]];
    [_webView loadRequest:request];
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    [_webView release];
    
  
}

- (void)leftBarButtonItemAction {
    [self dismissViewControllerAnimated:YES completion:nil];
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
