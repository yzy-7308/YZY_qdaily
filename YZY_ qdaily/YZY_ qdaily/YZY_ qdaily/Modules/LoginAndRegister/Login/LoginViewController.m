//
//  LoginViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

<
UITextFieldDelegate
>

@property (retain, nonatomic) IBOutlet UIView *LogoBGView;

@property (retain, nonatomic) IBOutlet UIButton *goBackButton;

@property (retain, nonatomic) IBOutlet UILabel *LoginLabel;

@property (retain, nonatomic) IBOutlet UITextField *UserTextField;

@property (retain, nonatomic) IBOutlet UIView *UserView;

@property (retain, nonatomic) IBOutlet UITextField *PassWordTextField;

@property (retain, nonatomic) IBOutlet UIView *PassWordView;

@property (retain, nonatomic) IBOutlet UIButton *ForgetButton;

@property (retain, nonatomic) IBOutlet UIButton *LoginButton;

@property (retain, nonatomic) IBOutlet UIButton *NewUserButton;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:_myImage];
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    [imageView release];
    [_UserTextField setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
    [_PassWordTextField setValue:[UIColor grayColor]forKeyPath:@"placeholderLabel.textColor"];
    

    
    [self.view addSubview:_LogoBGView];
    [self.view addSubview:_goBackButton];
    [self.view addSubview:_LoginLabel];
    [self.view addSubview:_UserTextField];
    [self.view addSubview:_UserView];
    [self.view addSubview:_PassWordTextField];
    [self.view addSubview:_PassWordView];
    [self.view addSubview:_ForgetButton];
    [self.view addSubview:_LoginButton];
    [self.view addSubview:_NewUserButton];
   
}

// 点击return
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    //回收键盘

    [textField resignFirstResponder];

    //[textField endEditing:YES];
  
    return YES;
    
}

- (IBAction)goBackAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)forgetAction:(id)sender {
}

- (IBAction)loginAction:(id)sender {
    
    
    NSString *boundary = @"Boundary+C4951AC9FFB55C27";
    NSString *MPboundary = [NSString stringWithFormat:@"--%@", boundary];
    NSString *endMPboundary = [NSString stringWithFormat:@"%@--", MPboundary];
    NSMutableString *body = [[NSMutableString alloc] init];
    [body appendFormat:@"%@\r\n", MPboundary];
    [body appendFormat:@"Content-Disposition: form-data; name=\"user[password]\"\r\n\r\n"];
    [body appendFormat:@"%@\r\n", _PassWordTextField.text];
    [body appendFormat:@"%@\r\n", MPboundary];
    [body appendFormat:@"Content-Disposition: form-data; name=\"user[phone]\"\r\n\r\n"];
    [body appendFormat:@"%@\r\n", _UserTextField.text];
    [body appendFormat:@"%@\r\n", MPboundary];
    [body appendFormat:@"Content-Disposition: form-data; name=\"user[remember_me]\"\r\n\r\n"];
    [body appendFormat:@"1\r\n"];
    [body appendFormat:@"%@\r\n", endMPboundary];
    
    NSString *end = [NSString stringWithFormat:@"%@", endMPboundary];
    
    NSMutableData *myRequestData = [NSMutableData data];
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *content = [NSString stringWithFormat:@"multipart/form-data; boundary=Boundary+C4951AC9FFB55C27"];
    NSString *length = [NSString stringWithFormat:@"316"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:content forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:length forHTTPHeaderField:@"Content-Length"];
   
    NSString *url = @"http://app3.qdaily.com/users/phone_sign_in";
    [manager POST:url parameters:myRequestData progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *meta = [responseObject objectForKey:@"meta"];
        NSString *msg = [meta objectForKey:@"msg"];
        NSLog(@"登录成功%@", msg);
        [UIView showMessage:@"登录成功"];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@", error);
         [UIView showMessage:@"登录失败"];
    }];

    
    
    
    
}
- (IBAction)newUserAction:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   }


- (void)dealloc {
   
    [_LogoBGView release];
    [_goBackButton release];
    [_LoginLabel release];
    [_UserTextField release];
    [_UserView release];
    [_PassWordTextField release];
    [_PassWordView release];
    [_ForgetButton release];
    [_LoginButton release];
    [_NewUserButton release];
    [super dealloc];
}
@end
