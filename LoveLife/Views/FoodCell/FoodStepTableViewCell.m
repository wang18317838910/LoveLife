//
//  FoodStepTableViewCell.m
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/31.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import "FoodStepTableViewCell.h"

@implementation FoodStepTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

//设置UI
- (void)createUI
{
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 0, (Screen_W - 20), 150) imageName:@""];
    [self.contentView addSubview:_imageView];
    
    _dishes_step_descLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _imageView.frame.size.height + _imageView.frame.origin.y , (Screen_W - 20), 40) text:nil textColor:nil font:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:_dishes_step_descLabel];
}

- (void)refreshUI:(FoodStepModel *)model IndexPath:(NSIndexPath *)indexPath
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.dishes_step_imageString] placeholderImage:[UIImage imageNamed:@""]];
   
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld:%@",indexPath.row + 1,model.dishes_step_descString]];
    
    if (indexPath.row + 1 > 9) {
        [string addAttributes:@{NSForegroundColorAttributeName:RGB(255, 156, 187, 1)} range:NSMakeRange(0, 3) ];
    }else{
        [string addAttributes:@{NSForegroundColorAttributeName:RGB(255, 156, 187, 1)} range:NSMakeRange(0, 2)];
    }
    
     _dishes_step_descLabel.attributedText = string;
}


@end
