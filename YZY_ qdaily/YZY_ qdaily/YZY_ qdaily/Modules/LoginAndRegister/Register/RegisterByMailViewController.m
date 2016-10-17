//
//  RegisterByMailViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/1.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "RegisterByMailViewController.h"

@interface RegisterByMailViewController ()

<
UITextFieldDelegate
>

@property (retain, nonatomic) IBOutlet UILabel *registerNewlabel;

@property (retain, nonatomic) IBOutlet UIView *logoView;

@property (retain, nonatomic) IBOutlet UIButton *goBackButton;

@property (retain, nonatomic) IBOutlet UITextField *mailTextField;

@property (retain, nonatomic) IBOutlet UIView *mailView;

@property (retain, nonatomic) IBOutlet UITextField *passWordTextField;

@property (retain, nonatomic) IBOutlet UIView *passWordView;

@property (retain, nonatomic) IBOutlet UITextField *confirmTextField;

@property (retain, nonatomic) IBOutlet UIView *confirmView;

@property (retain, nonatomic) IBOutlet UILabel *needLookLabel;

@property (retain, nonatomic) IBOutlet UIButton *nextWayButton;





@end

@implementation RegisterByMailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:_myImage];
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    [imageView release];
    [_mailTextField setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
    [_passWordTextField setValue:[UIColor grayColor]forKeyPath:@"placeholderLabel.textColor"];
    [_confirmTextField setValue:[UIColor grayColor]forKeyPath:@"placeholderLabel.textColor"];
    
    
    [self.view addSubview:_registerNewlabel];
    [self.view addSubview:_logoView];
    [self.view addSubview:_goBackButton];
    [self.view addSubview:_mailTextField];
    [self.view addSubview:_mailView];
    [self.view addSubview:_passWordTextField];
    [self.view addSubview:_passWordView];
    [self.view addSubview:_confirmView];
    [self.view addSubview:_confirmTextField];
    [self.view addSubview:_needLookLabel];
    [self.view addSubview:_nextWayButton];
}


- (IBAction)goBackAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 点击return
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    //回收键盘
    
    [textField resignFirstResponder];
    
    //[textField endEditing:YES];
    
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

- (void)dealloc {
    [_registerNewlabel release];
    [_logoView release];
    [_goBackButton release];
    [_mailTextField release];
    [_mailView release];
    [_passWordTextField release];
    [_passWordView release];
    [_confirmTextField release];
    [_confirmView release];
    [_needLookLabel release];
    [_nextWayButton release];
    [super dealloc];
}
@end
