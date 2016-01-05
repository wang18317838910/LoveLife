//
//  MusicDetailTableViewCell.m
//  LoveLife
//
//  Created by qiaqnfeng on 16/1/4.
//  Copyright © 2016年 CCW. All rights reserved.
//

#import "MusicDetailTableViewCell.h"


@implementation MusicDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    _imageview = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 100, 70) imageName:nil];
    [self.contentView addSubview:_imageview];
    
<<<<<<< Updated upstream
    _nameLabel = [FactoryUI createLabelWithFrame:CGRectMake(_imageview.frame.size.width + _imageview.frame.origin.x + 10, 20, 150, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:16]];
    [self.contentView addSubview:_nameLabel];
    
    _artistLabel = [FactoryUI createLabelWithFrame:CGRectMake(_nameLabel.frame.size.width + _nameLabel.frame.origin.x , _nameLabel.frame.size.height + _nameLabel.frame.origin.y , 100, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:14]];
=======
    _nameLabel = [FactoryUI createLabelWithFrame:CGRectMake(_imageview.frame.size.width + _imageview.frame.origin.x + 10, 20, 200, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:16]];
    [self.contentView addSubview:_nameLabel];
    
    _artistLabel = [FactoryUI createLabelWithFrame:CGRectMake(_nameLabel.frame.size.width + _nameLabel.frame.origin.x , _nameLabel.frame.size.height + _nameLabel.frame.origin.y + 20 , 200, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:14]];
>>>>>>> Stashed changes
    [self.contentView addSubview:_artistLabel];
}

- (void)refreshUI:(MusicDetailModel *)model
{
<<<<<<< Updated upstream
    [_imageview sd_setImageWithURL:[NSURL URLWithString:model.coverURL] placeholderImage:[UIImage imageNamed:@""]];
=======
        [_imageview sd_setImageWithURL:[NSURL URLWithString:model.coverURL] placeholderImage:[UIImage imageNamed:@""]];
  
>>>>>>> Stashed changes
    _nameLabel.text = model.title;
    _artistLabel.text = model.artist;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
