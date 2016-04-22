//
//  AppMacros.h
//  ImitateQQ
//
//  Created by liangbai on 16/4/16.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#ifndef AppMacros_h
#define AppMacros_h

//message界面选项
#define MESSAGE_VIEW 0
//选着phone界面的选项
#define PHONE_VIEW 1

#define GROUP_URL @"http://f.wallstcn.com/news.json"

#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define UISCREEN_WIGHT [UIScreen mainScreen].bounds.size.width

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
*在tableView中的界面布局的高度
* FriendTitleCell 中的数据
*/
#define FRIEND_CELL_WIDTH ([UIScreen mainScreen].bounds.size.width -80)/4

#define FRIEND_IMAGE_TAG 0

#define SPECIAL_IMAGE_TAG 1

#define GROUP_IMAGE_TAG 2

#define PUBLIC_IMAGE_TAG 3

#define TITLE_ACHEA_FILE @"TITLE"

#define FRIEND_BUTTON_WIDTH 74

#define FRIEND_BUTTON_HEIGHT 74


#endif /* AppMacros_h */
