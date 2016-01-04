//
//  FoodTitleCollectionViewCell.m
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/31.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import "FoodTitleCollectionViewCell.h"

@implementation FoodTitleCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, 10, (Screen_W - 20) / 2, 30) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

@end
