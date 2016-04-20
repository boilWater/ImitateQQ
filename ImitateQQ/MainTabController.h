//
//  MainTabController.h
//  ImitateQQ
//
//  Created by liangbai on 16/4/17.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  UITabBarController;

@interface MainTabController : NSObject

+(MainTabController*)sharedInstance;

-(UITabBarController *)controllerWithCenrtItemAndTitles;

@end
