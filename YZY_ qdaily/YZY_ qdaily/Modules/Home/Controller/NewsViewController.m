//
//  NewsViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/26.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "NewsViewController.h"
#import "HttpAPIConst.h"
#import "YZYBaseModel.h"
#import "YZYPostModel.h"
#import "ShowNewsViewController.h"


@interface NewsViewController ()

<
UIWebViewDelegate,
UIScrollViewDelegate
>


@property (nonatomic, retain)UIWebView *webView;

@property (nonatomic, assign) CGFloat start;

@property (nonatomic, retain)UIImageView *myImageView;

@property (nonatomic, assign)NSInteger count;

@property (nonatomic, retain)UIButton *button;

@end

@implementation NewsViewController

- (void)dealloc{
    _webView.delegate = nil;
    _webView.scrollView.delegate = nil;
    [_yzy release];
    [_url release];
    [_webView release];
    [_myImageView release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    if (0 == _count) {
        self.myImageView = [[UIImageView alloc] init];
        [self.view addSubview:_myImageView];
        [_myImageView release];
        [_myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY);
            make.width.equalTo(@150);
            make.height.equalTo(@150);
        }];
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 0; i < 93; i++) {
            NSString *imageName = [NSString stringWithFormat: @"QDArticleLoading_%03d", i];
            UIImage *image = [UIImage imageNamed:imageName];
            [imageArray addObject:image];
        }
        _myImageView.animationImages = imageArray;
        _myImageView.animationDuration = 0.05 * imageArray.count;
        [_myImageView startAnimating];
    }
    _count++;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    self.navigationItem.hidesBackButton =YES;
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self createWebView];
    [self createFloating];

    
    
}
- (void)createWebView {
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
    [_myImageView stopAnimating];
    [_myImageView removeFromSuperview];
 
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    NSLog(@"fail");
    
}

// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _start = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [UIView animateWithDuration:0.5f animations:^{
        if (_start < scrollView.contentOffset.y) {
            _button.alpha = 0;
            [[UIApplication sharedApplication] setStatusBarHidden:YES];
            _webView.frame = CGRectMake(0, 0, WIDTH, HEIGHT );
        }else if (_start > scrollView.contentOffset.y) {
            _button.alpha = 1;
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            _webView.scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
            [self setStatusBarBackgroundColor:[UIColor whiteColor]];
        }
    }];
}

- (void)createFloating {
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setImage:[UIImage imageNamed:@"navigation_back_round_normal"] forState:UIControlStateNormal];
    [self.view addSubview:_button];
    [self.view bringSubviewToFront:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    [_button handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if (([UIApplication sharedApplication].statusBarHidden = YES)) {
             [[UIApplication sharedApplication] setStatusBarHidden:NO];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}


- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url= [NSString stringWithFormat:@"%@",request.URL];
    if ([url hasPrefix:@"http://m.qdaily.com/mobile/articles"]) {
        NSString *myId = [url substringWithRange:NSMakeRange(36, 5)];
        ShowNewsViewController *show = [[ShowNewsViewController alloc] init];
        show.url = myId;
        [_myImageView stopAnimating];

        [self.navigationController pushViewController:show animated:YES];
        [show release];
        [myId release];
        return NO;
    }
    
    
    return YES;
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
