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
        [self initSearch];
        [self initFourImageView];

    }
    return self;
}
-(void)initSearch{
    UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 5, UISCREEN_WIGHT, 35)];
    _search = search;
    _search.searchBarStyle = UISearchBarStyleMinimal;
    _search.backgroundColor = [UIColor clearColor];
    _search.placeholder = @"搜索";
    _search.layer.cornerRadius = 2;
    _search.layer.masksToBounds = YES;
    [self addSubview:_search];
}
-(void)initFourImageView{
    
    CGFloat widthOfButton = (UISCREEN_WIGHT - FRIEND_BUTTON_WIDTH * 4)/3.0;
    UIView *fourBV = [[UIView alloc] initWithFrame:CGRectMake(0, 60, UISCREEN_WIGHT, 74)];
    
    UIButton *addFriendButton = [self makeButtonWithImage:[UIImage imageNamed:@"friend_new.png"] title:@"新朋友"];
    [addFriendButton addTarget:self action:@selector(clickfriendImage) forControlEvents:UIControlEventTouchDown];
    addFriendButton.frame = CGRectMake(0, 0, FRIEND_BUTTON_WIDTH,FRIEND_BUTTON_HEIGHT);
    [fourBV addSubview:addFriendButton];
    self.addFriendButton = addFriendButton;
    
    UIButton *caresButton = [self makeButtonWithImage:[UIImage imageNamed:@"friend_special"] title:@"特别关心"];
    [caresButton addTarget:self action:@selector(clickspecialImage) forControlEvents:UIControlEventTouchDown];
    caresButton.frame = CGRectMake(FRIEND_BUTTON_WIDTH + widthOfButton, 0, FRIEND_BUTTON_WIDTH, FRIEND_BUTTON_HEIGHT);
    [fourBV addSubview:caresButton];
    self.caresButton = caresButton;
    
    UIButton *groupButton = [self makeButtonWithImage:[UIImage imageNamed:@"friend_group"] title:@"群组"];
    [groupButton addTarget:self action:@selector(clickgroupImage) forControlEvents:UIControlEventTouchDown];
    groupButton.frame = CGRectMake((FRIEND_BUTTON_WIDTH * 2 + widthOfButton *2), 0, FRIEND_BUTTON_WIDTH, FRIEND_BUTTON_HEIGHT);
    [fourBV addSubview:groupButton];
    self.groupButton = groupButton;
    
    UIButton *publicNumberButton = [self makeButtonWithImage:[UIImage imageNamed:@"friend_public"] title:@"公众号"];
    [publicNumberButton addTarget:self action:@selector(clickpublicImage) forControlEvents:UIControlEventTouchDown];
    publicNumberButton.frame = CGRectMake(UISCREEN_WIGHT - FRIEND_BUTTON_WIDTH, 0, FRIEND_BUTTON_WIDTH, FRIEND_BUTTON_HEIGHT);
    [fourBV addSubview:publicNumberButton];
    self.publicNumberButton = publicNumberButton;
    
    
    [self addSubview:fourBV];
}

-(UIButton*)makeButtonWithImage:(UIImage *)image title:(NSString*) title{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:image forState:(UIControlStateNormal)];
    button.adjustsImageWhenHighlighted = NO;
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -90, -40, -40);
    button.imageEdgeInsets = UIEdgeInsetsMake(-20,10,20,10);
    return button;
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
