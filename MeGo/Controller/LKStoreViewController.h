//
//  LKStoreViewController.h
//  MeGo
//
//  Created by 郑博辰 on 16/4/21.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKIndexViewController.h"
#import "LKSearchingViewController.h"
#import "LKDelicacyStoreModel.h"

@protocol LKStoreViewControllerDelegate <NSObject>

- (void)pushWithStore:(LKDelicacyStoreModel *)store;

@end

@interface LKStoreViewController : UIViewController<LKIndexViewControllerDelegate, LKSearchingViewControllerDelegate>

/** 代理属性*/
@property (nonatomic, weak) id<LKStoreViewControllerDelegate> delegate;

@end
