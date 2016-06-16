//
//  LKWebViewController.h
//  MeGo
//
//  Created by 郑博辰 on 16/5/12.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKStoreViewController.h"

@protocol LKWebViewControllerDelegate <NSObject>

- (void)didclickShareBtnWithModel:(LKDelicacyStoreModel *)store;

@end

@interface LKWebViewController : UIViewController<LKStoreViewControllerDelegate>

@property (strong, nonatomic) UIWebView *webView;

/** 代理属性*/
@property (nonatomic, strong) id<LKWebViewControllerDelegate> delegate;


@end
