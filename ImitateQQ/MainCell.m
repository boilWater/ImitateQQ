//
//  MainCell.m
//  ImitateQQ
//
//  Created by liangbai on 16/4/16.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "MainCell.h"
#import "Imitate-Prefix.pch"

@implementation MainCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        _Headerphoto = [[UIImageView alloc]initWithFrame:CGRectMake(6, 10, 40, 40)];
        [self.contentView addSubview:_Headerphoto];
        
        //名字
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, 200, 25)];
        _nameLabel.backgroundColor  = [UIColor clearColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        
        //简介
        _IntroductionLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 28, UISCREEN_WIGHT - 60, 25)];
        _IntroductionLabel.backgroundColor  = [UIColor clearColor];
        _IntroductionLabel.textColor = [UIColor lightGrayColor];
        _IntroductionLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_IntroductionLabel];
        
        //网络
        _networkLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIGHT - 60, 5, 50, 25)];
        _networkLabel.backgroundColor  = [UIColor clearColor];
        _networkLabel.textColor = [UIColor lightGrayColor];
        _networkLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_networkLabel];
        
        //分割线
        _imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 59, UISCREEN_WIGHT, 0.5)];
        [self.contentView addSubview:_imageLine];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

- (void)setMainCell
{
    
}

@end
