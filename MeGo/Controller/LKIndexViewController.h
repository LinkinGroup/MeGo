//
//  LINKIndexViewController.h
//  MeGo
//
//  Created by 郑博辰 on 16/4/19.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LKIndexViewController;

@protocol LKIndexViewControllerDelegate <NSObject>

@optional

/**
 * 点击首页中的按钮，传出模型；
 */
- (void)indexViewController:(LKIndexViewController *)viewController didClickBtnWithArray:(NSMutableArray *)stores;

@end

@interface LKIndexViewController : UIViewController

/** 代理属性*/
@property (weak, nonatomic) id<LKIndexViewControllerDelegate> delegate;

@end
