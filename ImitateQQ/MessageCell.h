//
//  MessageCell.h
//  ImitateQQ
//
//  Created by liangbai on 16/4/26.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

+(UINib *) nib;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *intruduceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *HeadView;
@property (weak, nonatomic) IBOutlet UILabel *stateNetLabel;


@end
