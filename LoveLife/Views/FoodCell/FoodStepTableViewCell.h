//
//  FoodStepTableViewCell.h
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/31.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodStepModel.h"

@interface FoodStepTableViewCell : UITableViewCell
{
    //图片
    UIImageView *_imageView;
    //步骤介绍
    UILabel *_dishes_step_descLabel;
}

- (void)refreshUI:(FoodStepModel *)model IndexPath:(NSIndexPath *)indexPath;

@end
