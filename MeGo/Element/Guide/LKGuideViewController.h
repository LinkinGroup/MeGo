//
//  LKGuideViewController.h
//  MeGo
//
//  Created by 郑博辰 on 16/6/1.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LKGuideViewDelegate <NSObject>

- (void)clickStarBtn;

@end

@interface LKGuideViewController : UICollectionViewController

/** 代理属性*/
@property (weak, nonatomic) id<LKGuideViewDelegate> delegate;

@end
