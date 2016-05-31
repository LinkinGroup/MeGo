//
//  LKWebViewController.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/12.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKWebViewController.h"

@interface LKWebViewController ()

@end

@implementation LKWebViewController

- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setUpWebView];
    
    [self setUpNavigation];
}

- (void)setUpWebView
{
    self.webView.frame = LKScreenFrame;
    
    [self.view addSubview:self.webView];
}

- (void)setUpNavigation
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(backToIndexPage)];
    
    [item setImage:[UIImage imageNamed:@"yy_calendar_icon_previous"]];
    
    self.navigationItem.leftBarButtonItem = item;
    
    // 设置导航栏标题颜色和字体
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 200, 44))];
    titleLabel.text = self.title;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:22];
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
}

- (void)backToIndexPage
{
    
    //    [self.textField resignFirstResponder];
    CATransition *transion=[CATransition animation];
    //设置转场动画的类型
    transion.type=@"cube";
    //设置转场动画的方向
    transion.subtype=@"fromLeft";
    
    //把动画添加到某个view的图层上
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transion forKey:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
