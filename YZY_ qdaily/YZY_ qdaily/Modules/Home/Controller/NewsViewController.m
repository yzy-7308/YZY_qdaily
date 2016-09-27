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

@interface NewsViewController ()

@property (nonatomic, retain)UIActivityIndicatorView *act;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@/app3/articles/detail/32639.json", kDevelopHostUrl];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDic = [responseObject objectForKey:@"response"];
        NSDictionary *articleDic = [responseDic objectForKey:@"article"];
        NSString *htmlString = [articleDic objectForKey:@"body"];
        NSLog(@"sssss :%@", htmlString);
         [webView loadHTMLString:htmlString baseURL:nil];
//        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://app3.qdaily.com/assets/qdaily/injection/jsbridge-e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855.js"]]];
       
        
        
//        [webView stringByEvaluatingJavaScriptFromString:@"http://app3.qdaily.com/assets/qdaily/injection/jsbridge-e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855.js"];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [webView setDelegate:self];
    [self.view addSubview:webView];
    webView.scalesPageToFit = YES;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"loading");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"finish");
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"fail");
    
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
