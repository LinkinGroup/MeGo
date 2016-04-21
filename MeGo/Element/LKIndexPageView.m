//
//  LKIndexPageView.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/21.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKIndexPageView.h"
#import "LKCircularBtn.h"
#import "LKBasedataAPI.h"
#import "LKStoreViewController.h"

@interface LKIndexPageView ()<UIScrollViewDelegate>

/** 指示器*/
@property (nonatomic, strong) UIPageControl *pageControl;
/** scrollView*/
@property (nonatomic, strong) UIScrollView *scrollView;



@end

@implementation LKIndexPageView

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
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, 0, LKScreenSize.width, 240))];
    scrollView.contentSize = CGSizeMake(LKScreenSize.width * 3, 240);
    scrollView.pagingEnabled = YES;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    
    CGFloat pcW = 60;
    CGFloat pcH = 15;
    CGFloat pcX = (LKScreenSize.width - pcW) / 2;
    CGFloat pcY = CGRectGetMaxY(self.scrollView.frame) - 24;
    self.pageControl = [[UIPageControl alloc] initWithFrame:(CGRectMake(pcX, pcY, pcW, pcH))];
    
    _pageControl.numberOfPages = 3;
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];

    [self addSubview:_pageControl];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //按钮设置
    NSInteger cols = 12;
    CGFloat btnW = 60;
    CGFloat btnH = 81;
    CGFloat margin = (LKScreenSize.width - btnW * 4) / (4 + 1);
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    NSInteger row = 0;
    NSInteger col = 0;
    NSInteger marginIndex = 0;

    
    for (int i = 0; i < 24; i++) {
        LKCircularBtn *btn = [[LKCircularBtn alloc] init];
        col = i % cols;
        row = i / cols;
        marginIndex = i / 4 + 1 - row * 3;
        
        btnX = margin * marginIndex + col * (btnW + margin);
        btnY = margin + row * (btnH + margin);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
//        btn.backgroundColor = [UIColor redColor];
        [btn setImage:[UIImage imageNamed:@"findhome_20160126194705meishi"] forState:(UIControlStateNormal)];
        [btn setTitle:@"美食" forState:(UIControlStateNormal)];
        
        [btn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.scrollView addSubview:btn];
        
    }
    
}

- (void)btnClick
{
    LKStoreViewController *storeVc = [[LKStoreViewController alloc] init];
    
    JKLog(@"123");
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
}


@end
