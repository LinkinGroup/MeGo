//
//  LKTmpManage.h
//  MeGo
//
//  Created by 郑博辰 on 16/5/23.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKTmpManage : NSObject

/** 查看缓存*/
+ (float)checkTmpSize;

/** 清除缓存*/
+ (void)clearTmpPics;

/** 清除全部缓存*/
+ (void)clearAllTmp;

@end
