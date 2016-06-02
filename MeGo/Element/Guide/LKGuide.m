//
//  LKGuide.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/31.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKGuide.h"
#import "LKTabbarController.h"
#import "LKUserDefaults.h"
#import "LKGuideViewController.h"

@implementation LKGuide

+ (UIViewController *)chooseRootViewController
{
    // 判断下有没有最新的版本号
    // 获取用户最新的版本号，info.plist
    NSString *curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 获取上一次的版本号 =》 先保存版本号 =》 偏好设置保存 =》每次进入新特性界面的时候表示有最新的版本号，这时候才需要保证
    
    // 获取上一次版本号
    NSString *oldVersion = [LKUserDefaults objectForKey:JKVersionKey];
    
    
    UIViewController *rootVc = nil;
    
//        if ([curVersion isEqualToString:oldVersion]) {
//            // 没有最新的版本号,进入核心界面
//            // 创建窗口跟控制器
//            // UITabBarController控制器的view不是懒加载，在创建控制器的时候就会加载。
//            rootVc = [[LKTabbarController alloc] init];
//    
//        }else{ // 有最新的版本号，进入新特性界面,保存当前的最新版本号
//    
//    
//            // CollectionViewVC必须在初始化的时候设置布局参数
//            rootVc = [[LKGuideViewController alloc] init];
//    
//            [LKUserDefaults setObject:curVersion forKey:JKVersionKey];
//        }
    rootVc = [[LKGuideViewController alloc] init];
    
    return rootVc;
}

@end
