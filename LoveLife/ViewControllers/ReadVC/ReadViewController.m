//
//  ReadViewController.m
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/29.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import "ReadViewController.h"
#import "ArticalViewController.h"//美文
#import "RecordViewController.h"//语录

@interface ReadViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UISegmentedControl *_segmentcontrol;
}
@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setingNav];
    [self createUI];
}

#pragma mark -创建UI
- (void)createUI
{
    //创建scrollview
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)];
    //设置代理
    _scrollView.delegate = self;
    //关闭弹簧效应
    _scrollView.bounces = NO;
    //设置分页
    _scrollView.pagingEnabled = YES;
    
    //隐藏指示条
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_scrollView];
    
    //设置contentSize
    _scrollView.contentSize = CGSizeMake(Screen_W * 2,0);
    
    //实例化子控制器
    ArticalViewController *articalVC = [[ArticalViewController alloc] init];
    RecordViewController *recoreVC = [[RecordViewController alloc] init];
    
    NSArray *VCArray = @[articalVC,recoreVC];
    
    //滚动式的框架实现
    int i = 0;
    for (UIViewController *VC in VCArray) {
        
        VC.view.frame = CGRectMake(i * Screen_W, 0, Screen_W, Screen_H);
        [self addChildViewController:VC];
        [_scrollView addSubview:VC.view];
        
        i ++;
    }
}

#pragma mark -设置导航
- (void)setingNav
{
    //创建segment
    _segmentcontrol = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
    //插入标题
    [_segmentcontrol insertSegmentWithTitle:@"读美文" atIndex:0 animated:YES];
    [_segmentcontrol insertSegmentWithTitle:@"看语录" atIndex:1 animated:YES];
    
    //设置字体颜色
    _segmentcontrol.tintColor = [UIColor whiteColor];
    
    //设置背景颜色
   // _segmentcontrol.backgroundColor = [UIColor orangeColor];
    
    //设置默认选中为0
    _segmentcontrol.selectedSegmentIndex = 0;
    
    //响应方法
    [_segmentcontrol addTarget:self action:@selector(changeOpyion:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = _segmentcontrol;
    
}

#pragma mark - segment响应方法
- (void)changeOpyion:(UISegmentedControl *)segment
{
    _scrollView.contentOffset = CGPointMake(segment.selectedSegmentIndex * Screen_W, 0);
}

#pragma mark - scrollview的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _segmentcontrol.selectedSegmentIndex = scrollView.contentOffset.x / Screen_W;
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
