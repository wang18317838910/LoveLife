//
//  GuidePageView.m
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/29.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import "GuidePageView.h"

@interface GuidePageView()
{
    UIScrollView *_scrollView;
}
@end

@implementation GuidePageView

- (id)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray
{
    if (self = [super initWithFrame:frame]) {
        
        //创建scrollview
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H + 64)];
        //设置分页
        _scrollView.pagingEnabled = YES;
        //设置contentSize
        _scrollView.contentSize = CGSizeMake(Screen_W * imageArray.count, Screen_H + 64);
        [self addSubview:_scrollView];
        
        //创建imageView
        for (int i = 0 ; i < imageArray.count; i++) {
            UIImageView *imageView = [FactoryUI createImageViewWithFrame:CGRectMake(Screen_W * i, 0, Screen_W, Screen_H + 64) imageName:imageArray[i]];
            imageView.userInteractionEnabled = YES;
            [_scrollView addSubview:imageView];
            
            if (i == imageArray.count - 1) {
                self.GoInAppButton = [[UIButton alloc] init];
                self.GoInAppButton.frame = CGRectMake(100, 100, 50, 50);
                [self.GoInAppButton setImage:[UIImage imageNamed:@"LinkedIn"] forState:UIControlStateNormal];
                [imageView addSubview:self.GoInAppButton];
            }
        }
        
    }
    return self;
}

@end
