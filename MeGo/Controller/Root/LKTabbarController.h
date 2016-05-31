//
//  LINKTabbarController.h
//  MeGo
//
//  Created by 郑博辰 on 16/4/19.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKTabbarController : UITabBarController

/** 指示器*/
@property (nonatomic, strong) UIView *indicator;

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

@end
