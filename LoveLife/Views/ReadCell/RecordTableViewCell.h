//
//  RecordTableViewCell.h
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/31.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordModel.h"

@interface RecordTableViewCell : UITableViewCell
{
    UIImageView *_imageIcon;//头像
    UIImageView *_imageLarge;//图片
    UILabel *_timeLabel;//时间
    UILabel *_textLabel;//文字
    UILabel *_nameLabel;//网名
    
}

//cell的不定高
@property (nonatomic,assign) CGFloat cellHeight;

- (void)refreshUI:(RecordModel *)model;

@end
