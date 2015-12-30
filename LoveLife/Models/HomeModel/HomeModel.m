//
//  HomeModel.m
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/29.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

//避免与系统的id重复,要重新设置一个,
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        
        self.dataID = value;
    }
}
@end
