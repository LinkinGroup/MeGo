//
//  LINKEncryption.h
//  MeGo
//
//  Created by 郑博辰 on 16/4/19.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKEncryption : NSObject

+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params;

@end
