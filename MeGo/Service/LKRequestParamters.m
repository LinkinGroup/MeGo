//
//  LKRequestParamters.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/25.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKRequestParamters.h"
#import "LKEncryption.h"

@implementation LKRequestParamters

#pragma mark - 公共参数
+ (NSMutableDictionary *)paramtersWithBaseUrl:(NSString *)baseUrl paramters:(NSMutableDictionary *)params
{
    
    NSString *signUrl = [LKEncryption serializeURL:baseUrl params:params];
    
    params[@"sign"] = signUrl;
    
    return params;

}

#pragma mark - 业务参数

//获取当前城市的地区信息
+ (NSMutableDictionary *)locationParamters
{
    NSString *url = @"http://api.dianping.com/v1/metadata/get_regions_with_businesses";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //关键参数
    params[@"city"] = @"北京";
    
    //获取参数
    params = [self paramtersWithBaseUrl:url paramters:params];
    
    return params;
}

//获取可选城市
+ (NSMutableDictionary *)cityParamters
{
    NSString *url = @"http://api.dianping.com/v1/metadata/get_cities_with_businesses";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //关键参数为空时，返回可选城市
    
    //获取参数
    params = [self paramtersWithBaseUrl:url paramters:params];
    
    return params;
}

//获取美食商户
+ (NSMutableDictionary *)delicacyStoreParamtersWithParams:(NSMutableDictionary *)params
{
    NSString *url = @"http://api.dianping.com/v1/business/find_businesses";
    
    //关键参数
    params[@"city"]     = @"北京";
    params[@"category"] = @"美食";
    
    //获取参数
    params = [self paramtersWithBaseUrl:url paramters:params];
    
    return params;
}

@end
