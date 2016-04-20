//
//  MessageViewController.m
//  ImitateQQ
//
//  Created by liangbai on 16/4/17.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "MessageViewController.h"
#import "BaseUITableViewController.h"
#import "MesSegPhoneViewController.h"
#import "ClipImageUtils.h"
#import "Imitate-Prefix.pch"
#import "MainCell.h"
#import "BaseSearchView.h"
#import "MJRefresh.h"
#import "AppMacros.h"


#define MAIN_CELL @"mainCell"

@implementation MessageViewController{
    NSArray *array;
}

-(void)viewDidLoad{
    //判断是message界面还是iphone界面
    tapView = MESSAGE_VIEW;
     _haveHeadReFesh = YES;
    _haveFootReFesh = YES;
    [super viewDidLoad];
    [self initView];
    
    array = [NSArray arrayWithObjects:@"nihao",@"nihao",@"nihao",@"nihao",@"nihao",@"nihao",@"nihao",@"nihao", nil];
}

#pragma 初始化界面的元素
-(void)initView{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[ClipImageUtils clipImageRedious:[UIImage imageNamed:@"erm"]] style:UIBarButtonItemStylePlain target:self action:@selector(clipLeftItem)];
    UIView *navgTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:@[@"消息", @"电话"]];
    [segControl setFrame:CGRectMake(0, 0, 120, 30)];
    segControl.selectedSegmentIndex = 0;
    [segControl setSelected:YES];
    [segControl addTarget:self action:@selector(segControlAction:) forControlEvents:UIControlEventValueChanged];
    [navgTitleView addSubview:segControl];
    self.navigationItem.titleView = navgTitleView;
    
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_mem"] style:UIBarButtonItemStylePlain target:self action:@selector(clipRightItem)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    BaseUITableViewController *baseTableView = [[BaseUITableViewController alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIGHT, UISCREEN_HEIGHT)];
    _tableView = baseTableView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;

    if (_haveHeadReFesh) {
        __weak typeof(self) weakSelf = self;
        [self.tableView addHeaderWithCallback:^{
            [weakSelf getMyPresentGroup:YES];
        }];
    }
    if (_haveFootReFesh) {
        __weak typeof(self) weakSelf = self;
        [self.tableView addFooterWithCallback:^{
            [weakSelf getMyPresentGroup:YES];
        }];
    }
    
    [self.view addSubview:_tableView];
}
-(void)getMyPresentGroup:(BOOL)clear{
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

#pragma tableView datasource and delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tapView == MESSAGE_VIEW) {
        return array.count+1;
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tapView == MESSAGE_VIEW) {
        if (indexPath.row == 0) {
            return 33;
        }else{
            return 60;
        }
    }
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        BaseSearchView *search = [[BaseSearchView alloc] init];
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        [cell addSubview:search];
        return cell;
    }else if(tapView == MESSAGE_VIEW)
    {
        MainCell *cell = [tableView dequeueReusableCellWithIdentifier:MAIN_CELL];
        if (cell == nil) {
            cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MAIN_CELL];
        }
        cell.nameLabel.text = array[indexPath.section];
        cell.imageLine.image = [UIImage imageNamed:@"line"];
        cell.IntroductionLabel.text = @"个性签名：我是你的还朋友！！";
        cell.networkLabel.text = @"2G";
        [cell.Headerphoto setImage:[UIImage imageNamed:@"no_share@2x"]];
        return cell;
    }
    return nil;
}

#pragma 选择segment，并设置tableView进行数据更新
-(void)segControlAction:(UISegmentedControl*)segment{
    NSInteger index = segment.selectedSegmentIndex;
    if (index == PHONE_VIEW) {
        tapView = PHONE_VIEW;
        [self.tableView reloadData];
    }else{
        tapView = MESSAGE_VIEW;
        [self.tableView reloadData];
    }
}
#pragma 点击头像按钮
-(void)clipLeftItem{
    NSLog(@"点击头像按钮");
}
#pragma 点击navigation的左侧按钮
-(void)clipRightItem{
    NSLog(@"点击navigation的左侧按钮");
}

@end
