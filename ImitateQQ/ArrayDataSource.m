//
//  ArrayDataSource.m
//  ImitateQQ
//
//  Created by liangbai on 16/4/26.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "ArrayDataSource.h"

@interface ArrayDataSource()

@property(nonatomic, strong) NSArray *items;
@property(nonatomic,copy) NSString *idenfiter;
@property(nonatomic,copy) TableViewCellConfigureBlock configureCellBlock;

@end

@implementation ArrayDataSource

-(instancetype)init{
    return nil;
}

-(id)initWithItems:(NSArray *)items cellIndefiter:(NSString *)indefiter configureCellBlock:(TableViewCellConfigureBlock)cellConficgureBlock{
    self = [super init];
    if (self) {
        self.items = items;
        self.idenfiter = indefiter;
        self.configureCellBlock = [cellConficgureBlock copy];
    }
    return self;
}

-(id)itemAtIndexPath:(NSIndexPath *)indexPath{
    return self.items[(NSUInteger)indexPath.row];
}

#pragma tableViewDatasource 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.idenfiter];
    
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    
    return cell;
}

@end
