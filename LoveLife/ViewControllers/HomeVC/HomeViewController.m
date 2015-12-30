//
//  HomeViewController.m
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/29.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import "HomeViewController.h"
#import "UIViewController+MMDrawerController.h"//打开抽屉..是一个类别
#import "CustomViewController.h"//二维码扫描
#import "Carousel.h"//广告条轮播
#import "HomeModel.h"
#import "HomeCell.h"
#import "HomeDetaViewController.h"


@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    Carousel *_cyclePlaying;
    UITableView *_tableView;
    
    //分页
    int _page;
}
//数据源
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setttingNav];
    [self createTableHeaderView];
    [self createTableView];
    [self createRefresh];
}

#pragma mark - 刷新数据
- (void)createRefresh
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(LoadNewData)];
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //当程序第一次启动的时候让自动刷新一次
    [_tableView.header beginRefreshing];
}

//下拉刷新
- (void)LoadNewData
{
    _page = 1;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self getData];
}

//上拉加载
- (void)loadMoreData
{
    _page ++;
    [self getData];
}

//请求数据
- (void)getData
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    [manage GET:[NSString stringWithFormat:HOMEURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dic in responseObject[@"data"][@"topic"]) {
            
            HomeModel *model = [[HomeModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
            //数组里装得是MOdel
        }
        
        //数据请求成功之后停止刷新,刷新界面,判断是上拉加载,还是下拉刷新
        if (_page == 1) {
            [_tableView.header endRefreshing];
        }else{
            [_tableView.footer endRefreshing];
        }
        
        //刷新界面
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - 创建tableview
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H - 49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 190;
    [self.view addSubview:_tableView];
    
    /*
    //修改分割线
    //方法一
    _tableView.separatorColor = [UIColor clearColor];
    
    //方法二
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //去掉多余的线条
    _tableView.tableFooterView = [[UIView alloc] init];
     */
    
    //设置头视图
    _tableView.tableHeaderView = _cyclePlaying;
}

#pragma mark -tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    
    if (!cell) {
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
    }
    
    //赋值
    if (self.dataArray) {
        HomeModel *model = self.dataArray[indexPath.row];
        [cell refreshUI:model];
    }
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 190;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDetaViewController *homeVC = [[HomeDetaViewController alloc] init];
    
    //传值
    HomeModel *model = self.dataArray[indexPath.row];
    homeVC.dataID = model.dataID;
    
    //隐藏tabbar
    homeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:homeVC animated:YES];
}

#pragma mark - 创建tableview的头视图
- (void)createTableHeaderView
{
    _cyclePlaying = [[Carousel alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H / 3)];
    //设置是否需要pageControl
    _cyclePlaying.needPageControl = YES;
    //设置是否需要无限轮播
    _cyclePlaying.infiniteLoop = YES;
    //设置pageControl的位置
    _cyclePlaying.pageControlPositionType = PAGE_CONTROL_POSITION_TYPE_MIDDLE;
    //如果是网上加载的图片,就必须把图片下载过之后才能设置imageUrlArray
    _cyclePlaying.imageArray = @[@"shili15",@"shili8",@"shili1",@"shili19"];
}

#pragma mark - 设置导航
- (void)setttingNav
{
    self.titlelabel.text = @"爱生活";
    [self.leftButton setImage:[UIImage imageNamed:@"icon_function"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"2vm"] forState:UIControlStateNormal];
    
    //设置响应事件
    [self setLeftButtonClick:@selector(leftButtonClick)];
    [self setRightButtonClick:@selector(rightButtonClick)];
}

#pragma mark - 按钮响应事件
- (void)leftButtonClick
{
    //点击打开抽屉
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)rightButtonClick
{
    //YES是关闭二维码,只扫条形  NO两者皆可扫描
    CustomViewController *vc = [[CustomViewController alloc] initWithIsQRCode:NO Block:^(NSString *result, BOOL isSucceessd) {
        
        if (isSucceessd) {
            NSLog(@"%@",result);
        }
    }];
    
    [self presentViewController:vc animated:YES completion:nil];
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
