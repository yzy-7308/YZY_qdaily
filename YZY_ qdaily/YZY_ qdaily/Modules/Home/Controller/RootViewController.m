//
//  RootViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "RootViewController.h"
#import "CarouselView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation RootViewController

- (void)viewWillAppear:(BOOL)animated {
    
//    [self performSelector:@selector(hidden) withObject:nil afterDelay:0.5];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CarouselView *carouseView = [[CarouselView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT / 7 * 3)];
    [self.view addSubview:carouseView];
}

- (void) hidden {
    // 启动动画
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LaunchImage-700"]];
    background.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:background];
    
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
