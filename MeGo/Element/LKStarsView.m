//
//  LKStarsView.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/30.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKStarsView.h"


static CGFloat _starX = 0;

@implementation LKStarsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    // 如果以后想绘制东西到view上面，必须在drawRect方法里面，不管有没有手动获取到上下文
    
    // 修改雪花y值
    UIImage *image =  [UIImage imageNamed:@"star"];
    
    [image drawAtPoint:CGPointMake(_starX,0 )];
    
    _starX += 10;
    
    if (_starX > rect.size.width) {
        _starX = 0;
    }
    
}

// 如果在绘图的时候需要用到定时器，通常

// NSTimer很少用于绘图，因为调度优先级比较低，并不会准时调用
- (void)awakeFromNib
{
    // 创建定时器
    //    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeChange)];
    
    // 添加主运行循环
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

// CADisplayLink:每次屏幕刷新的时候就会调用，屏幕一般一秒刷新60次

// 1秒 2次
static int count = 0;
- (void)timeChange
{
    //    count++;
    //    if (count % 30) {// 一秒钟调用2次
    //
    //    }
    
    
    // 注意：这个方法并不会马上调用drawRect,其实这个方法只是给当前控件添加刷新的标记，等下一次屏幕刷新的时候才会调用drawRect
    [self setNeedsDisplay];
    
//    
//    CABasicAnimation[
//                     CAAnimation
//                     }
}

@end
