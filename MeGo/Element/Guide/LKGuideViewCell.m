//
//  LKGuideViewCell.m
//  MeGo
//
//  Created by 郑博辰 on 16/6/1.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKGuideViewCell.h"
#import "LKTabbarController.h"

@interface LKGuideViewCell ()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, strong) UIButton *startButton;

@end

@implementation LKGuideViewCell

- (UIButton *)startButton
{
    if (_startButton == nil) {
        
        // 如果使用苹果提供的类方法创建对象，苹果会帮我们管理
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_startButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        
        [_startButton sizeToFit];
        
        [_startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        
        _startButton.center = CGPointMake(self.width * 0.5, self.height * 0.81);
        
        [self.contentView addSubview:_startButton];
    }
    return _startButton;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.bounds];
        
        _imageView = imageV;
        
        [self.contentView addSubview:imageV];
    }
    
    return _imageView;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}

- (void)setUpIndexPath:(NSIndexPath *)indexPath count:(NSInteger)pagesCount
{
    if (indexPath.row == pagesCount - 1) {
        // 最后一行
        // 添加立即体验按钮
        self.startButton.hidden = NO;
    }else{
        self.startButton.hidden = YES;
    }
    
}

// 点击立即体验按钮
- (void)start
{
    // 跳转到核心界面,push,modal,切换跟控制器的方法
    [UIApplication sharedApplication].keyWindow.rootViewController = [[LKTabbarController alloc] init];
    JKLog(@"come");

    CATransition *anim = [CATransition animation];
    anim.duration = 0.5;
    anim.type = @"rippleffect";
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];
}

@end
