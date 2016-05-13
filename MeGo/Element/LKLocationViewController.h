//
//  LKLocationViewController.h
//  MeGo
//
//  Created by 郑博辰 on 16/5/13.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LKLocationViewControllerDelegate <NSObject>

@optional

- (void)didSelectedButtonWithCity:(NSString *)city;

@end


@interface LKLocationViewController : UITableViewController

/** 代理属性*/
@property (weak, nonatomic) id<LKLocationViewControllerDelegate> delegate;

@end
