//
//  LINKTabbarController.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/19.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKTabbarController.h"
#import "LKIndexViewController.h"
#import "LKGroupSaleViewController.h"
#import "LKNavigationController.h"

@interface LKTabbarController ()

@end

@implementation LKTabbarController

//在初始化时设置tabbar上的按钮颜色
+ (void)initialize
{
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    titleAttr[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedtitleAttr = [NSMutableDictionary dictionary];
    selectedtitleAttr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:12];
    selectedtitleAttr[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:titleAttr forState:(UIControlStateNormal)];
    [item setTitleTextAttributes:selectedtitleAttr forState:(UIControlStateSelected)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置tabBar的背景图片
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];

    //主页按钮
    [self setUpBarButton:[[LKIndexViewController alloc] init] image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon" title:@"首页"];
    
    //团购页面按钮
    [self setUpBarButton:[[LKGroupSaleViewController alloc] init] image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon" title:@"团购"];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
