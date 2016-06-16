//
//  LKWebViewController.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/12.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKWebViewController.h"
#import "LKDelicacyStoreModel.h"
#import "LKSharingView.h"

@interface LKWebViewController ()

/** 模型*/
@property (nonatomic, strong) LKDelicacyStoreModel *store;


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
    
    self.webView.height -= 64;
    
    [self.view addSubview:self.webView];
}

- (void)setUpNavigation
{
    // 左侧按钮：
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(backToIndexPage)];
    
    [item setImage:[UIImage imageNamed:@"yy_calendar_icon_previous"]];
    
    self.navigationItem.leftBarButtonItem = item;
    
    // 右侧按钮：
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    [itemRight setImage:[UIImage imageNamed:@"export"]];

//    [itemRight setImage:[UIImage imageNamed:@"yy_calendar_icon_previous"]];
    
    self.navigationItem.rightBarButtonItem = itemRight;
    
    // 设置导航栏标题颜色和字体
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 200, 44))];
    titleLabel.text = self.title;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:22];
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
}

#pragma mark - 接收模型
- (void)pushWithStore:(LKDelicacyStoreModel *)store
{
    _store = store;
    JKLog(@"%@",_store);

}

#pragma mark - 导航栏按钮触发方法：
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

// 分享
- (void)share
{
    
    LKSharingView *sv = [[LKSharingView alloc] initWithFrame:(CGRectMake(0, 0, LKScreenSize.width, LKScreenSize.height))];
    [[UIApplication sharedApplication].keyWindow addSubview:sv];
    self.delegate = sv;
    
    if ([_delegate respondsToSelector:@selector(didclickShareBtnWithModel:)]) {
        [_delegate didclickShareBtnWithModel:self.store];
    }
    
}



@end
