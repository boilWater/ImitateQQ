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


#endif /* AppMacros_h */
