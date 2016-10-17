//
//  SystemSettingsViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/10.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "SystemSettingsViewController.h"
#import "SettingTableViewCell.h"
#import "RegisterViewController.h"

static NSString *const Identifier = @"Settingcell";

@interface SystemSettingsViewController ()

<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, retain)UITableView *tableView;

@end

@implementation SystemSettingsViewController

- (void)dealloc {
    [_tableView release];
    [_myImage release];
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:_myImage];
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    [imageView release];
    self.navigationItem.title = @"好奇心研究所";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"commentClose"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction)];
    self.navigationItem.leftBarButtonItem= leftBarButtonItem;

    
    [self createTableView];

}

- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [_tableView release];
    [_tableView registerClass:[SettingTableViewCell class] forCellReuseIdentifier:Identifier];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 80;
            break;
        case 1:
            return 80;
            break;
        case 2:
            return 130;
            break;
        case 3:
            return 80;
            break;
        case 4:
            return 50;
            break;
        default:
            return 50;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (0 == indexPath.row) {
        cell.name = @"登录或注册";
        cell.rightView = @"right";
    }else if (1 == indexPath.row) {
        cell.name = @"字体大小";
    }
    else if (2 == indexPath.row) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splash_slogan"]];
        [cell addSubview:imageView];
        cell.name = @"推送消息";
        cell.rightView = @"right";
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell.mas_centerX);
            make.top.equalTo(cell.mas_top).offset(20);
            make.width.equalTo(@140);
            make.height.equalTo(@25);
        }];
    }
    else if (3 == indexPath.row) {
        cell.name = @"给我们打分";
        cell.rightView = @"right";
    }
    else if (4 == indexPath.row) {
        cell.name = @"反馈意见";
        cell.rightView = @"right";
    }
    else if (5 == indexPath.row) {
        cell.name = @"清除缓存";
        cell.rightView = @"right";
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            RegisterViewController *registerVC = [[RegisterViewController alloc] init];
            registerVC.myImage = _myImage;
            [self presentViewController:registerVC animated:YES completion:nil];
            [registerVC release];
            break;
        }
        case 1:{
            
            break;
        }
        case 2:{
            
            break;
        }
        case 3:{
            
            break;
        }
        case 4:{
            
            break;
        }
        default: {
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask ,YES) firstObject];
            CGFloat cacheSize = [self folderSizeAtPath:cachePath];
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"确定清除%.2fM缓存吗?", cacheSize] message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            //创建一个取消和一个确定按钮
            UIAlertAction *actionCancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            //因为需要点击确定按钮后改变文字的值，所以需要在确定按钮这个block里面进行相应的操作
            UIAlertAction *actionOk=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [self clearCache:cachePath];
                   [UIView showMessage:@"清除成功"];
            }];
            //将取消和确定按钮添加进弹框控制器
            [alert addAction:actionCancle];
            [alert addAction:actionOk];
            
            //显示弹框控制器
            [self presentViewController:alert animated:YES completion:nil];

            break;
        }
    }
}

- (long long)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size;
       }
    return 0;
}

- (float)folderSizeAtPath:(NSString *)path{
        NSFileManager *fileManager=[NSFileManager defaultManager];
        long long folderSize=0;
        if ([fileManager fileExistsAtPath:path])
            {
                    NSArray *childerFiles=[fileManager subpathsAtPath:path];
                    for (NSString *fileName in childerFiles)
                        {
                                NSString *fileAbsolutePath=[path stringByAppendingPathComponent:fileName];
                                long long size=[self fileSizeAtPath:fileAbsolutePath];
                                folderSize += size;
                            }
                    //SDWebImage框架自身计算缓存的实现
                    folderSize+=[[SDImageCache sharedImageCache] getSize];
                    return folderSize/1024.0/1024.0;
                }
        return 0;
}

// 清除缓存
- (void)clearCache:(NSString *)path{
        NSFileManager *fileManager=[NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:path]) {
            NSArray *childerFiles=[fileManager subpathsAtPath:path];
            for (NSString *fileName in childerFiles) {
                //如有需要，加入条件，过滤掉不想删除的文件
                NSString *fileAbsolutePath=[path stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:fileAbsolutePath error:nil];
            }
        }
        [[SDImageCache sharedImageCache] cleanDisk];
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
