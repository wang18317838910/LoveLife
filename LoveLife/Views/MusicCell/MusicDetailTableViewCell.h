//
//  MusicDetailTableViewCell.h
//  LoveLife
//
//  Created by qiaqnfeng on 16/1/4.
//  Copyright © 2016年 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicDetailModel.h"

@interface MusicDetailTableViewCell : UITableViewCell
{
    UIImageView *_imageview;
    //歌手
    UILabel *_artistLabel;
    //歌曲名称
    UILabel *_nameLabel;
}

- (void)refreshUI:(MusicDetailModel *)model;


@end
