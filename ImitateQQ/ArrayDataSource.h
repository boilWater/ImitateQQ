//
//  ArrayDataSource.h
//  ImitateQQ
//
//  Created by liangbai on 16/4/26.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@interface ArrayDataSource : NSObject<UITableViewDataSource>

-(id)initWithItems:(NSArray*)items cellIndefiter:(NSString*)indefiter configureCellBlock:(TableViewCellConfigureBlock) cellConficgureBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end