//
//  FriendTitleCell.h
//  ImitateQQ
//
//  Created by liangbai on 16/4/19.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectFriendCellImage<NSObject>
@required

-(void)selectFriendImage;
-(void)selectSpecialCareImage;
-(void)selectGroupImage;
-(void)selectpublicImage;

@end

@interface FriendTitleCell : UIView

@property(nonatomic) id<SelectFriendCellImage> selectFriImagSelegate;

@property(nonatomic, weak) UISearchBar *search;

@property (nonatomic, weak) UIButton *addFriendButton;
@property (nonatomic, weak) UIButton *caresButton;
@property (nonatomic, weak) UIButton *groupButton;
@property (nonatomic, weak) UIButton *publicNumberButton;

@end
