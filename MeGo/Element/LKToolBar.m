//
//  LKToolBar.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/29.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKToolBar.h"

@implementation LKToolBar

- (void)awakeFromNib
{
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
}

@end
