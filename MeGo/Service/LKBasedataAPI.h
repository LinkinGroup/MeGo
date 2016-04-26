//
//  LKBasedataAPI.h
//  MeGo
//
//  Created by 郑博辰 on 16/4/19.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface LKBasedataAPI : NSObject

//+ (void)findBusinessesWithURL:(nullable NSString *)url params:(nullable NSMutableDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(id error))failure;
+ (void)findLocationSuccess:(nullable void(^)(id _Nullable responseObject))success
                    failure:(nullable void(^)(id _Nullable error))failure;

- (void) getShop:(NSMutableDictionary *)params  success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull)) failure;

- (void) getUserinfo:(NSMutableDictionary *)params  success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull)) failure;

@end
