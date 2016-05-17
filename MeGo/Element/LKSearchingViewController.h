//
//  LKSearchingViewController.h
//  MeGo
//
//  Created by 郑博辰 on 16/5/17.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LKSearchingViewControllerDelegate <NSObject>

@optional

- (void)searchingWithParams:(NSMutableDictionary *)params;

@end

@interface LKSearchingViewController : UITableViewController

/** 代理属性*/
@property (weak, nonatomic) id<LKSearchingViewControllerDelegate> delegate;

@end
