//
//  LKTmpManage.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/23.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKTmpManage.h"
#import "SDImageCache.h"


@implementation LKTmpManage

// 查看缓存大小
+ (float)checkTmpSize {
    
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
+ (void)clearTmpPics
{
    [[SDImageCache sharedImageCache] clearDisk];
    
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

// 清除全部缓存
+ (void)clearAllTmp
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

@end
