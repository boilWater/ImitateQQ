//
//  DataIntoFileManager.m
//  ImitateQQ
//
//  Created by liangbai on 16/4/19.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "DataIntoFileManager.h"

@implementation DataIntoFileManager

static DataIntoFileManager *_sharedInstance = nil;

+(DataIntoFileManager*)shareInstance{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _sharedInstance = [[DataIntoFileManager alloc] init];
    });
    return _sharedInstance;
}
//保存图片在file文件中
-(void)writeImageIntoFile:(UIImage *)image fileName:(NSString*)fileName{
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    [self writeArrayIntoFile:data fileName:fileName];
}

-(void)writeArrayIntoFile:(NSData *)data fileName:(NSString*)fileName{
    NSString *path = [self documentsPath:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirEist = [fileManager fileExistsAtPath:path];
    if (isDirEist) {
        [fileManager removeItemAtPath:path error:nil];
        path = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    }
    [data writeToFile:path atomically:YES];
}

-(NSData *)getArrayFromFile:(NSString*)fileName{
    NSData *data = [NSData dataWithContentsOfFile:[self documentsPath:fileName]];
    return data;
}


-(NSString *)documentsPath:(NSString *)fileName{
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    
    return path;
}

-(NSString *)documentsPath{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)lastObject];
    return path;
}

@end
