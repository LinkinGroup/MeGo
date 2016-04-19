//
//  LINKTabbarController.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/19.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LINKTabbarController.h"
#import "LINKIndexViewController.h"
#import "LINKGroupSaleViewController.h"

@interface LINKTabbarController ()

@end

@implementation LINKTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

    //主页按钮
    [self setUpBarButton:[[LINKIndexViewController alloc] init] image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    //团购页面按钮
    [self setUpBarButton:[[LINKGroupSaleViewController alloc] init] image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpBarButton:(UIViewController *)vc image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.title = @"主页";
    [vc.tabBarItem setImage:[UIImage imageNamed:image]];
    [vc.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImage]];
    [self addChildViewController:vc];
}

@end
