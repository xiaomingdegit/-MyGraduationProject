//
//  LWNetworkManager.m
//  LW
//
//  Created by 刘威 on 2018/1/25.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import "LWNetworkManager.h"

@implementation LWNetworkManager

+(instancetype)shared{
    static LWNetworkManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LWNetworkManager alloc] init];
        //增加返回接受的类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
    });
    return manager;
}

-(void)requestWithMothod:(Method)mothod url:(NSString *)url parameters:(NSDictionary *)parameters completion:(void(^)(id responseDate, BOOL isSuccess))completion{
    if (mothod == GET) {
        [self GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            completion(responseObject, YES);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            LWLog(@"%@",error);
            completion(nil, NO);
        }];
    }else{
        [self POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            completion(responseObject, YES);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            LWLog(@"%@",error);
            completion(nil, NO);
        }];
    }
}

@end
