//
//  LKCollectionFooterView.m
//  TestTest
//
//  Created by 郑博辰 on 16/6/8.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKCollectionFooterView.h"
#import "UIView+LINKExtension.h"

@implementation LKCollectionFooterView

- (void)drawRect:(CGRect)rect
{
    
    [super drawRect:rect];
    
    UIView *view = [[UIView alloc] initWithFrame:(CGRectMake(0, self.height -0.5, self.width+100, 0.5))];
    
    view.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview:view];
    
}

@end
