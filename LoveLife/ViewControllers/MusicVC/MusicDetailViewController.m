//
//  MusicDetailViewController.m
//  LoveLife
//
//  Created by qiaqnfeng on 16/1/4.
//  Copyright © 2016年 CCW. All rights reserved.
//

#import "MusicDetailViewController.h"
#import "MBProgressHUD.h"
#import "MusicDetailModel.h"
#import "MusicDetailTableViewCell.h"

@interface MusicDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    //分页
    int _page;
}
///数据源
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) MBProgressHUD *hub;

@end

@implementation MusicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 0;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    //刚进去后显示的数据
    [self loadData];
    
    [self settingNav];
    [self createUI];
    [self createRefresh];
    
}

#pragma mark -加载数据
- (void)createRefresh
{
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

//上拉加载数据
- (void)loadMoreData
{
    _page ++;
     [self loadData];
}
//加载数据
- (void)loadData
{
    //让活动指示器开始
    [self.hub show:YES];
    
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    [manage GET:self.urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dic in responseObject[@"data"]) {
            
            MusicDetailModel *model = [[MusicDetailModel alloc] init];
            
            //字典转模型
            [model setValuesForKeysWithDictionary:dic];
            
            [self.dataArray addObject:model];
        }
        //数据请求成功后,停止刷新,结束活动指示器,刷新界面
        [_tableView.footer endRefreshing];
        [self.hub hide:YES];
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma  mark -创建UI
- (void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    //创建活动指示器
    self.hub = [[MBProgressHUD alloc] initWithView:self.view];
    //设置加载文字
    self.hub.labelText = @"正在加载";
    //设置加载文字大小
    self.hub.labelFont = [UIFont systemFontOfSize:14];
    
    //设置加载文字的颜色
    self.hub.labelColor = [UIColor whiteColor];
    
    //设置背景颜色
    self.hub.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    
    //设置中间指示器的颜色
    self.hub.activityIndicatorColor = [UIColor whiteColor];
    [self.view addSubview:self.hub];
}

#pragma mark -tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"musicDetailID"];
    if (cell == nil) {
        
        cell = [[MusicDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"musicDetailID"];
    }
    
    if (self.dataArray) {
        
        MusicDetailModel *model = self.dataArray[indexPath.row];
        [cell refreshUI:model];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -设置导航
- (void)settingNav
{
    self.titlelabel.text = self.typeString;
    [self.leftButton setImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_nor@2x"] forState:UIControlStateNormal];
    [self setLeftButtonClick:@selector(leftButtonClick)];
}

- (void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
