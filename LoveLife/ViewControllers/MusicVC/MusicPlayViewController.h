//
//  MusicPlayViewController.h
//  LoveLife
//
//  Created by qiaqnfeng on 16/1/5.
//  Copyright © 2016年 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicDetailModel.h"

@interface MusicPlayViewController : UIViewController

//传值
@property (nonatomic,strong) MusicDetailModel *model;
//歌曲url
@property (nonatomic,strong) NSArray *urlArray;

//名字
@property (nonatomic,strong) NSArray *titleArray;
//图片
@property (nonatomic,strong) NSArray *imageArray;
//歌手
@property (nonatomic,strong) NSArray *artistArray;

//当前页数
@property (nonatomic,assign) int currentIndex;


@end
