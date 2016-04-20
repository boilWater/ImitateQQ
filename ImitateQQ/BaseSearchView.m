//
//  BaseScrollView.m
//  ImitateQQ
//
//  Created by liangbai on 16/4/17.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#include "BaseSearchView.h"
#import "Imitate-Prefix.pch"

@implementation BaseSearchView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIGHT, 35)];
        _search.searchBarStyle = UISearchBarStyleMinimal;
        _search.backgroundColor = [UIColor clearColor];
         _search.placeholder = @"搜索";
        _search.layer.cornerRadius = 2;
        _search.layer.masksToBounds = YES;
        [self addSubview:_search];
    }
    return self;
}

@end
