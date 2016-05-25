//
//  LINKTabbarController.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/19.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKTabbarController.h"
#import "LKIndexViewController.h"
#import "LKSettingViewController.h"
#import "LKNavigationController.h"

@interface LKTabbarController ()

@end

@implementation LKTabbarController

//在初始化时设置tabbar上的按钮颜色
+ (void)initialize
{
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSFontAttributeName] = [UIFont fontWithName:@"PingFangSC-Semibold" size:10];
    titleAttr[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedtitleAttr = [NSMutableDictionary dictionary];
    selectedtitleAttr[NSFontAttributeName] = [UIFont fontWithName:@"PingFangSC-Semibold" size:10];
    selectedtitleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:titleAttr forState:(UIControlStateNormal)];
    [item setTitleTextAttributes:selectedtitleAttr forState:(UIControlStateSelected)];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 加载TabBar的初始化设置
    [self setUpTabBar];
}

// 初始化TabBar
- (void)setUpTabBar
{
    //设置tabBar的背景图片
//    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    [self.tabBar setBarTintColor:[UIColor whiteColor]];

    //主页按钮
    [self setUpBarButton:[[LKIndexViewController alloc] init] image:@"index" selectedImage:@"index_click" title:@"首 页"];
    
    //团购页面按钮
    [self setUpBarButton:[[LKSettingViewController alloc] init] image:@"setting" selectedImage:@"setting_click" title:@"设 置"];
}

- (void)setUpBarButton:(UIViewController *)vc image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    vc.title = title;
    [vc.tabBarItem setImage:[UIImage imageNamed:image]];
    [vc.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImage]];
    LKNavigationController *nvc = [[LKNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nvc];
    
}

@end
