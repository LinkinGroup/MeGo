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

@interface LKStoreViewController : UIViewController<LKIndexViewControllerDelegate, LKSearchingViewControllerDelegate>

/** 表格数据数组*/
@property (nonatomic, strong) NSMutableArray *stores;

@end
