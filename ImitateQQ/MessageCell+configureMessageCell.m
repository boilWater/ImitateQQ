//
//  MessageCell+configureMessageCell.m
//  ImitateQQ
//
//  Created by liangbai on 16/4/26.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "MessageCell+configureMessageCell.h"

@implementation MessageCell (configureMessageCell)

-(void)configureMessageCell:(NSString *)item{
    self.name.text = item;
    self.intruduceLabel.text = @"你好，我是好人";
    
    UIImage *image = [UIImage imageNamed:@"user_head"];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    UIBezierPath *clipBezier = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.width)];
    [clipBezier addClip];
    [image drawAtPoint:CGPointZero];
    [self.HeadView setImage:UIGraphicsGetImageFromCurrentImageContext()];
    UIGraphicsEndImageContext();
    
    self.stateNetLabel.text = @"2G";
}

@end
