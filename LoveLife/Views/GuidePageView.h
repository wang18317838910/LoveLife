//
//  GuidePageView.h
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/29.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuidePageView : UIView
//进入图片的button
@property (nonatomic,strong) UIButton *GoInAppButton;

- (id)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray;

@end
