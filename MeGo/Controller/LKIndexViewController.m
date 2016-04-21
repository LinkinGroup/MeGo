//
//  LINKIndexViewController.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/19.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKIndexViewController.h"
#import "LKEncryption.h"
#import "LKCircularBtn.h"
#import "LKBasedataAPI.h"
#import "LKStoreViewController.h"

#import <AFNetworking.h>


@interface LKIndexViewController () <UIScrollViewDelegate,UIScrollViewAccessibilityDelegate>

/** 指示器*/
@property (nonatomic, strong) UIPageControl *pageControl;
/** scrollView*/
@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation LKIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *baseURL = @"http://api.dianping.com/v1/deal/get_all_id_list";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"city"] = @"北京";
    
    NSString *url = [LKEncryption serializeURL:baseURL params:params];
    
    params[@"sign"] = url;
    
//    [[AFHTTPSessionManager manager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        JKLog(@"%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        JKLog(@"%@",error);
//        
//    }];
    
    
    [self setUpScrollView];
}

//- (void)setUpScrollView
//{
//    LKIndexPageView *scrollView = [[LKIndexPageView alloc] initWithFrame:(CGRectMake(0, 44, LKScreenSize.width, 240))];
//    [self.view addSubview:scrollView];
//
//}

- (void)setUpScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, 0, LKScreenSize.width, 291))];
    scrollView.contentSize = CGSizeMake(LKScreenSize.width * 3, 0);
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
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
    
    [self.view addSubview:_pageControl];
    
    
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
        btnY = margin - 12 + row * (btnH + margin - 12);
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
    [self.navigationController pushViewController:storeVc animated:YES];
    
    JKLog(@"123");
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
}

#pragma mark - scrollView


@end
