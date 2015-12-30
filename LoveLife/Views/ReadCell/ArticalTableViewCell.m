//
//  ArticalTableViewCell.m
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/30.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import "ArticalTableViewCell.h"

@implementation ArticalTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI
{
   //图片
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 120, 90) imageName:nil];
    [self.contentView addSubview:_imageView];
    
    //时间
    _timeLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _imageView.frame.size.height + _imageView.frame.origin.y + 10, 150, 20) text:nil textColor:[UIColor lightGrayColor ] font:[UIFont systemFontOfSize:12]];
    [self.contentView addSubview:_timeLabel];
    
    //作者
    _authorLabel = [FactoryUI createLabelWithFrame:CGRectMake(Screen_W - 130, _timeLabel.frame.origin.y, 110, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:12]];
    [self.contentView addSubview:_authorLabel];
    
    //title
    _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(_imageView.frame.origin.x + _imageView.frame.size.width + 10, 5,Screen_W - _imageView.frame.size.width - 30 , 80) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:16]];
    
    //折行,如果不折行就是高度设置的不够
    _titleLabel.numberOfLines = 0;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:_titleLabel];
}

- (void)refreshUI:(ReadModel *)model
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text = model.title;
    _timeLabel.text = model.createtime;
    _authorLabel.text = model.author;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
