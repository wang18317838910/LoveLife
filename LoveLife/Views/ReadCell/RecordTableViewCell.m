//
//  RecordTableViewCell.m
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/31.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import "RecordTableViewCell.h"

@implementation RecordTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    //头像
    _imageIcon = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 40, 40) imageName:@""];
    _imageIcon.layer.cornerRadius = 20;
    [self.contentView addSubview:_imageIcon];
    
    //网名
    _nameLabel = [FactoryUI createLabelWithFrame:CGRectMake(_imageIcon.frame.size.width + _imageIcon.frame.origin.x + 10, 20, 150, 20) text:nil textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:16]];
    [self.contentView addSubview:_nameLabel];
    
    //时间
    _timeLabel = [FactoryUI createLabelWithFrame:CGRectMake(Screen_W - 160, 20, 150, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:12]];
    
    [self.contentView addSubview:_timeLabel];
    
    //图片
    _imageLarge = [FactoryUI createImageViewWithFrame:CGRectMake(10, _imageIcon.frame.size.height + 10, Screen_W - 20, 160) imageName:@""];
    [self.contentView addSubview:_imageLarge];
    
    //文字
    _textLabel = [[UILabel alloc] init];
    _textLabel.font = [UIFont systemFontOfSize:14];
    _textLabel.numberOfLines = 0;
    _textLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    [self.contentView addSubview:_textLabel];
}

- (void)refreshUI:(RecordModel *)model
{
   
    _timeLabel.text = model.pub_timeString;
    _nameLabel.text = model.publisher_nameString;
    
    [_imageIcon sd_setImageWithURL:[NSURL URLWithString:model.publisher_icon_urlString] placeholderImage:[UIImage imageNamed:@""]];
    
    NSArray *array = model.image_urlsArray;
    
    NSDictionary *dic = array[0];
    NSString *string = dic[@"large"];
    
    [_imageLarge sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:[UIImage imageNamed:@""]];
    
    //计算内容的大小
    CGSize contentSize = [model.textString boundingRectWithSize:CGSizeMake(Screen_W - 20, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    _textLabel.frame = CGRectMake(10, _imageLarge.frame.size.height + _imageLarge.frame.origin.y + 10, Screen_W - 20, contentSize.height + 20);
     _textLabel.text = model.textString;
    self.cellHeight = CGRectGetMaxY(_textLabel.frame) + 10 ;
    
}

@end
