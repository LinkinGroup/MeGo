//
//  LKCircularBtn.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/20.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKCircularBtn.h"

@implementation LKCircularBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setUp];
    [super awakeFromNib];
}


- (void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
    
    [self setTitleColor: [UIColor grayColor] forState:(UIControlStateNormal)];
    //    self.userInteractionEnabled = NO;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height + 6;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

@end
