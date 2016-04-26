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

+ (NSMutableDictionary *)paramtersWithBaseUrl:(NSString *)baseUrl paramters:(NSMutableDictionary *)params
{
    
    //    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //
    //    params[@"city"] = @"北京";
    
    NSString *signUrl = [LKEncryption serializeURL:baseUrl params:params];
    
    params[@"sign"] = signUrl;
    
    return params;

}

@end
