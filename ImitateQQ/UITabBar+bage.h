//
//  UITabBar+bage.h
//  ImitateQQ
//
//  Created by liangbai on 16/4/21.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (bage)

//显示小红点
- (void)showBadgeOnItemIndex:(int)index;
- (void)hideBadgeOnItemIndex:(int)index;

@end
