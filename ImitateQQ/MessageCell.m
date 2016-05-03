//
//  MessageCell.m
//  ImitateQQ
//
//  Created by liangbai on 16/4/26.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell
+(UINib*)nib{
    return [UINib nibWithNibName:@"MessageCell" bundle:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
