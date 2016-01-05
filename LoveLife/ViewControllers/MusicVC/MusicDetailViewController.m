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
<<<<<<< Updated upstream
=======
#import "MusicPlayViewController.h"
>>>>>>> Stashed changes

@interface MusicDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    //分页
    int _page;
}
///数据源
@property (nonatomic,strong) NSMutableArray *dataArray;
<<<<<<< Updated upstream

@property (nonatomic,strong) MBProgressHUD *hub;

=======
@property (nonatomic,strong) MBProgressHUD *hub;

@property (nonatomic,strong) NSMutableArray *urlArray;
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,strong) NSMutableArray *artistArray;
@property (nonatomic,strong) NSMutableArray *imagearray;
>>>>>>> Stashed changes
@end

@implementation MusicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 0;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
<<<<<<< Updated upstream
=======
    
    self.urlArray = [NSMutableArray arrayWithCapacity:0];
    self.titleArray = [NSMutableArray arrayWithCapacity:0];
    self.artistArray = [NSMutableArray arrayWithCapacity:0];
    self.imagearray = [NSMutableArray arrayWithCapacity:0];
    
>>>>>>> Stashed changes
    //刚进去后显示的数据
    [self loadData];
    
    [self settingNav];
    [self createUI];
<<<<<<< Updated upstream
    [self createRefresh];
    
=======
    
    //1.创建队列组
    dispatch_group_t group = dispatch_group_create();
    //2.创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //3.多次使用队列组的方法执行任务, 只有异步方法
    
    dispatch_group_async(group, queue, ^{
        
        [self createRefresh];
        
    });
 
>>>>>>> Stashed changes
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
            
<<<<<<< Updated upstream
=======
            //mp3文件
            [self.urlArray addObject:dic[@"url"]];
            
            //title  歌名
            [self.titleArray addObject:dic[@"title"]];
            //歌手
            [self.artistArray addObject:dic[@"artist"]];
            //歌名
            //[self.titleArray addObject:dic[@"title"]];
            //图片
            [self.imagearray addObject:dic[@"coverURL"]];
            
            
>>>>>>> Stashed changes
            MusicDetailModel *model = [[MusicDetailModel alloc] init];
            
            //字典转模型
            [model setValuesForKeysWithDictionary:dic];
            
            [self.dataArray addObject:model];
        }
        //数据请求成功后,停止刷新,结束活动指示器,刷新界面
        [_tableView.footer endRefreshing];
        [self.hub hide:YES];
<<<<<<< Updated upstream
=======
       
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
    self.hub.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
=======
    self.hub.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
>>>>>>> Stashed changes
    
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
<<<<<<< Updated upstream
    
=======
    MusicPlayViewController *musicPlay = [[MusicPlayViewController alloc] init];
    
    
    //传值
    MusicDetailModel *model = self.dataArray[indexPath.row];
    musicPlay.model = model;
    
    musicPlay.urlArray = self.urlArray;
    
    musicPlay.titleArray = self.titleArray;
    musicPlay.artistArray = self.artistArray;
    musicPlay.imageArray = self.imagearray;
    
    musicPlay.currentIndex = (int)indexPath.row ;
   
    [self.navigationController pushViewController:musicPlay animated:YES];
>>>>>>> Stashed changes
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
