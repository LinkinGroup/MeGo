//
//  LKNetWorkReloadView.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/19.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKNetWorkReloadView.h"

@implementation LKNetWorkReloadView

- (instancetype)init
{
    if (self = [super init]) {
        
        LKNetWorkReloadView *view = [[LKNetWorkReloadView alloc] initWithFrame:(CGRectMake(0, 0, LKScreenSize.width, LKScreenSize.height))];
        view.backgroundColor = JKGlobalBg;
        
        UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(0, 180, LKScreenSize.width, 100))];
        label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
        label.text = @"网络连接失败  点击重新加载";
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"Retry"]];
        img.frame = CGRectMake(0, 0, 68, 68);
        img.centerX = LKScreenSize.width / 2;
        img.centerY = 100;
        
        [view addSubview:label];
        [view addSubview:img];
//        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReload)];
//        [view addGestureRecognizer:tap];
        self = view;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if ([_delegate respondsToSelector:@selector(tapReloadView:)]) {
        
        [_delegate tapReloadView:self];
    }
}

//- (void)tapReload
//{
//    JKLog(@"123");
//    if ([_delegate respondsToSelector:@selector(tapReloadView:)]) {
//        
//        [_delegate tapReloadView:self];
//    }
//}

@end
