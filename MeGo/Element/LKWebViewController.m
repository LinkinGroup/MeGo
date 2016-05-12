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
}

- (void)setUpWebView
{
    self.webView.frame = LKScreenFrame;
    
    [self.view addSubview:self.webView];
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}

@end
