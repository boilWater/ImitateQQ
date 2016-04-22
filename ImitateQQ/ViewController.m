//
//  ViewController.m
//  ImitateQQ
//
//  Created by liangbai on 16/4/16.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "MainCell.h"
#import "groupModel.h"
#import "personModel.h"
#import "Imitate-Prefix.pch"
#import "HZNetworkEngine.h"
#import "AppMacros.h"
#import "ClipImageUtils.h"
#import "AFHTTPRequestOperation.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "FriendTitleCell.h"
#import "DataIntoFileManager.h"

#define MAIN_CELL @"main_cell"

@interface ViewController ()
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    [self initNavigation];
    [self initView];
}
-(void)initNavigation{
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIGHT, 70)];
    navigationBar.backgroundColor = [UIColor clearColor];
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(clipRightItem)];
    navigationItem.rightBarButtonItem = rightItem;
    navigationItem.title = @"联系人";
    [navigationBar pushNavigationItem:navigationItem animated:YES];
    
    [self.view addSubview:navigationBar];
    
}
-(void)initTableView{
    _haveHeadReFesh = YES;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 72, UISCREEN_WIGHT,UISCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    FriendTitleCell *friendCell = [[FriendTitleCell alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIGHT, FRIEND_CELL_WIDTH +65)];
    friendCell.selectFriImagSelegate = self;
    self.friendCell = friendCell;
    
    if (_haveHeadReFesh) {
        __weak typeof(self) weakSelf = self;
        [self.tableView addHeaderWithCallback:^{
            [weakSelf getMyPresentGroup:YES];
        }];
    }
}
-(void)initView{
    titleDataArray = [[NSMutableArray alloc] init];
    id tempTitle = [NSJSONSerialization JSONObjectWithData:[[DataIntoFileManager shareInstance] getArrayFromFile:TITLE_ACHEA_FILE] options:0 error:nil];
    if (tempTitle != nil) {
        [self decodeJson:tempTitle clear:YES];
    }
    selectedArr = [[NSMutableArray alloc] init];
    dataArray = [[NSArray alloc] init];
    
    UIButton *headBt = [[UIButton alloc] initWithFrame:CGRectMake(18, 22, 40, 40)];
    [headBt addTarget:self action:@selector(clipLeftItem) forControlEvents:UIControlEventTouchDown];
    [headBt setImage:[self clipImge:[UIImage imageNamed:@"user_head"]] forState:UIControlStateNormal];
    [self.view addSubview:headBt];
}

//下拉加载数据
-(void)getMyPresentGroup:(BOOL) clear{
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:GROUP_URL]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
         if (data != nil) {
             //对加载数据进行缓存
             [[DataIntoFileManager shareInstance] writeArrayIntoFile:data fileName:TITLE_ACHEA_FILE];
             id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
             [self decodeJson:dict clear:clear];
             [_tableView headerEndRefreshing];
         }else{
             _tableView.headerPullToRefreshText = @"数据加载失败";
             [_tableView headerEndRefreshing];
             [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
         }
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

//对于数据进行解析
-(void)decodeJson:(id)json clear:(BOOL)clear{
    if (clear) {
        [titleDataArray removeAllObjects];
    }
    for (int i=0; i<((NSMutableArray*)json).count; i++)
    {
        //解析分组，对分组进行分装
        _groupModel = [[GroupModel alloc] init];
        _groupModel.personArray = [[NSMutableArray alloc] init];
        _groupModel.GroupID = [json[i][@"category"][@"id"] integerValue];
        _groupModel.GroupName = json[i][@"category"][@"categoryName"];
        
        for (int j =0; j<((NSMutableArray*)json[i][@"authors"]).count; j++)
        {
            _personModel = [[PersonModel alloc] init];
            _personModel.sign = @"MainCell";
            _personModel.avatar = json[i][@"authors"][j][@"avatar"];
            _personModel.followStatus = [json[i][@"authors"][j][@"followStatus"] integerValue];
            _personModel.intro = json[i][@"authors"][j][@"intro"];
            _personModel.niceName = json[i][@"authors"][j][@"nickname"];
            _personModel.netStatus = @"2G";
            _personModel.subscriptionNum = [json[i][@"authors"][j][@"subscriptionNum"] integerValue];
            _personModel.personID = [json[i][@"authors"][j][@"id"] integerValue];
            [_groupModel.personArray addObject:_personModel];
        }
        [titleDataArray addObject:_groupModel];
    }
    [_tableView headerEndRefreshing];
    [_tableView reloadData];
}

#pragma mark----tableViewDelegate
//返回几个表头
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return titleDataArray.count+1;
}

//每一个表头下返回几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        _groupModel = titleDataArray[section-1];
        NSString *indexr = [NSString stringWithFormat:@"%ld", (long)_groupModel.GroupID];
        
        if ([selectedArr containsObject:indexr]) {
            UIImageView *imageV = (UIImageView *)[_tableView viewWithTag:20000+section];
            imageV.image = [UIImage imageNamed:@"buddy_header_arrow_down@2x.png"];
            
            return _groupModel.personArray.count;
        }
    }
    return 0;
}

//设置表头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 40;
}

//Section Footer的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.2;
}

//设置view，将替代titleForHeaderInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 320, 30)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, tableView.frame.size.width-80, 30)];
    
    _groupModel = titleDataArray[section -1];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = _groupModel.GroupName;
    UILabel *numberOnLine = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 60, 5, 60, 30)];
    numberOnLine.font = [UIFont systemFontOfSize:14];
    numberOnLine.textColor = [UIColor grayColor];
    numberOnLine.text = [NSString stringWithFormat:@"15/%lu",(unsigned long)_groupModel.personArray.count];

    [view addSubview:titleLabel];
    [view addSubview:numberOnLine];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 15, 15)];
    imageView.tag = 20000+section;
    
    //判断是不是选中状态
    NSString *string = [NSString stringWithFormat:@"%ld",(long)section -1];
    
    if ([selectedArr containsObject:string]) {
        imageView.image = [UIImage imageNamed:@"buddy_header_arrow_down@2x.png"];
    }
    else
    {
        imageView.image = [UIImage imageNamed:@"buddy_header_arrow_right@2x.png"];
    }
    [view addSubview:imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, UISCREEN_WIGHT, 40);
    button.tag = _groupModel.GroupID;
    [button addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, UISCREEN_WIGHT, 1)];
    lineImage.image = [UIImage imageNamed:@"line.png"];
    [view addSubview:lineImage];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return FRIEND_CELL_WIDTH +75;
    }else{
        _groupModel = [titleDataArray objectAtIndex:indexPath.section-1];
        _personModel = [_groupModel.personArray objectAtIndex:indexPath.section-1];
        if ([_personModel.sign isEqualToString:@"MainCell"])
        {
            return 60;
        }
        else
            return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *friendTitle = @"FriendTitleCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:friendTitle];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:friendTitle];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:self.friendCell];
        return cell;
        
    }else{
        _groupModel = titleDataArray[indexPath.section-1];
        NSString *inder = [NSString stringWithFormat:@"%ld",(long)_groupModel.GroupID];
        MainCell *cell = [tableView dequeueReusableCellWithIdentifier:MAIN_CELL];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        if ([selectedArr containsObject:inder])
        {
            if (cell == nil) {
                cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MAIN_CELL];
            }
            _personModel = [_groupModel.personArray objectAtIndex:indexPath.section-1];
            cell.nameLabel.text = _personModel.niceName;
            cell.IntroductionLabel.text =[[NSString stringWithString:_personModel.intro] substringToIndex:18];
            cell.networkLabel.text = _personModel.netStatus;
            
            [cell.Headerphoto sd_setImageWithURL:[NSURL URLWithString:_personModel.avatar] placeholderImage:[UIImage imageNamed:@"placeholder.png"] isClipRound:YES];
            if (indexPath.row == titleDataArray.count-1) {
                cell.imageLine.image = nil;
            }else
                cell.imageLine.image = [UIImage imageNamed:@"line.png"];
            return cell;
        }else{
            return nil;
            
        }
    }
    return nil;
}
//对于二级的菜单进行选着
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


-(void)doButton:(UIButton *)sender
{
    NSString *string = [NSString stringWithFormat:@"%ld",sender.tag];
    //数组selectedArr里面存的数据和表头想对应，方便以后做比较
    if ([selectedArr containsObject:string])
    {
        [selectedArr removeObject:string];
    }
    else
    {
        [selectedArr addObject:string];
    }
    
    [_tableView reloadData];
}
#pragma 
#pragma 在界面中图片的选择监听
-(void)selectFriendImage{
    [SVProgressHUD showInfoWithStatus:@"新朋友"];
}
-(void)selectGroupImage{
    [SVProgressHUD showInfoWithStatus:@"群组"];
}
-(void)selectSpecialCareImage{
    [SVProgressHUD showInfoWithStatus:@"特别关心"];
}
-(void)selectpublicImage{
    [SVProgressHUD showInfoWithStatus:@"公众号"];
}
#pragma 点击头像按钮
-(void)clipLeftItem{
    [SVProgressHUD showInfoWithStatus:@"点击头像"];
}
#pragma 点击navigation的左侧按钮
-(void)clipRightItem{
    [SVProgressHUD showInfoWithStatus:@"点击navigation的左侧按钮"];
}

-(void)dealloc{
    NSLog(@"ViewController");
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
