//
//  MainCell.h
//  ImitateQQ
//
//  Created by liangbai on 16/4/16.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCell : UITableViewCell

@property (strong, nonatomic)  UILabel *nameLabel;

@property (strong, nonatomic)  UILabel *IntroductionLabel;

@property (strong, nonatomic)  UILabel *networkLabel;

@property (strong, nonatomic)  UIImageView *Headerphoto;

@property (strong, nonatomic)  UIImageView *bubbloView;

@property (strong, nonatomic) UIImageView *imageLine;

- (void)setMainCell;

@end
