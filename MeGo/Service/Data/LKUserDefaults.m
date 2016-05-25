//
//  LKUserDefaults.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/24.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKUserDefaults.h"

@implementation LKUserDefaults

// 将定位信息转为数组，写入缓存
+ (void)saveLocation:(CLLocation *)location
{
    NSArray *locationArray = [[NSArray alloc] initWithObjects:@(location.coordinate.latitude), @(location.coordinate.longitude), nil];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:locationArray forKey:JKLocation];
}

@end
