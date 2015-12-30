//
//  ArticalTableViewCell.h
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/30.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadModel.h"

@interface ArticalTableViewCell : UITableViewCell
{
    UIImageView *_imageView;//图片
    UILabel *_timeLabel;//时间
    UILabel *_authorLabel;//作者
    UILabel *_titleLabel;//标题
}

- (void)refreshUI:(ReadModel *)model;

@end
