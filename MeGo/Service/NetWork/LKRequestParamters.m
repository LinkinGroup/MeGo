//
//  LKRequestParamters.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/25.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKRequestParamters.h"
#import "LKEncryption.h"
#import <CoreLocation/CoreLocation.h>
#import "LKUserDefaults.h"

@interface LKRequestParamters ()<CLLocationManagerDelegate>

/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *locationManager;

/** 保存最新的位置信息*/
@property (nonatomic, strong) CLLocation *currentLocation;


@end

@implementation LKRequestParamters

#pragma mark - 公共参数
+ (NSMutableDictionary *)paramtersWithBaseUrl:(NSString *)baseUrl paramters:(NSMutableDictionary *)params
{
    
    NSString *signUrl = [LKEncryption serializeURL:baseUrl params:params];
    
    params[@"sign"] = signUrl;
    
    return params;
}

#pragma mark - 业务参数
// 获取当前城市的地区信息
+ (NSMutableDictionary *)locationParamters
{
    NSString *url = @"http://api.dianping.com/v1/metadata/get_regions_with_businesses";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 关键参数
    params[@"city"] = [[NSUserDefaults standardUserDefaults] objectForKey:JKCity];
    
    // 获取参数
    params = [self  paramtersWithBaseUrl:url paramters:params];
    
    return params;
}

// 获取可选类型
+ (NSMutableDictionary *)categoryParamters
{
    NSString *url = @"http://api.dianping.com/v1/metadata/get_categories_with_businesses";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 关键参数
    params[@"city"] = [[NSUserDefaults standardUserDefaults] objectForKey:JKCity];
    
    // 获取参数
    params = [self  paramtersWithBaseUrl:url paramters:params];
    
    return params;
}

// 获取可选城市
+ (NSMutableDictionary *)cityParamters
{
    // 支持点评业务的地市API：@"http://api.dianping.com/v1/metadata/get_cities_with_businesses"
    
    // 支持团购业务的地市，API： http://api.dianping.com/v1/metadata/get_cities_with_deals
    
    NSString *url = @"http://api.dianping.com/v1/metadata/get_cities_with_deals";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 获取参数
    params = [self  paramtersWithBaseUrl:url paramters:params];
    
    return params;
}

// 获取美食商户
+ (NSMutableDictionary *)delicacyStoreParamtersWithParams:(NSMutableDictionary *)params
{
    NSString *url = @"http://api.dianping.com/v1/business/find_businesses";
    
    // 关键参数
    // 判断是否为GPRS定位城市
    NSString *GPRSCity = [LKUserDefaults objectForKey:JKCurrentCity];
    NSString *selectedCity = [LKUserDefaults objectForKey:JKCity];
    
    if ([GPRSCity isEqualToString:selectedCity]) {
         // 所选城市是GPRS定位城市：
        params[@"city"] = GPRSCity;
        
    }else if (!selectedCity){
        // 未选择城市时会进入这里
        params[@"city"] = GPRSCity;
        
//    }else if (!GPRSCity){
        

    }else {
        // 所选城市不是GPRS定位城市：
        params[@"city"] = selectedCity;
        params[@"latitude"] = nil;
        params[@"longitude"] = nil;
    }
    
    // 获取参数
    params = [self paramtersWithBaseUrl:url paramters:params];
    
    return params;
}

@end
