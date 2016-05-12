//
//  LKBasedataAPI.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/19.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKBasedataAPI.h"
#import "LKRequestParamters.h"
#import "LKDataProcessing.h"

@implementation LKBasedataAPI

//获取当前城市的地区信息
+ (void)findLocationSuccess:(void(^)(id responseObject))success
                      failure:(void(^)(id error))failure
{
    //获取地区信息参数字典
    NSMutableDictionary *params = [LKRequestParamters locationParamters];
    
    //取出带有签名信息的url
    NSString *signUrl = params[@"sign"];
    
    //用AFN发送网络请求
    [[AFHTTPSessionManager manager] GET:signUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //成功后返回数据
        if (success) {
            
            //数据处理
            NSMutableArray * array = [LKDataProcessing localWithArray:responseObject];
            
            //返回数据
            success(array);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //失败后返回失败原因
        if (failure) {
            failure(error);
        }
    }];
}

//获取可选类型
+ (void)findCategorySuccess:(void(^)(id responseObject))success
                    failure:(void(^)(id error))failure
{
    //获取地区信息参数字典
    NSMutableDictionary *params = [LKRequestParamters categoryParamters];
    
    //取出带有签名信息的url
    NSString *signUrl = params[@"sign"];
    
    //用AFN发送网络请求
    [[AFHTTPSessionManager manager] GET:signUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //成功后返回数据
        if (success) {
            
            //数据处理
            NSMutableArray * array = [LKDataProcessing categoryWithArray:responseObject];
            
            //返回数据
            success(array);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //失败后返回失败原因
        if (failure) {
            failure(error);
        }
    }];
}

//获取可选城市
+ (void)findCitySuccess:(void(^)(id responseObject))success
                    failure:(void(^)(id error))failure
{
    //获取城市参数字典
    NSMutableDictionary *params = [LKRequestParamters cityParamters];
    
    //取出带有签名信息的url
    NSString *signUrl = params[@"sign"];
    
    //用AFN发送网络请求
    [[AFHTTPSessionManager manager] GET:signUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //成功后返回数据
        if (success) {
            
            //数据处理
//            NSMutableArray * array = [LKDataProcessing localWithArray:responseObject];
            
            //返回数据
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //失败后返回失败原因
        if (failure) {
            failure(error);
        }
    }];
}

//获取美食商户
+ (void)findDelicacyStoreWithParamter:(NSMutableDictionary *)params
                              Success:(void(^)(id responseObject))success
                              Failure:(void(^)(id error))failure
{
    if (!params) {
        params = [NSMutableDictionary dictionary];
    }
    //获取城市参数字典
    params = [LKRequestParamters delicacyStoreParamtersWithParams:params];
    
    //取出带有签名信息的url
    NSString *signUrl = params[@"sign"];
    
    //用AFN发送网络请求
    [[AFHTTPSessionManager manager] GET:signUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //成功后返回数据
        if (success) {
            
            //数据处理
            NSMutableArray * array = [LKDataProcessing storeWithArray:responseObject];
            
            //返回数据
            success(array);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //失败后返回失败原因
        if (failure) {
            failure(error);
        }
    }];
}

//- (void) findBusiness:(NSMutableDictionary *)params  success:success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull)) failure isReload:(BOOL) isReload
//{
//    NSString *baseURL = @"http://api.dianping.com/v1/business/find_businesses";
//    id cache = [nsfile read:path key:'busi']
//    if (cache && !isReload) {
//        return success(cache)
//    }else {
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        params[@"category"] = @"美食";
//        params[@"city"] = @"北京";
//        //不传则为1：默认
//        params[@"sort"] = @(1);
//        //默认为20条/页
//        params[@"limit"] = @(20);
//        //默认为1，传回网页；2为传回Html5
//        params[@"platform"] = @(2);
//        
//        NSString *url = [LINKEncryption serializeURL:baseURL params:params];
//        params[@"sign"] = url;
//        [[AFHTTPSessionManager manager] GET:@"http://api.dianping.com/v1/business/find_businesses" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
//            
//            
//        } success:success failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            //处理错误
//           cache = reuslt
//            success(cache)
//            failure(error)
//        }];
//        
//    }
//    
//    [[AFHTTPSessionManager manager] GET:@"http://api.dianping.com/v1/business/find_businesses" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        
//    }];
//
//}

@end
