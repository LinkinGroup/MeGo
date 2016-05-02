//
//  LKPopUpMenu.h
//  MeGo
//
//  Created by 郑博辰 on 16/4/27.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LKPopUpMenuDelegate <NSObject>

@optional

- (void)didTouchBlank;

@end

@interface LKPopUpMenu : UIView

@property (weak, nonatomic) id<LKPopUpMenuDelegate> delegate;


/**
 * 创建二级联动菜单
 */
+ (void)menuWithLinkageMenuInController:(UIViewController *)viewController completion:(void(^)())completion;

- (void)menuWithLinkageMenuInController:(UIViewController *)viewController completion:(void(^)())completion;

/**
 * 移除菜单
 */
+ (void)dismissInViewController:(UIViewController *)viewController completion:(void(^)())completion;

- (void)tapBlankCompletion:(void(^)())completion;


@end
