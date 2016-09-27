//
//  YZYBaseViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "YZYBaseViewController.h"

@interface YZYBaseViewController ()

@end

@implementation YZYBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
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
