//
//  LKNetWorkReloadView.h
//  MeGo
//
//  Created by 郑博辰 on 16/5/19.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LKNetWorkReloadView;

@protocol LKNetWorkReloadViewDelegate <NSObject>

- (void)tapReloadView:(LKNetWorkReloadView *)reloadView;

@end

@interface LKNetWorkReloadView : UIView

/** 代理属性*/
@property (weak, nonatomic) id<LKNetWorkReloadViewDelegate> delegate;

@end
