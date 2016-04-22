//
//  ClipImageUtils.m
//  ImitateQQ
//
//  Created by liangbai on 16/4/18.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "ClipImageUtils.h"

@implementation ClipImageUtils

static ClipImageUtils *_sharedInstanced = nil;

+(ClipImageUtils*)sharedInstance{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _sharedInstanced = [[ClipImageUtils alloc] init];
    });
    return _sharedInstanced;
}

-(UIImage*)clipImageRedious:(UIImage*)image{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    UIBezierPath *clipBezier = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.width)];
    [clipBezier addClip];
    [image drawAtPoint:CGPointZero];
    self.clipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return self.clipImage;
}

/*
 UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
 UIBezierPath *clipBezier = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.width)];
 [clipBezier addClip];
 [image drawAtPoint:CGPointZero];
 wself.image = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
*/

@end
