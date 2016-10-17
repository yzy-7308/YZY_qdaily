//
//  MenuViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"
#import "CategoriesOfNews.h"
#import "RegisterByMailViewController.h"
#import "AboutUsViewController.h"
#import "CuriosityInstituteViewController.h"
#import "CategoriesViewController.h"
#import "RegisterViewController.h"
#import "UIImage+Categories.h"
#import "SystemSettingsViewController.h"
#import "SearchViewController.h"
#import "ColumnCenterViewController.h"

static NSString *const menuIdentifier = @"menuCell";

@interface MenuViewController ()

<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSArray *imageArray;

@property (nonatomic, retain) NSArray *titleArray;

@property (nonatomic, retain) CategoriesOfNews *myView;

@property (nonatomic, retain) UIButton *goBackButton;

@property (nonatomic, retain) UIButton *goHomeButton;

@end

@implementation MenuViewController

- (void)dealloc {
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    [_myView release];
    [_titleArray release];
    [_imageArray release];
    [_tableView release];
    [_leftArray release];
    [_VC release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
//    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
//    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

    [self createFloatingButton];
    [self createTop];
    [self creatrArray];
    [self createTableView];
    [self createNewsCategory];
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)createTop {
    
    UIButton *label = [[UIButton alloc] initWithFrame:CGRectZero];
    label.layer.cornerRadius = 20;
    label.clipsToBounds = YES;
    [label setTitle:@"搜索" forState:UIControlStateNormal];
    [label setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    label.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.6];
    [label handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        SearchViewController *search = [[SearchViewController alloc] init];
        [self dismissViewControllerAnimated:NO completion:^{
            [_VC presentViewController:search animated:YES completion:nil];
        }];
        [search release];
    }];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.view.mas_top).offset(30);
        make.height.equalTo(@40);
    }];
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchicon"]];
    [label addSubview:searchImageView];
    [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label.mas_centerY);
        make.left.equalTo(label.mas_left).offset(20);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
    }];
    
    
    // 设置
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setImage:[UIImage imageNamed:@"sidebar_setting"] forState:UIControlStateNormal];
    settingButton.highlighted = NO;
    [settingButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        SystemSettingsViewController *setting = [[SystemSettingsViewController alloc] init];
        [self dismissViewControllerAnimated:NO completion:^{
            setting.myImage = [UIImage captureImageFromView: _VC.view];
            [_VC.navigationController pushViewController:setting animated:YES];
        }];
        [setting release];
    }];
    [self.view addSubview:settingButton];
    [settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(WIDTH / 6.5);
        make.top.equalTo(label.mas_bottom).offset(HEIGHT / 18.4);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
    }];
    UILabel *settingLabel = [[UILabel alloc] init];
    settingLabel.text = @"设置";
    settingLabel.font = [UIFont systemFontOfSize:13];
    settingLabel.textAlignment = NSTextAlignmentCenter;
    settingLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:settingLabel];
    [settingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(settingButton.mas_centerX);
        make.top.equalTo(settingButton.mas_bottom);
        make.width.equalTo(@40);
        make.height.equalTo(@20);
    }];
    
    // 夜间
    UIButton *nightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nightButton setImage:[UIImage imageNamed:@"sidebar_switchNight"] forState:UIControlStateNormal];
    nightButton.highlighted = NO;
    [nightButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        //
    }];
    [self.view addSubview:nightButton];
    [nightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(settingButton.mas_left).offset(WIDTH / 5.175);
        make.top.equalTo(label.mas_bottom).offset(HEIGHT / 18.4);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
    }];
    UILabel *nightLabel = [[UILabel alloc] init];
    nightLabel.text = @"夜间";
    nightLabel.font = [UIFont systemFontOfSize:13];
    nightLabel.textAlignment = NSTextAlignmentCenter;
    nightLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:nightLabel];
    [nightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(nightButton.mas_centerX);
        make.top.equalTo(nightButton.mas_bottom);
        make.width.equalTo(@40);
        make.height.equalTo(@20);
    }];

    // 离线
    UIButton *offlineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [offlineButton setImage:[UIImage imageNamed:@"sidebar_offline"] forState:UIControlStateNormal];
    offlineButton.highlighted = NO;
    [offlineButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        //
    }];
    [self.view addSubview:offlineButton];
    [offlineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nightButton.mas_left).offset(WIDTH / 5.175);
        make.top.equalTo(label.mas_bottom).offset(HEIGHT / 18.4);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
    }];
    UILabel *offlineLabel = [[UILabel alloc] init];
    offlineLabel.text = @"离线";
    offlineLabel.font = [UIFont systemFontOfSize:13];
    offlineLabel.textAlignment = NSTextAlignmentCenter;
    offlineLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:offlineLabel];
    [offlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(offlineButton.mas_centerX);
        make.top.equalTo(offlineButton.mas_bottom);
        make.width.equalTo(@40);
        make.height.equalTo(@20);
    }];
    
    // 推荐
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"sidebar_share"] forState:UIControlStateNormal];
    shareButton.highlighted = NO;
    [shareButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        //
    }];
    [self.view addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(offlineButton.mas_left).offset(WIDTH / 5.175);
        make.top.equalTo(label.mas_bottom).offset(HEIGHT / 18.4);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
    }];
    UILabel *shareLabel = [[UILabel alloc] init];
    shareLabel.text = @"推荐";
    shareLabel.font = [UIFont systemFontOfSize:13];
    shareLabel.textAlignment = NSTextAlignmentCenter;
    shareLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:shareLabel];
    [shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(shareButton.mas_centerX);
        make.top.equalTo(shareButton.mas_bottom);
        make.width.equalTo(@40);
        make.height.equalTo(@20);
    }];
    
}

- (void)createFloatingButton {
    self.goHomeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _goHomeButton.frame = CGRectMake(15, HEIGHT - 70, 50, 50);
    [_goHomeButton setImage:[UIImage imageNamed:@"closeButton"] forState:UIControlStateNormal];
    _goHomeButton.layer.cornerRadius = self.view.frame.size.width / 2;
    [_goHomeButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
        }];
    [self.view addSubview:_goHomeButton];

}

- (void)creatrArray {
    self.imageArray = @[@"menu_about", @"menu_category", @"menu_column", @"menu_lab", @"menu_noti", @"menu_user", @"menu_home"];
    self.titleArray = @[@"About us", @"Categories of news", @"Column center", @"Curiosity Institute", @"My message", @"Personal Center", @"Home"];

    
}

- (void)createTableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 66;
        _tableView.separatorStyle = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom).offset(-80);
            make.top.equalTo(self.view.mas_top).offset(200);
        }];
        [_tableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:menuIdentifier];
        [_tableView release];
    }
    
}

- (void)createNewsCategory {
    self.myView = [[CategoriesOfNews alloc] init];
    [_myView setJumpDetails:^(YZYLeftSidebar *yzy) {
        CategoriesViewController *cate = [[CategoriesViewController alloc] init];
        cate.yzy = yzy;
        [self dismissViewControllerAnimated:NO completion:^{
            [_VC.navigationController pushViewController:cate animated:YES];
        }];
        [cate release];
    }];
    [self.view addSubview:_myView];
    [_myView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_right);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.view.mas_bottom).offset(-80);
        make.top.equalTo(self.view.mas_top).offset(200);
    }];
    _myView.leftArray = _leftArray;
    [_myView release];
    self.goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_goBackButton setImage:[UIImage imageNamed:@"homeBackButton"] forState:UIControlStateNormal];
     _goBackButton.frame = CGRectMake(WIDTH, HEIGHT - 70, 50, 50);
    _goBackButton.layer.cornerRadius = self.view.frame.size.width / 2;
    [_goBackButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:20 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _tableView.frame = CGRectMake(0, 200, WIDTH, HEIGHT - 280);
            
            [_myView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view.mas_right);
                make.width.equalTo(self.view.mas_width);
                make.bottom.equalTo(self.view.mas_bottom).offset(-80);
                make.top.equalTo(self.view.mas_top).offset(200);
            }];
            [_myView.superview layoutIfNeeded];
        
            _goHomeButton.frame = CGRectMake(15, HEIGHT - 70, 50, 50);
            _goBackButton.frame = CGRectMake(WIDTH * 2, HEIGHT - 70, 50, 50);
            
        } completion:^(BOOL finished) {
            nil;
        }];
    }];
    [self.view addSubview:_goBackButton];
    
}

#pragma mark  - menu
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            AboutUsViewController *about = [[AboutUsViewController alloc] init];
            [self dismissViewControllerAnimated:NO completion:^{
                [_VC presentViewController:about animated:YES completion:nil];
                [about release];
            }];
            break;
        }
        case 1:{
            
            [UIView animateWithDuration:0.7 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:20 options:UIViewAnimationOptionLayoutSubviews animations:^{
                [_myView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.view.mas_left);
                    make.width.equalTo(self.view.mas_width);
                    make.bottom.equalTo(self.view.mas_bottom).offset(-80);
                    make.top.equalTo(self.view.mas_top).offset(200);
                }];
                [_myView.superview layoutIfNeeded];
                _tableView.frame = CGRectMake(-WIDTH * 2, 200, WIDTH, HEIGHT - 280);
                _goHomeButton.frame = CGRectMake(-WIDTH, HEIGHT - 70, 50, 50);
                _goBackButton.frame = CGRectMake(15, HEIGHT - 70, 50, 50);
            } completion:^(BOOL finished) {
                nil;
            }];
            break;
        }
        case 2:{
            ColumnCenterViewController *colum = [[ColumnCenterViewController alloc] init];
            [self dismissViewControllerAnimated:NO completion:^{
                [_VC.navigationController pushViewController:colum animated:YES];
            }];
            
            break;
        }
        case 3:{
            CuriosityInstituteViewController *curiosity = [[CuriosityInstituteViewController alloc] init];
            [self dismissViewControllerAnimated:NO completion:^{
                [_VC.navigationController pushViewController:curiosity animated:YES];
                [curiosity release];
            }];
            break;
        }
        case 4:{
            RegisterViewController *registerVC = [[RegisterViewController alloc] init];
            [self dismissViewControllerAnimated:NO completion:^{
                registerVC.myImage = [UIImage captureImageFromView: _VC.view];
                [_VC presentViewController:registerVC animated:YES completion:nil];
                [registerVC release];
            }];
            
            break;
        }
        case 5:{
            
            break;
        }
        default: {
           [self dismissViewControllerAnimated:YES completion:nil];
            break;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _imageArray.count;
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuIdentifier];
    if (1 == indexPath.row) {
        cell.spec = @"sidebar_next";
    }
    cell.title = _titleArray[indexPath.row];
    cell.imageName  = _imageArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  
    return cell;
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
