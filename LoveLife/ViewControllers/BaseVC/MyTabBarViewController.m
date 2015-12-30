//
//  MyTabBarViewController.m
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/29.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "HomeViewController.h"
#import "ReadViewController.h"
#import "FoodViewController.h"
#import "MusicViewController.h"
#import "MyViewController.h"



@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createViewControllers];
    [self createtabBarItem];

}

- (void)createViewControllers
{
    //实例化子页面
    //首页
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    //阅读
    ReadViewController *readVC = [[ReadViewController alloc] init];
    UINavigationController *readNav = [[UINavigationController alloc] initWithRootViewController:readVC];
    
    //美食
    FoodViewController *foodVc = [[FoodViewController alloc] init];
    UINavigationController *foodNav = [[UINavigationController alloc] initWithRootViewController:foodVc];
    
    //音乐
    MusicViewController *musicVC = [[MusicViewController alloc] init];
    UINavigationController *musicNav = [[UINavigationController alloc] initWithRootViewController:musicVC];
    
    //我的
    MyViewController *myVC = [[MyViewController alloc] init];
    UINavigationController *myNav = [[UINavigationController alloc] initWithRootViewController:myVC];
    
    //添加到viewcontrollers
    self.viewControllers = @[homeNav,readNav,foodNav,musicNav,myNav];
    
}

- (void)createtabBarItem
{
    //未选中的图片
    NSArray *unselectedImageArray = @[@"ic_tab_select_normal@2x",@"iconfont-yule",@"iconfont-iconfontmeishi",@"health",@"ic_tab_profile_normal_female@2x"];
    
    //选中的图片
    NSArray *selectedImageArray = @[@"ic_tab_select_selected@2x",@"iconfont-yule-2",@"iconfont-iconfontmeishi-2",@"health2",@"ic_tab_profile_selected_female@2x"];
    
    //标题
    NSArray *titleArray = @[@"首页",@"阅读",@"美食",@"音乐",@"我的"];
    
    for (int i = 0; i < self.tabBar.items.count; i++) {
        //处理未选中的图片
        UIImage *unselectedimage = [UIImage imageNamed:unselectedImageArray[i]];
        unselectedimage = [unselectedimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //处理选中的图片
        UIImage *selectedimage = [UIImage imageNamed:selectedImageArray[i]];
        selectedimage = [selectedimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//图片原始大小
        
        //获取item并且赋值
        UITabBarItem *item = self.tabBar.items[i];
        item = [item initWithTitle:titleArray[i] image:unselectedimage selectedImage:selectedimage];
    }
    
    //设置选中时标题的颜色 传一个字典
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
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
