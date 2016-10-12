//
//  RegisterViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/1.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterByMailViewController.h"
#import "LoginViewController.h"


@interface RegisterViewController ()

<
UITextFieldDelegate
>

@property (retain, nonatomic) IBOutlet UIButton *goBackButton;

@property (retain, nonatomic) IBOutlet UITextField *phoneNumTextField;

@property (retain, nonatomic) IBOutlet UITextField *verificationCodeTextField;

@property (retain, nonatomic) IBOutlet UIButton *sendCodeButton;

@property (retain, nonatomic) IBOutlet UILabel *needLookLabel;

@property (retain, nonatomic) IBOutlet UIButton *nextWayButton;

@property (retain, nonatomic) IBOutlet UIButton *registerByMailButton;

@property (retain, nonatomic) IBOutlet UIButton *loginByQdaily;

@property (retain, nonatomic) IBOutlet UIButton *loginByWeiXin;

@property (retain, nonatomic) IBOutlet UIButton *loginByWeibo;

@property (retain, nonatomic) IBOutlet UIButton *loginByQQ;

@property (retain, nonatomic) IBOutlet UIView *logoView;

@property (retain, nonatomic) IBOutlet UIView *phoneNumView;

@property (retain, nonatomic) IBOutlet UIView *verificationCodeView;

@property (retain, nonatomic) IBOutlet UILabel *ThirdLoginLabel;

@property (retain, nonatomic) IBOutlet UILabel *weiXinLabel;

@property (retain, nonatomic) IBOutlet UILabel *weiBoLabel;

@property (retain, nonatomic) IBOutlet UILabel *QQLabel;


@property (retain, nonatomic) IBOutlet UILabel *registerNewLabel;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:_myImage];
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    [imageView release];
    [_phoneNumTextField setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
    [_verificationCodeTextField setValue:[UIColor grayColor]forKeyPath:@"placeholderLabel.textColor"];

    [self.view addSubview:_registerNewLabel];
    [self.view addSubview:_goBackButton];
    [self.view addSubview:_phoneNumTextField];
    [self.view addSubview:_verificationCodeTextField];
    [self.view addSubview:_sendCodeButton];
    [self.view addSubview:_needLookLabel];
    [self.view addSubview:_nextWayButton];
    [self.view addSubview:_registerByMailButton];
    [self.view addSubview:_loginByQQ];
    [self.view addSubview:_loginByWeibo];
    [self.view addSubview:_loginByQdaily];
    [self.view addSubview:_loginByWeiXin];
    [self.view addSubview:_logoView];
    [self.view addSubview:_phoneNumView];
    [self.view addSubview:_verificationCodeView];
    [self.view addSubview:_ThirdLoginLabel];
    [self.view addSubview:_weiXinLabel];
    [self.view addSubview:_weiBoLabel];
    [self.view addSubview:_QQLabel];
}

- (IBAction)boBackAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)registerByMailAction:(id)sender {
    RegisterByMailViewController *mail = [[RegisterByMailViewController alloc] init];
    mail.myImage = _myImage;
    [self presentViewController:mail animated:YES completion:nil];
    [mail release];
}

- (IBAction)loginByQdailyAction:(id)sender {
    LoginViewController *login = [[LoginViewController alloc] init];
    login.myImage = _myImage;
    [self presentViewController:login animated:YES completion:nil];
    [login release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 点击return
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    //回收键盘
    
    [textField resignFirstResponder];
    
    //[textField endEditing:YES];
    
    return YES;
    
}

- (void)dealloc {
    [_goBackButton release];
    [_phoneNumTextField release];
    [_verificationCodeTextField release];
    [_sendCodeButton release];
    [_needLookLabel release];
    [_nextWayButton release];
    [_registerByMailButton release];
    [_loginByQdaily release];
    [_loginByWeiXin release];
    [_loginByWeibo release];
    [_loginByQQ release];
    [_logoView release];
    [_phoneNumView release];
    [_verificationCodeView release];
    [_ThirdLoginLabel release];
    [_weiXinLabel release];
    [_weiBoLabel release];
    [_QQLabel release];
    [_registerNewLabel release];
    [super dealloc];
}
@end
