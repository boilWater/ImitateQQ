//
//  personModel.h
//  ImitateQQ
//
//  Created by liangbai on 16/4/16.
//  Copyright © 2016年 liangbai. All rights reserved.
//

/**
 *个人信息的model,保存个人信息
 *
 */

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject
//名字
@property(nonatomic,copy) NSString *niceName;
//签名
@property(nonatomic,copy) NSString *intro;
//头像
@property(nonatomic, copy) NSString *avatar;
//个人状态
@property(nonatomic, assign) NSInteger followStatus;
//网络显示状态
@property(nonatomic, copy) NSString *netStatus;

@property(nonatomic, assign) NSInteger personID;

@property(nonatomic, assign) NSInteger subscriptionNum;

//显示是否是yi级菜单
@property(nonatomic, copy) NSString *sign;


@end
