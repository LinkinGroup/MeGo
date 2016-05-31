//
//  LKCacheManage.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/28.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKCacheManage.h"
#import "SDImageCache.h"
#import "NSDate+LINKExtension.h"

@implementation LKCacheManage

// 查看缓存大小
+ (float)checkCacheSize {
    
    float totalSize = 0;
    
    //    NSString *diskCachePath = NSTemporaryDirectory();
    
    NSArray *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *diskCachePath = [cache objectAtIndex:0];
    
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:diskCachePath];
    
    for (NSString *fileName in fileEnumerator) {
        
        NSString *filePath = [diskCachePath stringByAppendingPathComponent:fileName];
        
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        
        unsigned long long length = [attrs fileSize];
        
        totalSize += length / 1024.0 / 1024.0;
    } // NSLog(@"tmp size is %.2f",totalSize); return totalSize;
    return totalSize;
}

// 清除缓存
+ (void)clearPics
{
    [[SDImageCache sharedImageCache] clearDisk];
    
    //    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

// 清除全部缓存（Cache）
+ (void)clearAllCache
{
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    
    for (NSString *p in files) {
        
        NSError *error;
        
        NSString *path = [cachPath stringByAppendingPathComponent:p];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
}

// 标记时间
+ (void)markTheTimeToKey:(NSString *)key
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [fmt setTimeZone:timeZone];
    
    // 当前时间：
    NSString *time = [fmt stringFromDate:[NSDate date]];
    JKLog(@"%@",time);
    NSDate *timeNow = [fmt dateFromString:time];
    
    // 存入缓存
    // 获取cache
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    // 获取文件的全路径
    NSString *filePath = [cachePath stringByAppendingPathComponent:key];
    
    // 把自定义对象归档
    [NSKeyedArchiver archiveRootObject:timeNow toFile:filePath];

}

// 查看时间戳
+ (NSInteger)checkCalendarByHourWithKey:(NSString *)key
{
    // 获取cache
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    NSString *filePath = [cachePath stringByAppendingPathComponent:key];
    NSDate *timeNow = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    // 计算时间方法2
    NSTimeInterval interval = -[timeNow timeIntervalSinceNow] / 60 / 60;
    
    return interval;
        JKLog(@"%f",interval);
}

@end
