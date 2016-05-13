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

@interface LKNavigationController ()

@end

@implementation LKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

}

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.backgroundColor = [UIColor whiteColor];
    
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    
    // PingFangSC-Semibold
    // Georgia-BoldItalic
    // STHeitiJ-Medium
    titleAttr[NSFontAttributeName] = [UIFont fontWithName:@"STHeitiJ-Medium" size:18];
//    titleAttr[NSForegroundColorAttributeName] = [UIColor grayColor];

    [bar setTitleTextAttributes:titleAttr];
    
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


- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
