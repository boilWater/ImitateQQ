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
#import "QHBubble.h"

@interface MessageViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,QHBubbleDelegate>{
    NSInteger tapView;
    QHBubble *_bubbleV;
}
@property(nonatomic, strong) UIButton *btn;
@property(nonatomic, assign) BOOL haveHeadReFesh;
@property(nonatomic, assign) BOOL haveFootReFesh;

@property(nonatomic, strong) BaseUITableViewController *tableView;
@property(nonatomic, strong) UIView *viewBubble;
@property(nonatomic, strong) UIImage *headImage;

-(UIImage*)clipImge:(UIImage*)image;


@end
