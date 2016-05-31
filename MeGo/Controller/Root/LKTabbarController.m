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

@interface LKTabbarController ()<UITabBarControllerDelegate>

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
    
    [self setUpIndicator];
}

- (void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
{
    if (hidesBottomBarWhenPushed == YES) {
        self.indicator.hidden = YES;
    }else{
        self.indicator.hidden = NO;
        
        [self.view bringSubviewToFront:self.indicator];
    }
}

// 初始化TabBar
- (void)setUpTabBar
{
    self.tabBar.translucent = NO;
    
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
    vc.title = nil;
    [vc.tabBarItem setImage:[UIImage imageNamed:image]];
    [vc.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImage]];
    
    LKNavigationController *nvc = [[LKNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nvc];
}

#pragma mark - 指示器方法
- (void)setUpIndicator
{
    // 设置代理
    self.delegate = self;
    
    // 创建指示器
    NSInteger y = LKScreenSize.height -13;
    
    UIView *view = [[UIView alloc] initWithFrame:(CGRectMake(10, y, 30, 15))];
    view.backgroundColor = [UIColor orangeColor];
    view.layer.cornerRadius = 4;
    
    self.indicator = view;
    self.indicator.centerX = self.tabBar.centerX / 2;
    
    [self.view addSubview:view];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    CGFloat centerX = viewController.tabBarController.tabBar.centerX / 2;
    
    NSInteger factor = 0;
    
    if ([viewController.childViewControllers.firstObject isKindOfClass:[LKIndexViewController class]]) {

        factor = 0;
        
    }else{

        factor = 1;
    }
    
    CGFloat move = factor *centerX *2 * pow(-1, factor+1);
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:3 initialSpringVelocity:6 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        
        self.indicator.centerX = centerX + move;
    
    } completion:^(BOOL finished) {
        
    }];
}

@end
