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
    
    [self initMessageTable];
    [self initNavigation];
    [self initView];

    //模仿发送信息
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(sendMessageAction) userInfo:nil repeats:YES];
    
}

#pragma 初始化界面的元素
-(void)initView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(UISCREEN_WIGHT -50, 140, 40, 20)];
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

#pragma 初始化Message and phone tableView
-(void)initMessageTable{
    _haveHeadReFesh = YES;
    _haveFootReFesh = YES;
    
    BaseUITableViewController *baseTableView = [[BaseUITableViewController alloc] initWithFrame:CGRectMake(0, 72, UISCREEN_WIGHT, UISCREEN_HEIGHT)];
    _messageTableView = baseTableView;
    _messageTableView.tableHeaderView = [self headTableView];
    _messageTableView.showsVerticalScrollIndicator = YES;
    _messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _messageTableView.dataSource = self;
    _messageTableView.delegate = self;
    _messageTableView.placeHolerImage = @"message_no";
    _messageTableView.placeHolerText = @"目前没有信息";
    
    array = [NSArray arrayWithObjects:@"nihao",@"nihao",@"nihao",@"nihao",@"nihao",@"nihao",@"nihao",@"nihao", nil];
    self.messageArray = array;
    
    if (_haveHeadReFesh) {
        __weak typeof(self) weakSelf = self;
        [self.messageTableView addHeaderWithCallback:^{
            [weakSelf getMyPresentGroup:YES];
        }];
    }
    if (_haveFootReFesh) {
        __weak typeof(self) weakSelf = self;
        [self.messageTableView addFooterWithCallback:^{
            [weakSelf getMyPresentGroup:YES];
        }];
    }
    [self.view addSubview:_messageTableView];
}
-(void)initPhoneTable{
    _haveHeadReFesh = YES;
    _haveFootReFesh = YES;
    
    BaseUITableViewController *baseTableView = [[BaseUITableViewController alloc] initWithFrame:CGRectMake(0, 72, UISCREEN_WIGHT, UISCREEN_HEIGHT)];
    _phoneTableView = baseTableView;
    _phoneTableView.tableHeaderView = [self headTableView];
    _phoneTableView.showsVerticalScrollIndicator = YES;
    _phoneTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _phoneTableView.dataSource = self;
    _phoneTableView.delegate = self;
    _phoneTableView.placeHolerText = @"目前没有信息";
    _phoneTableView.placeHolerImage = @"message_no";
    
    if (_haveHeadReFesh) {
        __weak typeof(self) weakSelf = self;
        [self.phoneTableView addHeaderWithCallback:^{
            [weakSelf getMyPresentGroup:YES];
        }];
    }
    
    [self.view addSubview:self.phoneTableView];
}
//得到群组信息
-(void)getMyPresentGroup:(BOOL)clear{
    [self.messageTableView headerEndRefreshing];
    [self.messageTableView footerEndRefreshing];
    
    [self.phoneTableView headerEndRefreshing];
}

#pragma 返回taviewHeadView的表头
-(UIView*)headTableView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIGHT, 44)];
    UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIGHT, 44)];
    search.delegate = self;
    search.searchBarStyle = UISearchBarStyleMinimal;
    search.placeholder = @"搜索";
    [headView addSubview:search];
    return headView;
}

#pragma tableView datasource and delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.messageTableView == tableView) {
        return self.messageArray.count;
    }
    if (self.phoneTableView == tableView) {
        return self.phoneArray.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.messageTableView == tableView) {
        return 60;
    }
    if (self.phoneTableView == tableView) {
        return 60;
    }
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.messageTableView == tableView)
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
    //如果是phoneView就对其进行相关的Cell自定义
    if (self.phoneTableView == tableView) {
        return nil;
    }
    return nil;
}
#pragma 在选着栏进行消息提醒功能
- (void)sendMessageAction
{
    if (self.messageArray.count > 0 && tapView == MESSAGE_VIEW) {
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
        [_messageTableView reloadData];
    }else{
        self.viewBubble.hidden = YES;
        [_bubbleV hidden];
        self.tabBarItem.badgeValue = nil;
    }
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

#pragma search delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [SVProgressHUD showInfoWithStatus:@"点击搜索"];
}

#pragma 选择segment，并设置tableView进行数据更新
-(void)segControlAction:(UISegmentedControl*)segment{
    NSInteger index = segment.selectedSegmentIndex;
    switch (index) {
        case 0:{
            [self.phoneTableView removeFromSuperview];
            [self initMessageTable];
            tapView = MESSAGE_VIEW;
            break;
        }
        case 1:{
            [self.messageTableView removeFromSuperview];
            [self initPhoneTable];
            tapView = PHONE_VIEW;
            break;
        }
        default:
            break;
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
