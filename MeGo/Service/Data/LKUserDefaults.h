//
//  LKUserDefaults.h
//  MeGo
//
//  Created by 郑博辰 on 16/5/24.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LKUserDefaults : NSObject

/** 将定位信息转为数组，写入缓存*/
+ (void)saveLocation:(CLLocation *)location;

@end
