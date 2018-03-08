//
//  ZSKNetworkManager.m
//  SchoolAssistant
//
//  Created by  庄少坤 on 2018/3/8.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import "ZSKNetworkManager.h"

@implementation ZSKNetworkManager

+(instancetype)shared{
    static ZSKNetworkManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZSKNetworkManager alloc] init];
        //增加返回接受的类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
    });
    return manager;
}

-(void)send:(Method)httpType urlString:(NSString *)urlString parameters:(id)parameters success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    if (httpType == GET) {
        [self GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }else{
        [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

@end
