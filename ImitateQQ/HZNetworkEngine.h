//
//  HZNetworkEngine.h
//  ImitateQQ
//
//  Created by liangbai on 16/4/16.
//  Copyright © 2016年 liangbai. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "AFNetworking/AFHTTPRequestOperationManager.h"


typedef void (^FinishBlock)(id result);

typedef void (^FailBlock)(id error);

@interface HZNetworkEngine : AFHTTPRequestOperation

+ (HZNetworkEngine *)sharedEngine;

+ (void)post:(NSString*)url paratmers:(NSDictionary*)dic sucess:(FinishBlock)finshBlock fail:(FailBlock)failBlock;


@end
