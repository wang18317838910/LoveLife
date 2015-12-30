//
//  AppDelegate.m
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/29.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarViewController.h"
#import "GuidePageView.h"
#import "MMDrawerController.h"//抽屉第3方
#import "LeftViewController.h"

#import "UMSocialQQHandler.h"//支持QQ
#import "UMSocialWechatHandler.h"//微信
#import "UMSocialSinaHandler.h"//新浪

@interface AppDelegate ()


@property (nonatomic,strong) MyTabBarViewController *myTabBar;
@property (nonatomic,strong) GuidePageView *guidePageView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //实例化
    self.myTabBar = [[MyTabBarViewController alloc] init];
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    MMDrawerController *drawerVC = [[MMDrawerController alloc] initWithCenterViewController:self.myTabBar leftDrawerViewController:leftVC];
    
    //设置抽屉打开和关闭模式
    drawerVC.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    drawerVC.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    //设置左页面打开之后的高度
    drawerVC.maximumLeftDrawerWidth = Screen_W - 100;

    self.window.rootViewController = drawerVC;
    
    //修改状态栏的颜色(第二中方式)需要修改plist文件 在第一个添加选择最后一个,类型为BOOL,属性为NO
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //添加引导页
    [self createGuidepage];
    
    //注册友盟分享
    [self addUMShare];
    
    return YES;
}

#pragma mark -添加友盟分享
- (void)addUMShare
{
    //注册友盟分享
    [UMSocialData setAppKey:APPKEY];
    
    //设置QQ的APPId和APPKey和URL
    [UMSocialQQHandler setQQWithAppId:@"1104908293" appKey:@"MnGtpPN5AiB6MNvj" url:nil];
    
    //设置微信的appID,appSecret和url
    [UMSocialWechatHandler setWXAppId:@"wx12b249bcbf753e87" appSecret:@"0a9cd00c48ee47a9b23119086bcd3b30" url:nil];
    
    //打开微博的SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    
    //隐藏未安装的客户端,(这一步只要针对QQ跟微信),如果不设置可能导致上传项目被拒
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    
}

#pragma mark -引导页
- (void)createGuidepage
{
    //转为BOOL值...取值
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"isRuned"]boolValue]) {
        
        NSArray *imageArray = @[@"welcome4",@"welcome6",@"welcome7"];
        self.guidePageView = [[GuidePageView alloc] initWithFrame:self.window.bounds ImageArray:imageArray];
        [self.myTabBar.view addSubview:self.guidePageView];
        
        //第一次运行完成之后进行记录
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"isRuned"];
    }
    
    [self.guidePageView.GoInAppButton addTarget:self action:@selector(goInButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)goInButtonClick
{
    [self.guidePageView removeFromSuperview];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
