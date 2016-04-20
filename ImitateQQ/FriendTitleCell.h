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

@property(nonatomic, weak) UIImageView *firendView;
@property(nonatomic, weak) UIImageView *specialCareView;
@property(nonatomic, weak) UIImageView *groupView;
@property(nonatomic, weak) UIImageView *publicView;

@property(nonatomic, weak) UIImageView *topImageV;
@property(nonatomic, weak) UIImageView *bottomImageV;


@end
