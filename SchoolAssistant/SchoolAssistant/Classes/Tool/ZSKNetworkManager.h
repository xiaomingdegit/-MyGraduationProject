//
//  ZSKNetworkManager.h
//  SchoolAssistant
//
//  Created by  庄少坤 on 2018/3/8.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <AFHTTPSessionManager.h>

//定义GET POST 枚举
typedef enum : NSUInteger {
    GET,
    POST,
}Method;


@interface ZSKNetworkManager : AFHTTPSessionManager


//封装单例
+(instancetype _Nullable )shared;
//封装请求

-(void)send:(Method)httpType urlString:(nonnull NSString *)urlString parameters:(id _Nullable )parameters success:(void (^_Nullable) (id _Nonnull responseObject))success failure:(void (^_Nullable) (NSError * _Nonnull error))failure;

@end
