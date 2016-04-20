//
//  ClipImageUtils.m
//  ImitateQQ
//
//  Created by liangbai on 16/4/18.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "ClipImageUtils.h"

@implementation ClipImageUtils

+(UIImage*)clipImageRedious:(UIImage*)image{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    UIBezierPath *clipBezier = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.width)];
    [clipBezier addClip];
    [image drawAtPoint:CGPointZero];
    UIImage *tempImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImage;
}

@end
