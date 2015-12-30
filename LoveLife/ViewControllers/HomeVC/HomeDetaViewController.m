//
//  HomeDetaViewController.m
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/30.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import "HomeDetaViewController.h"

@interface HomeDetaViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    //头部图片
    UIImageView *_headerImageView;
    //头部图片上得文字
    UILabel *_headertitlelabel;
}
//头部视图的数据
@property (nonatomic,strong) NSMutableDictionary *dataDic;
//tableview的数据源
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation HomeDetaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self settingNav];
    [self createUI];
    [self loadData];
}

#pragma mark -请求数据
- (void)loadData
{
    //初始化
    self.dataDic = [NSMutableDictionary dictionaryWithCapacity:0];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    //[self.dataID intValue]需要转换类型,不然数据无法请求
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    [manage GET:[NSString stringWithFormat:HOMEDETAIL, [self.dataID intValue]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //头部视图数据源
        self.dataDic = responseObject[@"data"];
        //tableview的数据源
        self.dataArray = self.dataDic[@"product"];
       
        //数据请求完成后刷新页面
        [self reloadHeaderView];//自定义刷新头部视图
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

//自定义刷新头部视图
- (void)reloadHeaderView
{
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"pic"]] placeholderImage:[UIImage imageNamed:@""]];
    _headertitlelabel.text = self.dataDic[@"desc"];
}

#pragma mark - 创建UI
- (void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H - 49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    //头部控件
    _headerImageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, Screen_W, Screen_H / 3) imageName:nil];
    
    _headertitlelabel = [FactoryUI createLabelWithFrame:CGRectMake(0, _headerImageView.frame.size.height - 60, Screen_W, 60) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:10]];
    _headertitlelabel.numberOfLines = 0;
    _headertitlelabel.lineBreakMode = NSLineBreakByCharWrapping;
    [_headerImageView addSubview:_headertitlelabel];
    
    _tableView.tableHeaderView = _headerImageView;
}

#pragma mark -tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = self.dataArray[section][@"pic"];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailID"];
        
        UIImageView *imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, Screen_W - 20, 200) imageName:nil];
        imageView.tag = 10;
        [cell.contentView addSubview:imageView];
    }
    
    //赋值
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:10];
    
    if (self.dataArray) {
        
        NSArray *sectionArray = self.dataArray[indexPath.section][@"pic"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:sectionArray[indexPath.row][@"pic"]] placeholderImage:[UIImage imageNamed:@""]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}

//每个section的header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, Screen_W, 60)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    //索引
    UILabel *indexLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, 10, 40, 40) text:[NSString stringWithFormat:@"%ld",section + 1] textColor:RGB(255, 156, 187, 1) font:[UIFont systemFontOfSize:16]];
    indexLabel.layer.borderColor = RGB(255, 156, 187, 1).CGColor;
    indexLabel.layer.borderWidth = 2;
    indexLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:indexLabel];
    
    //标题
    UILabel *titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(indexLabel.frame.size.width + indexLabel.frame.origin.x + 10, 10, Screen_W - 50 - 10 - 70, 40) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:18]];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:titleLabel];
    
    //价钱
    UIButton *buyButton = [FactoryUI createButtonWithFrame:CGRectMake(Screen_W - 70, 10, 60, 40) title:nil titleColor:[UIColor darkGrayColor] imageName:nil backgroundImageName:nil target:self selector:@selector(priceButtonClick)];
    buyButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:buyButton];
   
    
    //赋值
    titleLabel.text = self.dataArray[section][@"title"];
    [buyButton setTitle:[NSString stringWithFormat:@"￥%@",self.dataArray[section][@"price"]] forState:UIControlStateNormal];
    return bgView;
}

- (void)priceButtonClick
{
    
}

//设置header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

#pragma mark - 设置导航
- (void)settingNav
{
    self.titlelabel.text = @"详情";
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
