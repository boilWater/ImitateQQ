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
#import "UITabBar+bage.h"
#import "SVProgressHUD.h"

#define MAIN_CELL @"mainCell"

@implementation MessageViewController{
    NSArray *array;
}

-(void)viewDidLoad{
    //判断是message界面还是iphone界面
    tapView = MESSAGE_VIEW;
    [super viewDidLoad];
    
    [self initTableView];
    [self initNavigation];
    [self initView];
    
    array = [NSArray arrayWithObjects:@"nihao",@"nihao",@"nihao",@"nihao",@"nihao",@"nihao",@"nihao",@"nihao", nil];

    //模仿发送信息
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(sendMessageAction) userInfo:nil repeats:YES];
    
}

#pragma 初始化界面的元素
-(void)initView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(UISCREEN_WIGHT -50, 135, 40, 20)];
    view.hidden = YES;
    self.viewBubble = view;
    [self.view addSubview:self.viewBubble];
    
    UIButton *headBt = [[UIButton alloc] initWithFrame:CGRectMake(18, 22, 40, 40)];
    [headBt addTarget:self action:@selector(clipLeftItem) forControlEvents:UIControlEventTouchDown];
    [headBt setImage:[self clipImge:[UIImage imageNamed:@"user_head"]] forState:UIControlStateNormal];
    [self.view addSubview:headBt];
}
-(void)initNavigation{
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIGHT, 70)];
    navigationBar.backgroundColor = [UIColor clearColor];
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_mem"] style:UIBarButtonItemStylePlain target:self action:@selector(clipRightItem)];
    navigationItem.rightBarButtonItem = rightItem;
    
    UIView *navgTitleView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 120, 30)];
    UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:@[@"消息", @"电话"]];
    [segControl setFrame:CGRectMake(0, 0, 120, 30)];
    segControl.selectedSegmentIndex = 0;
    [segControl setSelected:YES];
    [segControl addTarget:self action:@selector(segControlAction:) forControlEvents:UIControlEventValueChanged];
    [navgTitleView addSubview:segControl];
    navigationItem.titleView = navgTitleView;
    [navigationBar pushNavigationItem:navigationItem animated:YES];
    
    [self.view addSubview:navigationBar];
}
-(void)initTableView{
    _haveHeadReFesh = YES;
    _haveFootReFesh = YES;
    
    BaseUITableViewController *baseTableView = [[BaseUITableViewController alloc] initWithFrame:CGRectMake(0, 72, UISCREEN_WIGHT, UISCREEN_HEIGHT)];
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
//得到群组信息
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
            return 40;
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
        cell.networkLabel.text = @"下午3:00";
        [cell.Headerphoto setImage:[UIImage imageNamed:@"no_share@2x"]];
        
        return cell;
    }
    return nil;
}
#pragma 在选着栏进行消息提醒功能
- (void)sendMessageAction
{
    self.viewBubble.hidden = NO;
    NSInteger number = arc4random()%10+1;
    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", (long)number];
    if (_bubbleV == nil)
    {
        UIFont *font = [UIFont systemFontOfSize:8];
        CGSize s = [@"瑾" sizeWithAttributes:@{NSFontAttributeName:font}];
        _bubbleV = [[QHBubble alloc] initWithRadius:s.width*2.5 color:[UIColor redColor] content:[NSString stringWithFormat:@"%ld",(long)number] font:font forSuper:self.viewBubble];
        [_bubbleV show];
        _bubbleV.delegate = self;
    }else
    {
        [_bubbleV setValueForBubble:[NSString stringWithFormat:@"%ld",(long)number]];
    }
    [_bubbleV show];
    [_tableView reloadData];
}

#pragma mark - QHBubbleDelegate
- (void)removeBubble:(QHBubble *)bubble
{
    self.tabBarItem.badgeValue = nil;
    [_bubbleV hidden];
    _bubbleV = nil;
}
-(void)movePoint:(CGPoint)point{
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
    [SVProgressHUD showInfoWithStatus:@"点击头像"];
}
#pragma 点击navigation的左侧按钮
-(void)clipRightItem{
    [SVProgressHUD showInfoWithStatus:@"点击navigation的左侧按钮"];
}
-(UIImage*)clipImge:(UIImage *)image{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    UIBezierPath *clipBezier = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.width)];
    [clipBezier addClip];
    [image drawAtPoint:CGPointZero];
    self.headImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return self.headImage;
}

@end
