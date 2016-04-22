//
//  NewsViewController.m
//  ImitateQQ
//
//  Created by liangbai on 16/4/17.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "NewsViewController.h"
#import "Imitate-Prefix.pch"

@implementation NewsViewController

-(void)viewDidLoad{
    
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"动态" image:[UIImage imageNamed:@"epr"] selectedImage:[UIImage imageNamed:@""]];
    
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(UISCREEN_WIGHT/2-100, UISCREEN_HEIGHT/2 - 200, 200, 400)];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = [UIColor blueColor];
    label.text = @"动态界面";
    [self.view addSubview:label];
}

@end
