//
//  RecordModel.h
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/31.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordModel : NSObject

//头像
@property (nonatomic,strong) NSString *publisher_icon_urlString;
//时间
@property (nonatomic,strong) NSString *pub_timeString;
//文字
@property (nonatomic,strong) NSString *textString;
//网名
@property (nonatomic,strong) NSString *publisher_nameString;
//图片
@property (nonatomic,strong) NSArray *image_urlsArray;

//id
@property (nonatomic,strong) NSString *dataID;



@end
