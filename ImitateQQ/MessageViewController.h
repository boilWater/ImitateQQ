//
//  MessageViewController.h
//  ImitateQQ
//
//  Created by liangbai on 16/4/17.
//  Copyright © 2016年 liangbai. All rights reserved.
//
//
//是关于消息的显示的Controller
//
//

#import <UIKit/UIKit.h>
#import "BaseUITableViewController.h"

@interface MessageViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    NSInteger tapView;
}

@property(nonatomic, assign) BOOL haveHeadReFesh;
@property(nonatomic, assign) BOOL haveFootReFesh;

@property(nonatomic, strong) BaseUITableViewController *tableView;

@end
