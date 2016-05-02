//
//  LINKGroupSaleViewController.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/19.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKGroupSaleViewController.h"
#import "LKToolBar.h"

@interface LKGroupSaleViewController ()

@end

@implementation LKGroupSaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpToolBar];

}

- (void)setUpToolBar
{
    
    
    LKToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LKToolBar class]) owner:nil options:nil].firstObject;
    
    toolBar.frame = CGRectMake(0, 100, LKScreenSize.width, 57);
//    toolBar.center = CGPointMake(0, 100);
    
    [self.view addSubview:toolBar];
}


@end
