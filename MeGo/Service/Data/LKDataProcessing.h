//
//  LKDataProcessing.h
//  MeGo
//
//  Created by 郑博辰 on 16/4/25.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKDataProcessing : NSObject

/** 地区数据转换*/
+ (NSMutableArray *)localWithArray:(NSDictionary *)dict;

/** 可选城市*/
+ (NSMutableArray *)cityWithArray:(NSDictionary *)dict;

/** 类型数据转换*/
+ (NSMutableArray *)categoryWithArray:(NSDictionary *)dict;

/** 商户数据转换*/
+ (NSMutableArray *)storeWithArray:(NSDictionary *)dict;

@end
