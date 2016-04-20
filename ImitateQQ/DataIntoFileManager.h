//
//  DataIntoFileManager.h
//  ImitateQQ
//
//  Created by liangbai on 16/4/19.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataIntoFileManager : NSObject

+(DataIntoFileManager*)shareInstance;

-(void)writeArrayIntoFile:(NSData *)data fileName:(NSString*)fileName;

-(void)writeImageIntoFile:(UIImage *)image fileName:(NSString*)fileName;

-(NSData*)getArrayFromFile:(NSString*)fileName;

//-(NSString *)bundlePath:(NSString *)fileName;

-(NSString *)documentsPath:(NSString *)fileName;

-(NSString *)documentsPath;

@end
