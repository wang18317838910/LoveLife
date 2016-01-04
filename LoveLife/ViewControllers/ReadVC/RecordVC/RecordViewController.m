//
//  RecordViewController.m
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/30.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordModel.h"
#import "RecordTableViewCell.h"

@interface RecordViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    //分页
    int _page;
    
    //不定高cell的高度
    CGFloat _cellHeight;
}

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
   [self createfresh];
}

#pragma mark -加载数据
- (void)createfresh
{
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [_tableView.header beginRefreshing];
}

//下拉刷新
- (void)loadNewData
{
    _page = 0;
     self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self getData];
}

//上拉加载
- (void)loadMoreData
{
    _page ++;
    [self getData];
}

//数据
- (void)getData
{
   
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    [manage GET:[NSString stringWithFormat:UTTERANCEURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        for (NSDictionary *dic in  responseObject[@"content"]) {
            
            RecordModel *model = [[RecordModel alloc] init];
            
            model.textString = dic[@"text"];
            model.pub_timeString = dic[@"pub_time"];
            model.image_urlsArray = dic[@"image_urls"];
            model.publisher_icon_urlString = dic[@"publisher_icon_url"];
            model.dataID = dic[@"id"];
            model.publisher_nameString = dic[@"publisher_name"];
            
            [self.dataArray addObject:model];
            
        }
        
        if (_page == 0) {
            [_tableView.header endRefreshing];
        }else{
            [_tableView.footer endRefreshing];
        }
        
        [_tableView reloadData];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark -创建tableview
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H ) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

#pragma mark -tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordID"];
    if (cell == nil) {
        cell = [[RecordTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"RecordID"];
    }
    
    if (self.dataArray) {
        
        RecordModel *model = self.dataArray[indexPath.row];
        [cell refreshUI:model];
        
      // _cellHeight = cell.cellHeight;
        _tableView.rowHeight = cell.cellHeight;
    }
    return cell;
}

@end
