//
//  LKBasedataAPI.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/19.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKBasedataAPI.h"
#import "LKEncryption.h"

@implementation LKBasedataAPI

- (void)findBusinessesWithURL:(nullable NSString *)url params:(nullable NSMutableDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(id error))failure
{
    NSString *baseURL = url;
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    params[@"city"] = @"北京";
    
    NSString *signUrl = [LKEncryption serializeURL:baseURL params:params];
    
    params[@"sign"] = signUrl;
    
    
    [[AFHTTPSessionManager manager] GET:signUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
