//
//  LINKHTTPSessionManager.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/19.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LINKHTTPSessionManager.h"
#import "LINKEncryption.h"

@implementation LINKHTTPSessionManager

- (void)findBusinesses
{
    NSString *baseURL = @"http://api.dianping.com/v1/business/find_businesses";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"category"] = @"美食";
    params[@"city"] = @"北京";
    //不传则为1：默认
    params[@"sort"] = @(1);
    //默认为20条/页
    params[@"limit"] = @(20);
    //默认为1，传回网页；2为传回Html5
    params[@"platform"] = @(2);
    
    NSString *url = [LINKEncryption serializeURL:baseURL params:params];
    
    params[@"sign"] = url;
    
    
    [[AFHTTPSessionManager manager] GET:@"http://api.dianping.com/v1/business/find_businesses" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];

}

@end
