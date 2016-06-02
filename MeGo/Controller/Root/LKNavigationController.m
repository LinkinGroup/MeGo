//
//  LKNavigationController.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/21.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKNavigationController.h"
#import "UIBarButtonItem+FlatUI.h"
#import <FlatUIKit.h>
#import "LKTabbarController.h"
#import "LKIndexViewController.h"

@interface LKNavigationController ()

@end

@implementation LKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

}

+ (void)initialize
{
//    UINavigationBar *bar = [UINavigationBar appearance];
////    bar.backgroundColor = [UIColor whiteColor];
//    [bar setBarTintColor:[UIColor whiteColor]];
//    [bar setTintColor:[UIColor darkGrayColor]];
//    
//    // setTranslucent 系统默认为yes，状态栏及导航栏底部是透明的，界面上的组件应该从屏幕顶部开始显示，因为是半透明的，可以看到，所以为了不和状态栏及导航栏重叠，第一个组件的y应该从44+20的位置算起；
//    // 而将setTranslucent设置为no时，则状态栏及导航样不为透明的，界面上的组件就是紧挨着导航栏显示了，所以就不需要让第一个组件在y方向偏离44+20的高度了。
//    [bar setTranslucent:NO];
//    
//    
////    bar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
//    
//    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
//    
//    // PingFangSC-Semibold
//    // Georgia-BoldItalic
//    // STHeitiJ-Medium
//    titleAttr[NSFontAttributeName] = [UIFont fontWithName:@"STHeitiJ-Medium" size:54];
//    titleAttr[NSForegroundColorAttributeName] = [UIColor grayColor];
//
//    [bar setTitleTextAttributes:titleAttr];
    
}

/**
 * 可以在这个方法中拦截所有push进来的控制器
 */
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [btn setTitle:@"返回" forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
    btn.size = CGSizeMake(81, 36);
    
    // 让按钮内部的所有内容左对齐
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //        [btn sizeToFit];
    // 让按钮的内容往左边偏移10
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    viewControllerToPresent.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

// tabbar的指示器需要隐藏
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    LKTabbarController *tabbarController = (LKTabbarController *)self.tabBarController;
    
    tabbarController.indicator.hidden = YES;

    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
