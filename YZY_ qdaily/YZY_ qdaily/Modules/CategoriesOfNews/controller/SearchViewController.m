//
//  SearchViewController.m
//  YZY_ qdaily
//
//  Created by dllo on 16/10/10.
//  Copyright © 2016年 yzy. All rights reserved.
//

#import "SearchViewController.h"
#import "HttpAPIConst.h"
#import "YZYSearchesModel.h"
#import "YZYPostModel.h"
#import "YZYauthorModel.h"
#import "SearchTableViewCell.h"
#import "ShowNewsViewController.h"
#import "SaidViewController.h"
#import "VoteViewController.h"

static NSString *const Identifier = @"cell";


@interface SearchViewController ()

<
UITextFieldDelegate,
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, retain)UITextField *textField;

@property (nonatomic, retain)NSMutableArray *objectArray;

@property (nonatomic, copy)NSString *number;

@property (nonatomic, retain)UITableView *tableView;

@end

@implementation SearchViewController

- (void)dealloc {
    _textField.delegate = nil;
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    [_textField release];
    [_objectArray release];
    [_number release];
    [_tableView release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.objectArray = [NSMutableArray array];
    [self create];

}




- (void)create {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    [self.view addSubview:view];
    [view release];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.height.equalTo(@64);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).offset(-15);
        make.bottom.equalTo(view.mas_bottom).offset(-10);
        make.height.equalTo(@20);
        make.width.equalTo(@40);
    }];
    
    self.textField = [[UITextField alloc] init];
    _textField.delegate = self;
    _textField.clipsToBounds = YES;
    _textField.layer.cornerRadius = 10;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.textColor = [UIColor blackColor];
    _textField.placeholder = @"搜索";
    _textField.returnKeyType = UIReturnKeySearch;
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    _textField.borderStyle = UITextBorderStyleNone;
    UIImageView *SearchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchicon"]];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.leftView = SearchImageView;
    [SearchImageView release];
    [view addSubview:_textField];
    [_textField release];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(20);
        make.right.equalTo(button.mas_left).offset(-15);
        make.bottom.equalTo(view.mas_bottom).offset(-5);
        make.top.equalTo(view.mas_top).offset(24);
    }];
    

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 120;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[SearchTableViewCell class] forCellReuseIdentifier:Identifier];
    [_tableView release];
    
    // 加载tablewView 方法
    [_tableView.mj_header beginRefreshing];
    _tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(Loading)];
    
}

// 加载
- (void)Loading {
    
    [self getInfo:@"0" text:_textField.text];
    [_tableView.mj_footer endRefreshing];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //回收键盘
    //(放弃第一响应者)
    //[textField resignFirstResponder];
    // 结束编辑状态
    [textField endEditing:YES];
    [self getInfo:@"0" text:textField.text];
    
      return YES;
}

- (void)getInfo:(NSString *)number text:(NSString *)text {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *urlString = [NSString stringWithFormat:@"%@/app3/searches/post_list?last_key=%@&search=%@",kDevelopHostUrl, number, text];
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *response = [responseObject objectForKey:@"response"];
            self.number = [response objectForKey:@"last_key"];
            if ([[response objectForKey:@"total_number"] isEqual:@0]) {
                [UIView showMessage:@"抱歉没有搜索到相关结果"];
            }
            for (NSDictionary *dic in [response objectForKey:@"searches"]) {
                YZYSearchesModel *yzy = [YZYSearchesModel modelWithDic:dic];
                [_objectArray addObject:yzy];
            }
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT * 0.054)];
            label.text = [NSString stringWithFormat:@"文章  (%@条搜索结果)", [response objectForKey:@"total_number"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                _tableView.tableHeaderView = label;
                [_tableView reloadData];
            });

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@",error);
        }];

    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    cell.yzy = _objectArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YZYSearchesModel *yzy = _objectArray[indexPath.row];
    if (1 == yzy.post.genre) {
        ShowNewsViewController *newsView = [[ShowNewsViewController alloc] init];
        newsView.url = yzy.post.myId;
        [self presentViewController:newsView animated:YES completion:nil];
        [newsView release];
    }else if (1001 == yzy.post.genre){
        SaidViewController *said = [[SaidViewController alloc] init];
        said.yzy = (YZYBaseModel *)yzy;
        said.myID = yzy.post.myId;
        [self presentViewController:said animated:YES completion:nil];
        [said release];
    }
    
   
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
