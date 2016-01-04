//
//  FoodDetail.h
//  LoveLife
//
//  Created by qiaqnfeng on 16/1/2.
//  Copyright © 2016年 CCW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodDetailModel : NSObject

//菜名
@property (nonatomic,strong) NSString *dishes_name;
//菜简介
@property (nonatomic,strong) NSString *material_desc;
//做菜时间
@property (nonatomic,strong) NSString *cooke_time;
//id
@property (nonatomic,strong) NSString *dishes_id;
//图片image
@property (nonatomic,strong) NSString *image;
//视频食材播放
@property (nonatomic,strong) NSString *material_video;
//视频步骤播放
@property (nonatomic,strong) NSString *process_video;

//做菜步骤


@end
