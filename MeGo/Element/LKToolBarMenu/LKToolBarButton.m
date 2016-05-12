//
//  LKToolBarButton.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/4.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKToolBarButton.h"

@implementation LKToolBarButton

- (instancetype)initWithTitles:(NSArray *)titles
{
    if (self = [super initWithFrame:(CGRectMake(0, 64, LKScreenSize.width, 44))]) {
        //获得按钮数量
        _count = titles.count;
        
        //没有按钮被点击
        _isButton = NO;
        
        //添加按钮
        [self addButtonWithTitles:titles];
        
    }
    return self;
}

#pragma mark - 布局按钮和分割线
//布局按钮和分割线
- (void)addButtonWithTitles:(NSArray *)titles
{
    for (int i = 0; i < _count; i++) {
        
        //添加按钮到自己的透明view上
         UIButton *btn = [self makeButtonWithTitles:titles[i] andIndex:i];
        [self addSubview:btn];
        
        if (i > 0) {
            
            //添加分隔线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(btn.frame.origin.x, 10, 1, 24)];
            
            lineView.backgroundColor = [UIColor colorWithRed:(217.0 / 255.0) green:(217.0 / 255.0) blue:(217.0 / 255.0) alpha:1.0f];
            
            [self addSubview:lineView];
        }
    }
    //添加底部分隔线
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 44, LKScreenSize.width, 1)];
    bottomLine.backgroundColor = [UIColor colorWithRed:(217.0 / 255.0) green:(217.0 / 255.0) blue:(217.0 / 255.0) alpha:1.0f];
    
    [self addSubview:bottomLine];
}

//按钮创建
- (UIButton *)makeButtonWithTitles:(NSString *)title andIndex:(int)index
{
    CGFloat width = LKScreenSize.width / _count;
    
    CGFloat x = index * width;
    
    NSInteger height = 44;
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    btn.frame = CGRectMake(x, 0, width, height);
    
    [btn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Semibold" size:14]];
    
    [btn setTitle:title forState:(UIControlStateNormal)];
    
    _image = [UIImage imageNamed:@"Arrow_Down"];
    
    [btn setImage:_image forState:(UIControlStateNormal)];
    
    btn.tag = 10000 + index;
    
    // 为预估文本尺寸，创建富文本字典
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    attributes[@"NSFontAttributeName"] = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
    
#warning 关键属性
    // 图片内置尺寸设置
    // [title sizeWithAttributes:attributes].width) 设为恒定的24，以免四字标题的位置不自然；
    CGFloat padding = (width - (13 + 24)) / 2;

//    CGFloat padding = (width - (13 + [title sizeWithAttributes:attributes].width)) / 2;

    [btn setImageEdgeInsets:UIEdgeInsetsMake(15, 24 + padding + 15, 15, 0)];
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(15, -15, 15, 15)];
//    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    
#warning 颜色
    // 设置按钮的背景颜色
    [btn setBackgroundColor:[UIColor whiteColor]];
    
    // JKRGBColor(151, 151, 151)
    // [UIColor darkGrayColor]
    [btn setTitleColor:[UIColor colorWithWhite:0.45 alpha:1] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(showMenuAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

//点击按钮后，传入按钮的标签
- (void)showMenuAction:(id)sender
{
    NSInteger i = [sender tag];
    
    [self openMenuBtnAnimation:i];
}

//根据标签做出判断，
- (void)openMenuBtnAnimation:(NSInteger)index{
    
    //当前按钮不是最后一次点击时的按钮，或者为第一次点击的按钮
    if (_lastTap != index) {
        
        //判断：若_lastTap有值，说明最后一次点击的按钮不是此按钮
        if (_lastTap > 0) {
            
            //将之前点击的按钮归位
            [self changeButtionWithTag:_lastTap Rotation:0];
        }
        
        //记录最后一次点击的按钮是哪个
        _lastTap = index;
        
        //旋转当前按钮的箭头
        [self changeButtionWithTag:index Rotation:M_PI];
        
        //通知代理，弹出菜单
        [self.delegate showMenu:index];
        
    } else {
        
        //当前按钮是最后一次点击时的按钮；
        _isButton = NO;
        
        //按钮归位
        [self changeButtionWithTag:_lastTap Rotation:0];
        
        //将按钮状态记为：没有被点击的按钮。
        _lastTap = 0;
        
        //通知代理，隐藏菜单
        [self.delegate hideMenu];
    }
}

//改变当前按钮的箭头指向
- (void)changeButtionWithTag:(NSInteger)index Rotation:(CGFloat)angle
{
    [UIView animateWithDuration:0.1f animations:^{
        
        
        //获取当前按钮
        UIButton *btn = (UIButton *)[self viewWithTag:index];
        
        if (angle == 0) {
            
            _image = [UIImage imageNamed:@"Arrow_Down"];

            //判断：当角度为0时，说明按钮为非选中状态；
            [btn setBackgroundColor:[UIColor whiteColor]];
            
        } else {
            
            _image = [UIImage imageNamed:@"navibar_icon_arrow_down-1"];
            
            //判断：当角度不为0时，说明按钮为选中状态。改变颜色，旋转角度
//            [btn setBackgroundColor:[UIColor colorWithRed:(221.0/255.0) green:(221.0/255.0) blue:(221.0/255.0) alpha:1.0f]];
        }
        
        [btn setImage:_image forState:(UIControlStateNormal)];
        
        btn.imageView.transform = CGAffineTransformMakeRotation(angle);
    }];
}

// 专门提供给Menu的方法，用来监听tableView的点击
- (void)hideMenuWithIndex:(NSString *)btnIndex
{
    
    //字符串等于点击的内容
    _lastTapObj = btnIndex;
    
    //若点击的不是按钮，则是cell
    if (_isButton != YES) {
        
        //点击的是cell, 让按钮归位
        [self changeButtionWithTag:([_lastTapObj intValue] + 10000) Rotation:0];
        
        //按钮被点击状态为否；
        _isButton = NO;
    }
    //将按钮状态记为：没有被点击的按钮。
    _lastTap = 0;
}

@end
