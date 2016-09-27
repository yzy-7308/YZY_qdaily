//
//  LoginViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (retain, nonatomic) IBOutlet UIView *LogoBGView;



@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:_LogoBGView];
    
    
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

- (void)dealloc {
   
    [_LogoBGView release];
    [super dealloc];
}
@end
