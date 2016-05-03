//
//  LKRequestParamters.h
//  MeGo
//
//  Created by 郑博辰 on 16/4/25.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKRequestParamters : NSObject

/**
 * 根据请求的URL和参数来返回相应的签名文件
 */
+ (NSMutableDictionary *)paramtersWithBaseUrl:(NSString *)baseUrl paramters:(NSMutableDictionary *)params;


/**
 * 获取当前城市的地区信息
 */
+ (NSMutableDictionary *)locationParamters;

/**
 * 获取可选城市
 */
+ (NSMutableDictionary *)cityParamters;

/**
 * 获取美食商户
 */
+ (NSMutableDictionary *)delicacyStoreParamtersWithParams:(NSMutableDictionary *)params;
@end
