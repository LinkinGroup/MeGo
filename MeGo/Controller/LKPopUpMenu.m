//
//  LKPopUpMenu.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/27.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKPopUpMenu.h"
#import "LKLocalViewController.h"

@implementation LKPopUpMenu

#pragma mark - 初始化操作
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    
    return self;
}

- (void)setUp
{
    //设置背影颜色
//    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    self.backgroundColor = [UIColor clearColor];
    
}

//移除菜单
+ (void)removeView:(UIView *)view
{
    [UIView animateWithDuration:0.3 animations:^{
        
        view.frame = CGRectMake(0, - LKScreenSize.height  *0.7, LKScreenSize.width, LKScreenSize.height  *0.7);
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [view removeFromSuperview];
    });

}

//点击空白处，移除菜单
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [LKPopUpMenu removeView:self];
    
}

#pragma mark - 创建二级联动菜单

+ (void)menuWithLinkageMenuInController:(UIViewController *)viewController completion:(void(^)())completion
{
    //创建表格
    LKLocalViewController *vc = [[LKLocalViewController alloc] init];
    
    [viewController addChildViewController:vc];
    
    vc.view.frame = CGRectMake(0, - LKScreenSize.height *0.7, LKScreenSize.width, LKScreenSize.height *0.7);
    
    
    //创建菜单
    LKPopUpMenu *menu = [[self alloc] init];
    
    menu.frame = CGRectMake(0, 44, LKScreenSize.width, LKScreenSize.height);
    
//    [viewController.view addSubview:menu];
    [viewController.view insertSubview:menu atIndex:1];
    
    [menu addSubview:vc.view];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        vc.view.frame = CGRectMake(0, 60, LKScreenSize.width, LKScreenSize.height *0.7);
        
    }];
    completion();

}

- (void)menuWithLinkageMenuInController:(UIViewController *)viewController completion:(void(^)())completion
{
    [LKPopUpMenu menuWithLinkageMenuInController:viewController completion:(void(^)())completion];
}

#pragma mark - 移除菜单

+ (void)dismissInViewController:(UIViewController *)viewController completion:(void(^)())completion
{
    for (UIView *view in viewController.view.subviews) {
        if ([view isKindOfClass:[LKPopUpMenu class]]) {
            
             [LKPopUpMenu removeView:view];
        }
    }
    completion();
}




@end
