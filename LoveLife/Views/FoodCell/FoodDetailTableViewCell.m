//
//  FoodDetailTableViewCell.m
//  LoveLife
//
//  Created by qiaqnfeng on 16/1/2.
//  Copyright © 2016年 CCW. All rights reserved.
//

#import "FoodDetailTableViewCell.h"

@implementation FoodDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    //图片
    _imageFood = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, Screen_W , 450) imageName:@""];
    _imageFood.userInteractionEnabled = YES;
    [self.contentView addSubview:_imageFood];
    
    //返回button
    UIButton *fanhuiButton = [FactoryUI createButtonWithFrame:CGRectMake(10, 10, 20, 20) title:nil titleColor:nil imageName:@"iconfont-back" backgroundImageName:nil target:self selector:@selector(fanhui)];
    [_imageFood addSubview:fanhuiButton];
    
    //图片上的view
    _lightView = [FactoryUI createViewWithFrame:CGRectMake(0, _imageFood.frame.size.height  + _imageFood.frame.origin.y - 30, Screen_W, 30)];
    _lightView.backgroundColor = [UIColor lightGrayColor];
    _lightView.alpha = 0.8;
    [_imageFood addSubview:_lightView];
    
    //放在view上的播放食材的button
    UIButton *foodMaterialButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 5, (Screen_W / 3), 20) title:@"食材准备" titleColor:[UIColor whiteColor] imageName:@"iconfont-bofang" backgroundImageName:nil target:self selector:@selector(foodMaterClick:)];
    foodMaterialButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_lightView addSubview:foodMaterialButton];
    
     //放在view上的播放食物步骤的button
    UIButton *foodStepButton = [FactoryUI createButtonWithFrame:CGRectMake(foodMaterialButton.frame.size.width + foodMaterialButton.frame.origin.x, 5, (Screen_W / 3), 20) title:@"制作步骤" titleColor:[UIColor whiteColor] imageName:@"iconfont-bofang" backgroundImageName:nil target:self selector:@selector(playFoodStep:)];
    foodStepButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_lightView addSubview:foodStepButton];
    
    //下载
    UIButton *dolownButton = [FactoryUI createButtonWithFrame:CGRectMake(foodStepButton.frame.size.width + foodStepButton.frame.origin.x, 5, (Screen_W / 3), 20) title:@"下载" titleColor:[UIColor whiteColor] imageName:@"iconfont-download" backgroundImageName:nil target:self selector:@selector(dolownClick)];
    dolownButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_lightView addSubview:dolownButton];
    
    //食物名字
    _dashes_nameLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _imageFood.frame.size.height + _imageFood.frame.origin.y, (Screen_W - 10), 30) text:@"" textColor:nil font:[UIFont systemFontOfSize:20]];
    [self.contentView addSubview:_dashes_nameLabel];
    
    //食物描述
    _material_descLabel = [FactoryUI createLabelWithFrame:CGRectMake(20, _dashes_nameLabel.frame.size.height + _dashes_nameLabel.frame.origin.y, (Screen_W - 20), 50) text:@"" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:16]];
    _material_descLabel.numberOfLines = 0;
    _material_descLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:_material_descLabel];
    
    //图片上的播放按钮
    UIButton *playButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 40, 40) title:nil titleColor:nil imageName:@"iconfont-bofang" backgroundImageName:nil target:self selector:@selector(playFoodStep:)];
    playButton.center = _imageFood.center;
    [_imageFood addSubview:playButton];
}

//返回按钮
- (void)fanhui
{
    self.myFanHuiBlock();
}

//播放食材视频
- (void)foodMaterClick:(FoodDetailModel *)model
{
    self.playFoodMeBlock(model);
}

//播放步骤视频
- (void)playFoodStep:(FoodDetailModel *)model
{
   self.playBlock(model);
}

//下载视频
- (void)dolownClick
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂不支持下载" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
                             
                             
    
}

//刷新UI
- (void)refreshUI:(FoodDetailModel *)model
{
    [_imageFood sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
    _dashes_nameLabel.text = model.dishes_name;
    _material_descLabel.text = model.material_desc;
}

@end
