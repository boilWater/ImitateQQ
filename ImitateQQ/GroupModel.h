//
//  GroupModel.h
//  ImitateQQ
//
//  Created by liangbai on 16/4/16.
//  Copyright © 2016年 liangbai. All rights reserved.
//

/**
 *分组的具体情况的数学模型
 *
 */
#import <Foundation/Foundation.h>

@interface GroupModel : NSObject

//第几组
@property(nonatomic, assign) NSInteger GroupID;
//分组的名字
@property(nonatomic,copy) NSString *GroupName;
//当前在线人数
@property(nonatomic, assign) NSInteger *numberOnLine;
//每一组的总工人数
@property(nonatomic, assign) NSInteger *numberTotal;

@property(nonatomic, strong) NSMutableArray *personArray;


@end
