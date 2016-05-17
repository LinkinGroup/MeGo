//
//  LKScrollView.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/16.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKScrollView.h"
#import "LKCircularBtn.h"

@interface LKScrollView ()<UIScrollViewDelegate>

/** scrollView*/
@property (nonatomic, strong) UIScrollView *scrollView;

/** pageControl*/
@property (nonatomic, strong) UIPageControl *pageControl;

/** View1*/
@property (nonatomic, strong) UIView *viewOne;

/** View2*/
@property (nonatomic, strong) UIView *viewTwo;

/** View3*/
@property (nonatomic, strong) UIView *viewThree;

@end

@implementation LKScrollView

#pragma mark - 公有方法
// 创建LKScrollView,并设定尺寸
- (instancetype)initWithScrollViewFrame:(CGRect)frame
{
    if (self = [super init]) {
        
        self.view.frame = frame;
        
        [self setUpPageControlWithFrame:frame];
        
        [self setUpScrollViewWithFrame:frame];
        
        [self setUpViewWithFrame:frame];
    }
    return self;
}

// 创建LKScrollView,使用默认尺寸
- (instancetype)initWithScrollView
{
    if (self = [super init]) {
        
        CGRect frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width,240);
        
        self.view.frame = frame;
        
        [self setUpPageControlWithFrame:frame];
        
        [self setUpScrollViewWithFrame:frame];
        
        [self setUpViewWithFrame:frame];
    }
    return self;
}

#pragma mark - 初始化控件
// 初始化ScrollView
- (void)setUpScrollViewWithFrame:(CGRect)frame
{
    // 尺寸设置
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 10)];
    scrollView.contentSize = CGSizeMake(frame.size.width * 3, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;

    scrollView.pagingEnabled = YES;
//    self.scrollView.autoresizingMask = NO;
//    self.scrollView.autoresizesSubviews = NO;
    //    scrollView.bounces = NO;
    //    scrollView.decelerationRate = 5;
    //    scrollView.bouncesZoom = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.scrollView setContentOffset:(CGPointMake(frame.size.width, 0))];
}

// 初始化PageView
- (void)setUpViewWithFrame:(CGRect)frame
{
    // 尺寸设置
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height - 10;

    // 第一页初始化：
    self.viewOne = [[UIView alloc] initWithFrame:(CGRectMake(width, 0, width, height))];
    NSArray *pageOneArray = [[NSArray alloc] initWithObjects:@"美食", @"面包甜点", @"清真菜", @"冰淇淋", @"咖啡厅", @"综合商场", @"运动健身", @"便利店", nil];
    [self addBtnInView:self.viewOne andTitle:pageOneArray];
    
    // 第二页初始化：
    self.viewTwo = [[UIView alloc] initWithFrame:(CGRectMake(width * 2, 0, width, height))];
    NSArray *pageTwoArray = [[NSArray alloc] initWithObjects:@"电影院", @"KTV", @"密室", @"桌面游戏", @"私人影院", @"瑜伽", @"亲子游乐", @"酒店", nil];
    [self addBtnInView:self.viewTwo andTitle:pageTwoArray];

    // 第三页初始化：
    self.viewThree = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, width, height))];
    NSArray *pageThreeArray = [[NSArray alloc] initWithObjects:@"家政", @"快照", @"家电维修", @"送水站", @"搬家", @"厕所", @"银行", @"宠物店", nil];
    [self addBtnInView:self.viewThree andTitle:pageThreeArray];
    
    [self.scrollView addSubview:self.viewOne];
    [self.scrollView addSubview:self.viewTwo];
    [self.scrollView addSubview:self.viewThree];
    
}

// 添加按钮
- (void)addBtnInView:(UIView *)view andTitle:(NSArray *)titles
{
    //按钮设置
    NSInteger cols = 4;
    CGFloat btnW = 60;
    CGFloat btnH = 81;
    CGFloat margin = (view.frame.size.width - btnW * 4) / (4 + 1);
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    NSInteger row = 0;
    NSInteger col = 0;
    
    for (int i = 0; i < 8; i++) {
        LKCircularBtn *btn = [[LKCircularBtn alloc] init];
        col = i % cols;
        row = i / cols;
//        marginIndex = i / 4 + 1 - row * 3;
        
        btnX = margin + col * (btnW + margin);
        btnY = margin - 3 + row * (btnH + margin - 3);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        //        btn.backgroundColor = [UIColor redColor];
        [btn setImage:[UIImage imageNamed:@"findhome_20160126194705meishi"] forState:(UIControlStateNormal)];
        [btn setTitle:titles[i] forState:(UIControlStateNormal)];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [view addSubview:btn];
    }
}

// 初始化PageControl
- (void)setUpPageControlWithFrame:(CGRect)frame
{
#warning 暂将宽度定值为100；
    CGFloat width = 100;
    
    // 尺寸设置
    CGFloat x = (frame.size.width -100) / 2;
    CGFloat y = frame.size.height - 10;
    CGFloat height = 10;
    self.pageControl = [[UIPageControl alloc] initWithFrame:(CGRectMake(x, y, width, height))];
    
    // 属性设置
    self.pageControl.numberOfPages = 3;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    self.pageControl.currentPage = 0;
    
    [self.view addSubview:self.pageControl];
}

#pragma mark - 点击按钮触发的代理方法
- (void)btnClick:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(didSelectedBtn:)]) {
        
        [_delegate didSelectedBtn:btn];
    }
}

#pragma mark - ScrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger scrollViewWidth = scrollView.frame.size.width;
    CGFloat scrollViewHeight = self.viewOne.height;
    NSInteger scrollViewContentWidth = scrollView.contentSize.width;
    CGFloat oneW = self.viewOne.frame.origin.x;
    CGFloat twoW = self.viewTwo.frame.origin.x;
    CGFloat threeW = self.viewThree.frame.origin.x;
    
    // 设置偏移量指数：指数为0时，则是左移；指数为2时，则是右移；
    NSInteger offsetXIndex = (NSInteger)scrollView.contentOffset.x / scrollViewWidth;
    
    switch (offsetXIndex) {
            
        case 0: // 左移
            
            oneW += scrollViewWidth;
            twoW += scrollViewWidth;
            threeW += scrollViewWidth;
            
            [self.viewTwo setFrame:(CGRectMake(((int)twoW % scrollViewContentWidth), 0, scrollViewWidth, scrollViewHeight))];
            
            [self.viewOne setFrame:(CGRectMake(((int)oneW % scrollViewContentWidth), 0, scrollViewWidth, scrollViewHeight))];
            
            [self.viewThree setFrame:(CGRectMake(((int)threeW % scrollViewContentWidth), 0, scrollViewWidth, scrollViewHeight))];
            
            [self.scrollView setContentOffset:(CGPointMake(scrollViewWidth * 1, 0))];
            
            self.pageControl.currentPage = (self.pageControl.currentPage +2) % 3;
            
            break;
            
        case 2: // 右移
            
            oneW += scrollViewWidth * 2;
            twoW += scrollViewWidth * 2;
            threeW += scrollViewWidth * 2;
            
            [self.scrollView setContentOffset:(CGPointMake(scrollViewWidth * 1, 0))];
            
            [self.viewTwo setFrame:(CGRectMake(((int)twoW % scrollViewContentWidth), 0, scrollViewWidth, scrollViewHeight))];
            
            [self.viewOne setFrame:(CGRectMake(((int)oneW % scrollViewContentWidth), 0, scrollViewWidth, scrollViewHeight))];
            
            [self.viewThree setFrame:(CGRectMake(((int)threeW % scrollViewContentWidth), 0, scrollViewWidth, scrollViewHeight))];
            
            self.pageControl.currentPage = (self.pageControl.currentPage +1) % 3;
            
        default:
            break;
    }
}

@end
