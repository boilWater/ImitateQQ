//
//  FriendTitleCell.m
//  ImitateQQ
//
//  Created by liangbai on 16/4/19.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "FriendTitleCell.h"
#import "Imitate-Prefix.pch"
#import "AppMacros.h"

@implementation FriendTitleCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIGHT, 35)];
        _search = search;
        _search.searchBarStyle = UISearchBarStyleMinimal;
        _search.backgroundColor = [UIColor clearColor];
        _search.placeholder = @"搜索";
        _search.layer.cornerRadius = 2;
        _search.layer.masksToBounds = YES;
        [self addSubview:_search];
        UIImageView *topImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, UISCREEN_WIGHT, 1)];
        _topImageV = topImageV;
        [_topImageV setImage:[UIImage imageNamed:@"line"]];
        [self addSubview:_topImageV];
    
        UIImageView *friendImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 45, FRIEND_CELL_WIDTH, FRIEND_CELL_WIDTH)];
        friendImageView.userInteractionEnabled = YES;
        friendImageView.tag = FRIEND_IMAGE_TAG;
        UITapGestureRecognizer *gesRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickfriendImage)];
        [friendImageView addGestureRecognizer:gesRec];
        _firendView = friendImageView;
        [_firendView setImage:[UIImage imageNamed: @"2.png"]];
        [self addSubview:_firendView];
        
        UIImageView *specialView = [[UIImageView alloc] initWithFrame:CGRectMake(FRIEND_CELL_WIDTH+20, 45, FRIEND_CELL_WIDTH, FRIEND_CELL_WIDTH)];
        specialView.userInteractionEnabled = YES;
        specialView.tag = SPECIAL_IMAGE_TAG;
        UITapGestureRecognizer *gesRec1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickspecialImage)];
        [specialView addGestureRecognizer:gesRec1];
        _specialCareView = specialView;
        [_specialCareView setImage:[UIImage imageNamed: @"2.png"]];
        [self addSubview:_specialCareView];
        
        UIImageView *groupView = [[UIImageView alloc] initWithFrame:CGRectMake(40+FRIEND_CELL_WIDTH*2, 45, FRIEND_CELL_WIDTH, FRIEND_CELL_WIDTH)];
        groupView.userInteractionEnabled = YES;
        groupView.tag = GUARD_TYPE_MACH_PORT;
        UITapGestureRecognizer *gesRec2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickgroupImage)];
        [groupView addGestureRecognizer:gesRec2];
        _groupView = groupView;
        [_groupView setImage:[UIImage imageNamed: @"2.png"]];
        [self addSubview:_groupView];
        
        UIImageView *publicView = [[UIImageView alloc] initWithFrame:CGRectMake(60+FRIEND_CELL_WIDTH*3, 45, FRIEND_CELL_WIDTH, FRIEND_CELL_WIDTH )];
        publicView.userInteractionEnabled = YES;
        publicView.tag = PUBLIC_IMAGE_TAG;
        UITapGestureRecognizer *gesRec3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickpublicImage)];
        [publicView addGestureRecognizer:gesRec3];
        _publicView = publicView;
        [_publicView setImage:[UIImage imageNamed: @"2.png"]];
        [self addSubview:_publicView];
        
        UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, FRIEND_CELL_WIDTH+10+10+45, UISCREEN_WIGHT, 1)];
        _bottomImageV = bottomView;
        [_bottomImageV setImage:[UIImage imageNamed:@"line"]];
        [self addSubview:_bottomImageV];
    }
    return self;
}

-(void)clickfriendImage{
    [self.selectFriImagSelegate selectFriendImage];
}
-(void)clickspecialImage{
    [self.selectFriImagSelegate selectSpecialCareImage];
}

-(void)clickgroupImage{
    [self.selectFriImagSelegate selectGroupImage];
}

-(void)clickpublicImage{
    [self.selectFriImagSelegate selectpublicImage];
}


@end
