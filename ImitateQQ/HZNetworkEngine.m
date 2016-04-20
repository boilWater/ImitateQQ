//
//  HZNetworkEngine.m
//  ImitateQQ
//
//  Created by liangbai on 16/4/16.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "HZNetworkEngine.h"
#import "SVProgressHUD.h"
#import "AppMacros.h"

@implementation HZNetworkEngine

static HZNetworkEngine *_sharedClient = nil;

+ (instancetype)sharedEngine
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] init];
    });
    return _sharedClient;
}

+ (void)post:(NSString*)url paratmers:(NSDictionary*)dic sucess:(FinishBlock)finshBlock fail:(FailBlock)failBlock{
    return [[HZNetworkEngine sharedEngine] setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *opation, id responseObject){
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)setCompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
}

@end
