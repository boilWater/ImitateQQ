//
//  BaseUITableViewController.m
//  ImitateQQ
//
//  Created by liangbai on 16/4/17.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "BaseUITableViewController.h"
#import "Imitate-Prefix.pch"
#import "DataIntoFileManager.h"

@implementation BaseUITableViewController

- (void)reloadData

{
//    _placeHolerHidden = YES;
    if (!_placeHolerHidden) {
        _needShowPlaceHoler = YES;
        if (_needShowPlaceHoler == NO) {
            _needShowPlaceHoler = YES;
        }else {
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)] && [self.dataSource tableView:self numberOfRowsInSection:0] == 0 ) {
                [self showPlaceHolder];
            }else {
                [self hidePlaceHolder];
            }
        }
    }
    [super reloadData];
}

- (void)showPlaceHolder
{
    if (_placeHolerHidden == YES || (_placeHolerView && !_placeHolerView.hidden)) {
        return;
    }
    if (_placeHolerView == nil) {
        UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 120, UISCREEN_WIGHT, UISCREEN_HEIGHT - 120)];
        bg.backgroundColor = [UIColor clearColor];
        [self.superview addSubview:bg];
        _placeHolerView = bg;
        
        CGRect tmpFrame = CGRectZero;
        if (_placeHolerImage) {
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_placeHolerImage]];
            tmpFrame = imgView.frame;
            tmpFrame.origin.x = self.frame.size.width/2 - tmpFrame.size.width/2;
            tmpFrame.origin.y = self.frame.size.height/2 - tmpFrame.size.height/2 -120;
            imgView.frame = tmpFrame;
            [bg addSubview:imgView];
            _imageView = imgView;
        }
        if (_placeHolerText) {
            CGRect labelRect = CGRectMake(0,tmpFrame.origin.y+tmpFrame.size.height+10 , self.frame.size.width, 30);
            UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
            label.text = _placeHolerText;
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTextColor:[UIColor grayColor]];
            [label setFont:[UIFont systemFontOfSize:14]];
            [bg addSubview:label];
            _label = label;
        }
        CGRect newRect = _placeHolerView.frame;
        float height = tmpFrame.size.height > UISCREEN_HEIGHT ? UISCREEN_HEIGHT:tmpFrame.size.height;
        newRect.size.height = height;
        _placeHolerView.frame = newRect;
    }
    _placeHolerView.hidden = NO;
    
    if (_clickBlock && _imageView) {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPlaceHoler:)];
        [self.superview addGestureRecognizer:gesture];
        _tapGesture = gesture;
    }
}

- (void)hidePlaceHolder
{
    if (_placeHolerView) {
        _placeHolerView.hidden = YES;
        if (_clickBlock) {
            [self.superview removeGestureRecognizer:_tapGesture];
            _tapGesture = nil;
        }
    }
}

- (void)tapPlaceHoler:(UIGestureRecognizer *)gesture
{
    if (_clickBlock) {
        _clickBlock();
    }
}

@end
