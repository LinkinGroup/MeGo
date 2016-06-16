//
//  LKSharingMegoView.m
//  MeGo
//
//  Created by 郑博辰 on 16/6/16.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKSharingMegoView.h"
#import "LKCircularBtn.h"
#import "LKDelicacyStoreModel.h"
#import "WXApi.h"

typedef enum {
    
    SharingWithWeChat   = 1 << 0,   // 1
    
    SharingWithCircle   = 2 << 1,   // 2
    
    SharingWithCopyHttp = 2 << 2,   // 4
    
}Sharing;

@interface LKSharingMegoView ()<WXApiDelegate>

/** flagView*/
@property (nonatomic, strong) UILabel *flag;

/** weChatLogo*/
@property (nonatomic, strong) UIButton *weChatLogo;

/** cricleLogo*/
@property (nonatomic, strong) UIButton *friendsLogo;

/** copyLogo*/
@property (nonatomic, strong) UIButton *duplicateLogo;

/** 模型*/
@property (nonatomic, strong) LKDelicacyStoreModel *store;

@end

@implementation LKSharingMegoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self setUpViews];
    
    return self;
}

#pragma mark - 动画及控件设置
- (void)setUpViews
{
    CGFloat margin = LKScreenSize.width *2/5/4;
    
    // labelView
    UILabel *flag = [[UILabel alloc] initWithFrame:(CGRectMake(-100, LKScreenSize.height *0.6, 100, 50))];
    flag.textAlignment = NSTextAlignmentCenter;
    flag.text = @"分享至：";
    flag.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
    flag.textColor = [UIColor orangeColor];
    [self addSubview:flag];
    _flag = flag;
    
    // 微信LOGO
    LKCircularBtn *btn = [[LKCircularBtn alloc] initWithFrame:(CGRectMake(margin, LKScreenSize.height, LKScreenSize.width /5, LKScreenSize.width /5 +21))];
    [btn setImage:[UIImage imageNamed:@"icon64_appwx_logo"] forState:(UIControlStateNormal)];
    [btn setTitle:@"微信" forState:(UIControlStateNormal)];
    btn.titleLabel.hidden = YES;
    [self addSubview:btn];
    _weChatLogo = btn;
    
    // 微信朋友圈LOGO
    LKCircularBtn *btn2 = [[LKCircularBtn alloc] initWithFrame:(CGRectMake(margin *2 +LKScreenSize.width /5, LKScreenSize.height, LKScreenSize.width /5, LKScreenSize.width /5 +21))];
    [btn2 setImage:[UIImage imageNamed:@"icon_res_download_moments"] forState:(UIControlStateNormal)];
    [btn2 setTitle:@"微信朋友圈" forState:(UIControlStateNormal)];
    btn2.titleLabel.hidden = YES;
    [self addSubview:btn2];
    _friendsLogo = btn2;
    
    // 复制链接LOGO
    LKCircularBtn *btn3 = [[LKCircularBtn alloc] initWithFrame:(CGRectMake(margin *3 +LKScreenSize.width *2/5, LKScreenSize.height, LKScreenSize.width /5, LKScreenSize.width /5 +21))];
    [btn3 setImage:[UIImage imageNamed:@"copy"] forState:(UIControlStateNormal)];
    [btn3 setTitle:@"复制链接" forState:(UIControlStateNormal)];
    btn3.titleLabel.hidden = YES;
    [self addSubview:btn3];
    _duplicateLogo = btn3;
    
    // 点击设置
    btn.tag = SharingWithWeChat;
    btn2.tag = SharingWithCircle;
    btn3.tag = SharingWithCopyHttp;
    
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn2 addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn3 addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 设置
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:6 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        
        flag.x = 0;
        
        btn.y = LKScreenSize.height *0.7;
        
        btn2.y = LKScreenSize.height *0.7;
        
        btn3.y = LKScreenSize.height *0.7;
        
    } completion:^(BOOL finished) {
        
        btn.titleLabel.hidden = NO;
        
        btn2.titleLabel.hidden = NO;
        
        btn3.titleLabel.hidden = NO;
        
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissFromSuperView];
}

- (void)dismissFromSuperView
{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.backgroundColor = [UIColor clearColor];
        
        _flag.x = -100;
        
        _weChatLogo.x = - LKScreenSize.width/4;
        _weChatLogo.titleLabel.hidden = YES;
        
        _friendsLogo.y = - LKScreenSize.width /4;
        _friendsLogo.titleLabel.hidden = YES;
        _friendsLogo.transform = CGAffineTransformRotate(_friendsLogo.transform,M_PI_2*2 -1);
        
        _duplicateLogo.x = LKScreenSize.width;
        _duplicateLogo.titleLabel.hidden = YES;
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self removeFromSuperview];
        
    });
}

- (void)clickBtn:(LKCircularBtn *)sender
{
    NSInteger tag = sender.tag;
    int scene = 0;
    
    switch (tag) {
            
        case SharingWithWeChat:
            
            scene = WXSceneSession;
            
            [self shareWithType:scene];
            
            break;
            
        case SharingWithCircle:
            
            scene = WXSceneTimeline;
            
            [self shareWithType:scene];
            
            break;
            
        case SharingWithCopyHttp:{
            
            UIPasteboard *pb = [UIPasteboard generalPasteboard];
            
            pb.string = @"itms-apps://itunes.apple.com/cn/app/id1120321577?mt=8";
            
            [self dismissFromSuperView];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithFrame:(CGRectMake(0, 0, 100, 60))];
            alert.message = @"复制成功";
            [alert show];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alert dismissWithClickedButtonIndex:0 animated:YES];
            });

            
            break;}
            
        default:
            break;
    }
}

// 分享
- (void)shareWithType:(int)scene
{
    // 定义消息
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@"MeGoLogo"]];
    WXWebpageObject *web = [WXWebpageObject object];
    web.webpageUrl = @"https://itunes.apple.com/cn/app/id1120321577?mt=8";
    message.mediaObject = web;
    message.title = @"推荐一个生活类应用~";
    message.description = [NSString stringWithFormat:@"随时随地查找身边的优质商户~"];
    
    // 发送请求
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText   = NO;
    req.message = message;
    req.scene   = scene;
    
    [WXApi sendReq:req];
    
    [self dismissFromSuperView];
}


@end
