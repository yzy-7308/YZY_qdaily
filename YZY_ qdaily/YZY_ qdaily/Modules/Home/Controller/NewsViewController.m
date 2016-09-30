//
//  NewsViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/26.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "NewsViewController.h"
#import <AFNetworking.h>
#import "HttpAPIConst.h"
#import "YZYBaseModel.h"
#import "YZYPostModel.h"


@interface NewsViewController ()

<UIScrollViewDelegate>

@property (nonatomic, retain)UIWebView *webView;

@property (nonatomic, assign) CGFloat start;

@end

@implementation NewsViewController

- (void)dealloc{
    _webView.delegate = nil;
    _webView.scrollView.delegate = nil;
    [_yzy release];
    [_webView release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.hidesBackButton =YES;
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
     self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@/app3/articles/info/%@.json?", kDevelopHostUrl, _yzy.post.myId];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDic = [responseObject objectForKey:@"response"];
        NSDictionary *postDic = [responseDic objectForKey:@"post"];
        NSString *appview = [postDic objectForKey:@"appview"];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:appview]]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    [_webView release];
    
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
//    NSLog(@"loading");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    NSLog(@"finish");
 
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    NSLog(@"fail");
    
}

// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _start = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [UIView animateWithDuration:1.5f animations:^{
        if (_start < scrollView.contentOffset.y) {
            [[UIApplication sharedApplication] setStatusBarHidden:YES];
            _webView.frame = CGRectMake(0, 0, WIDTH, HEIGHT + 20);
        }else if (_start > scrollView.contentOffset.y) {
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            _webView.scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
            [self setStatusBarBackgroundColor:[UIColor whiteColor]];
        }
    }];

}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
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
