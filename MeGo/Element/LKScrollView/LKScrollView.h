//
//  LKScrollView.h
//  MeGo
//
//  Created by 郑博辰 on 16/5/16.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LKScrollViewDelegate <NSObject>

@optional
- (void)didSelectedBtn:(UIButton *)sender;

@end

@interface LKScrollView : UIViewController

/** 代理属性*/
@property (nonatomic, weak) id<LKScrollViewDelegate> delegate;

/** 创建LKScrollView,并设定尺寸*/
- (instancetype)initWithScrollViewFrame:(CGRect)frame;

/** 创建LKScrollView,使用默认尺寸*/
- (instancetype)initWithScrollView;

@end
