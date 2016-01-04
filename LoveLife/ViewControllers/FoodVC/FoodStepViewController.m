//
//  FoodStepViewController.m
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/31.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import "FoodStepViewController.h"
#import "FoodStepModel.h"
#import "FoodStepTableViewCell.h"

@interface FoodStepViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    //分页
    int _page;
    
    //
    NSString *_dishesID;
    //头试图
    UIView *_bgView;
   
}

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation FoodStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNav];
    [self initData];
    [self createHeadView];
    [self createTableview];
    [self freshData];
}

#pragma mark -初始化数据
- (void)initData
{
    _dishesID = _dishID;
}

#pragma mark -刷新数据
- (void)freshData
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
    //[self getData];
}

//数据请求
- (void)getData
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    NSDictionary * dic = @{@"dishes_id": _dishesID, @"methodName": @"DishesView"};
   [manage POST:FOODURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
       if ([responseObject[@"code"] integerValue] == 0) {
           
           for (NSDictionary *dict in responseObject[@"data"][@"step"]) {
               
               FoodStepModel *model = [[FoodStepModel alloc] init];
               //[model setValuesForKeysWithDictionary:dict];
               model.dishes_step_descString = dict[@"dishes_step_desc"];
               model.dishes_step_imageString = dict[@"dishes_step_image"];
               
               [self.dataArray addObject:model];
           }
           

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
- (void)createTableview
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_W , Screen_H)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //设置cell分割线颜色
    [_tableView setSeparatorColor:RGB(255, 156, 187, 1)];
    [self.view addSubview:_tableView];
    
    _tableView.tableHeaderView = _bgView;
}

#pragma mark -tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoodStepTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"foodStepID"];
    if (cell == nil) {
        cell = [[FoodStepTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"foodStepID"];
    }
    
    if (self.dataArray) {
        
        FoodStepModel *model = self.dataArray[indexPath.row];
        [cell refreshUI:model IndexPath:indexPath];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
}

- (void)createHeadView
{
    
    _bgView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, Screen_W, 40)];
    [self.view addSubview:_bgView];
    
     UILabel *stepLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, Screen_W, 38) text:@"制作步骤" textColor:nil font:[UIFont systemFontOfSize:18]];
    stepLabel.backgroundColor = [UIColor lightGrayColor];
    stepLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:stepLabel];
    
    UIView *lineView = [FactoryUI createViewWithFrame:CGRectMake(0, 38, Screen_W, 2)];
    lineView.backgroundColor = RGB(255, 156, 187, 1);
    [_bgView addSubview:lineView];
    
}

#pragma mark -设置导航
- (void)createNav
{
    self.titlelabel.text = @"22";
    [self.leftButton setImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_nor@2x.png"] forState:UIControlStateNormal];
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
