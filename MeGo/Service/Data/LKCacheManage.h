//
//  LKCacheManage.h
//  MeGo
//
//  Created by 郑博辰 on 16/5/28.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKCacheManage : NSObject

/** 查看缓存*/
+ (float)checkCacheSize;

/** 清除缓存*/
+ (void)clearPics;

/** 清除全部缓存*/
+ (void)clearAllCache;

/** 标记时间*/
+ (void)markTheTimeToKey:(NSString *)key;

/** 查看时间戳*/
+ (NSInteger)checkCalendarByDayWithKey:(NSString *)key;

@end
