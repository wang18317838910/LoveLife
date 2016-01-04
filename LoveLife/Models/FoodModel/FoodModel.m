//
//  FoodModel.m
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/31.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import "FoodModel.h"

@implementation FoodModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        
        self.detail = value;
    }
}

@end
