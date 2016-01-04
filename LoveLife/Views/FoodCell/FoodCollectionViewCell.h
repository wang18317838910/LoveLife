//
//  FoodCollectionViewCell.h
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/31.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"

@protocol playDelegate <NSObject>

- (void)play:(FoodModel *)model;

@end

@interface FoodCollectionViewCell : UICollectionViewCell
{
    UIImageView *_imageView;//图片
    UILabel *_titleLabel;
    UILabel *_desLabel;
    
}

//声明一个代理的对象,代理修饰符用weak,主要是为了防止循环引用导致内存泄露.ARC下的sttrong和weak就相当于MRC下的retain和assign
@property (nonatomic,weak) id<playDelegate>delegate;

- (void)refreshUI:(FoodModel *)model;

@end
