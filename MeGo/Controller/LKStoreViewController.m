//
//  LKStoreViewController.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/21.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKStoreViewController.h"
#import "LKBasedataAPI.h"
#import "LKStoreModel.h"
#import "MJExtension.h"
#import "LKLocalViewController.h"

@interface LKStoreViewController ()

/** 帖子数据 */
@property (nonatomic, strong) NSMutableArray *cities;

@end

@implementation LKStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    btn.frame = CGRectMake(150, 150, 99, 600);
    
    [self.view addSubview:btn];
    
    btn.backgroundColor = [UIColor redColor];
    
    [btn addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)click
{
    LKLocalViewController *vc = [[LKLocalViewController alloc] init];
 
    UIView *view = [[UIView alloc]initWithFrame:(CGRectMake(0, 64, LKScreenSize.width, LKScreenSize.height))];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    [self.view addSubview:view];
    
    [self addChildViewController:vc];
    
    vc.view.frame = CGRectMake(0, -600, LKScreenSize.width, LKScreenSize.height *0.6);
    
    [view addSubview:vc.view];
    
    [UIView animateWithDuration:2 animations:^{
        
        vc.view.frame = CGRectMake(0, 60, LKScreenSize.width, LKScreenSize.height *0.6);
        
    }];

    
/////    [self.navigationController  pushViewController:vc animated:YES];
//    [self.view.layer addAnimation:animation forKey:nil];
////    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
    vc.view.frame = CGRectMake(0, -600, LKScreenSize.width, LKScreenSize.height *0.6);
    
    [self.view addSubview:vc.view];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        vc.view.frame = CGRectMake(0, 60, LKScreenSize.width, LKScreenSize.height *0.6);

        
    }];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
