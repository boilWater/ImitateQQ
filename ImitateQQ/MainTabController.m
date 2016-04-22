//
//  MainTabController.m
//  ImitateQQ
//
//  Created by liangbai on 16/4/17.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "MainTabController.h"
#import "ViewController.h"
#import "MessageViewController.h"
#import "NewsViewController.h"

@implementation MainTabController

static MainTabController *_sharedInstance;

+(MainTabController*)sharedInstance{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _sharedInstance = [[MainTabController alloc] init];
    });
    return _sharedInstance;
}

-(UITabBarController *)controllerWithCenrtItemAndTitles{
    
    MessageViewController *mesVC = [[MessageViewController alloc] init];
    mesVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"exd"] selectedImage:[UIImage imageNamed:@"exe"]];


    ViewController *mainVC = [[ViewController alloc] init];
    mainVC.title = @"联系人";
    mainVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"联系人" image:[UIImage imageNamed:@"erm"] selectedImage:[UIImage imageNamed:@"erk"]];
    
    NewsViewController *newsVC = [[NewsViewController alloc] init];
       newsVC.title = @"动态";
    newsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"动态" image:[UIImage imageNamed:@"epr"] selectedImage:[UIImage imageNamed:@""]];
    
    UITabBarController *tabController = [[UITabBarController alloc] init];
    [tabController setViewControllers:@[mesVC, mainVC,newsVC]];
    
    return tabController;
    
}

@end
