//
//  ClipImageUtils.h
//  ImitateQQ
//
//  Created by liangbai on 16/4/18.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ClipImageUtils : NSObject

@property(nonatomic) UIImage *clipImage;

+(ClipImageUtils*)sharedInstance;

-(UIImage*)clipImageRedious:(UIImage*)image;

@end
