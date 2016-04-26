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

@end
