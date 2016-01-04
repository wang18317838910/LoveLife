//
//  FoodDetailTableViewCell.h
//  LoveLife
//
//  Created by qiaqnfeng on 16/1/2.
//  Copyright © 2016年 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodDetailModel.h"

@interface FoodDetailTableViewCell : UITableViewCell
{
    //菜名
    UILabel *_dashes_nameLabel;
    //图片
    UIImageView *_imageFood;
    //简介
    UILabel *_material_descLabel;
    //做菜时间
    UILabel *_cooke_timeLabel;
    //
    UIView *_lightView;
}
//返回
@property (nonatomic,copy)void(^myFanHuiBlock)();
//播放步骤
@property (nonatomic,copy)void(^playBlock)(FoodDetailModel *);
//播放食材
@property (nonatomic,copy) void(^playFoodMeBlock)(FoodDetailModel *);

- (void)refreshUI:(FoodDetailModel *)model;

@end
