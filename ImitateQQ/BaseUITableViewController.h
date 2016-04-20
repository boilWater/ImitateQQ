//
//  BaseUITableViewController.h
//  ImitateQQ
//
//  Created by liangbai on 16/4/17.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseUITableViewController : UITableView
//placeHoder
@property(nonatomic,assign,readonly) BOOL needShowPlaceHoler;

@property(nonatomic,weak,readonly) UIImageView *imageView;

@property(nonatomic,weak,readonly) UILabel *label;

@property(nonatomic,weak,readonly) UIView *placeHolerView;

@property(nonatomic,strong,readonly) UITapGestureRecognizer *tapGesture;

//you can set
@property(nonatomic,copy) NSString *placeHolerImage;

@property(nonatomic,copy) NSString *placeHolerText;

@property(nonatomic,assign) BOOL placeHolerHidden;

@property(nonatomic,copy) void(^clickBlock)();

- (void)showPlaceHolder;

@end
