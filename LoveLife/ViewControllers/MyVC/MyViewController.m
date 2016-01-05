//
//  MyViewController.m
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/29.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import "MyViewController.h"
#import "AppDelegate.h"
#import "AboutMyViewController.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIImageView *_headerImageView;
    //夜间模式的view
    UIView *_darkView;
}

//图标
@property (nonatomic,strong) NSArray *logoArray;
//标题
@property (nonatomic,strong) NSArray *titleArray;

@end

@implementation MyViewController

//高度
static float ImageOriginHeight = 200;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.logoArray = @[@"iconfont-iconfontaixinyizhan",@"iconfont-lajitong",@"iconfont-yejianmoshi",@"iconfont-zhengguiicon40",@"iconfont-guanyu"];
    self.titleArray = @[@"我的收藏",@"清理缓存",@"夜间模式",@"推送消息",@"关于"];
    
    _darkView = [[UIView alloc] initWithFrame:self.view.frame];
    
    [self settingNav];
    [self createUI];
    
}

#pragma mark -设置导航
- (void)settingNav
{
    self.titlelabel.text = @"我的";
}

#pragma mark -创建UI
- (void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = RGB(255, 156, 187, 1);
    [self.view addSubview:_tableView];
    
    //隐藏多余的线条
    _tableView.tableFooterView = [[UIView alloc] init];
    
    _headerImageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, -ImageOriginHeight, Screen_W, ImageOriginHeight) imageName:@"welcome5"];
    [_tableView addSubview:_headerImageView];
    
    //设置tableview内容从 ImageOriginHeight 开始显示
    _tableView.contentInset = UIEdgeInsetsMake(ImageOriginHeight, 0, 0, 0);
}

#pragma mark - 实现tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.logoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyID"];
        
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 4) {
            //设置尾部  箭头
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        if (indexPath.row == 2 || indexPath.row == 3) {
            //
            UISwitch *swi = [[UISwitch alloc] initWithFrame:CGRectMake( (Screen_W - 60), 5, 50, 30)];
         //设置打开颜色
            swi.onTintColor = [UIColor greenColor];
            swi.tag = indexPath.row;
            
            [swi addTarget:self action:@selector(swiChange:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:swi];
        }
    }
    
    //赋值
    cell.imageView.image = [UIImage imageNamed:self.logoArray[indexPath.row]];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

#pragma mark - switch响应事件
- (void)swiChange:(UISwitch *)swit
{
    if (swit.tag == 2) {
        //夜间模式
        
        if (swit.on) {
            
            UIApplication *app = [UIApplication sharedApplication];
            AppDelegate *delegate = app.delegate;
            
            //设置view的背景色
            _darkView.backgroundColor = [UIColor blackColor];
            _darkView.alpha = 0.3;
            
            //关掉view的交互属性...否则变成黑色后其他都无法响应界面
            _darkView.userInteractionEnabled = NO;
            
            //把view添加在window上
            [delegate.window addSubview:_darkView];
            
        }else{
            
            [_darkView removeFromSuperview];
        }
        
        
    }else{
        //清理缓存
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        
        AboutMyViewController *aboutMy = [[AboutMyViewController alloc] init];
        [self.navigationController pushViewController:aboutMy animated:YES];
    }
}

#pragma mark - 实现scrollview的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //思路:通过改变scrollview的偏移量,,来改变图片的frame
    if (scrollView == _tableView) {
        
        //获取scrollview的偏移量
        CGFloat yOffset = scrollView.contentOffset.y;
        CGFloat xOffset = (yOffset + ImageOriginHeight) / 2;
        
        if (yOffset < -ImageOriginHeight) {
            
            CGRect rect = _headerImageView.frame;
            //改变imageView的frame,
            rect.origin.y = yOffset;
            rect.size.height = -yOffset;
            
            //fabs(xOffset)绝对值
            rect.origin.x = xOffset;
            rect.size.width = Screen_W + fabs(xOffset) * 2;
            _headerImageView.frame = rect;
        }
        
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
