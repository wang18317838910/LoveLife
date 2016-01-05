//
//  AboutMyViewController.m
//  LoveLife
//
//  Created by qiaqnfeng on 16/1/5.
//  Copyright © 2016年 CCW. All rights reserved.
//

#import "AboutMyViewController.h"
#import "QRCodeGenerator.h"

@interface AboutMyViewController ()

@end

@implementation AboutMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self settingNav];
    [self AboutMy];
}

#pragma mark - 设置导航
- (void)settingNav
{
    self.titlelabel.text = @"关于";
    [self.leftButton setImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_nor@2x"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

//返回按钮响应
- (void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 生成二维码
- (void)AboutMy
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    //300指的是二维码的清晰度,数值越大,越清晰
    imageView.image = [QRCodeGenerator qrImageForString:@"www.baidu.com" imageSize:300];
    
    UIImageView *ima1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    ima1.image = [UIImage imageNamed:@"LikeBtn.png"];
    ima1.center = imageView.center;
    [imageView addSubview:ima1];
    
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
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
