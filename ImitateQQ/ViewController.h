//
//  ViewController.h
//  ImitateQQ
//
//  Created by liangbai on 16/4/16.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"
#import "PersonModel.h"
#import "FriendTitleCell.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SelectFriendCellImage>
{
    
    NSMutableArray *selectedArr;//二级列表是否展开状态
    NSMutableArray *titleDataArray;
    NSArray *dataArray;//数据源，显示每个cell的数据

}
@property(nonatomic, strong) PersonModel *personModel;
@property(nonatomic, strong) GroupModel *groupModel;
@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic, assign) BOOL haveHeadReFesh;
@property(nonatomic, assign) BOOL haveFootReFesh;

@property(nonatomic, strong) FriendTitleCell *friendCell;

//进行下拉刷新加载数据
-(void)getMyPresentGroup:(BOOL) clear;

-(void)decodeJson:(id)json clear:(BOOL)clear;


@end

