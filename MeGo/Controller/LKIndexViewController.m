//
//  LINKIndexViewController.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/19.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKIndexViewController.h"
#import "LKCircularBtn.h"
#import "LKStoreViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "LKLocationViewController.h"



@interface LKIndexViewController () <UIScrollViewDelegate,UIScrollViewAccessibilityDelegate, CLLocationManagerDelegate, LKLocationViewControllerDelegate>

/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *locationManager;

/** 保存最新的位置信息*/
@property (nonatomic, strong) CLLocation *currentLocation;


/** 指示器*/
@property (nonatomic, strong) UIPageControl *pageControl;
/** scrollView*/
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation LKIndexViewController

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        // 创建位置管理者
        _locationManager = [[CLLocationManager alloc] init];
        // 成为代理
        _locationManager.delegate = self;
        
        // 每隔多少米定位一次，与精确度冲突，此项有值，则精确度无效；
        _locationManager.distanceFilter = 100;
        
        /**
         kCLLocationAccuracyBestForNavigation // 最适合导航
         kCLLocationAccuracyBest; // 最好的
         kCLLocationAccuracyNearestTenMeters; // 10m
         kCLLocationAccuracyHundredMeters; // 100m
         kCLLocationAccuracyKilometer; // 1000m
         kCLLocationAccuracyThreeKilometers; // 3000m
         */
        // 精确度越高, 越耗电, 定位时间越长
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        
        // 前台定位授权(默认情况下,不可以在后台获取位置, 勾选后台模式 location update, 但是 会出现蓝条)
        [_locationManager requestWhenInUseAuthorization];
        
        
    }
    return _locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigation];
    
    [self setUpScrollView];
    
    [self.locationManager startUpdatingLocation];
    
}

#pragma mark - 导航栏初始化
- (void)setUpNavigation
{
    //设置导航栏标题
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏左侧按钮
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"城市" style:(UIBarButtonItemStyleDone) target:self action:@selector(locationSelected)];
    
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:JKCity];
    
    if (city) {
        
        self.navigationItem.leftBarButtonItem.title = city;
    }
}

// 地址选择界面代理
- (void)didSelectedButtonWithCity:(NSString *)city
{
    self.navigationItem.leftBarButtonItem.title = city;
}

- (void)locationSelected
{
    LKLocationViewController *sub = [[LKLocationViewController alloc] init];
    
    sub.delegate = self;
    
    // 隐藏tabbar
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:sub animated:YES];
    
    // 为了让跳转回来时正常显示tabbar
    self.hidesBottomBarWhenPushed = NO;
}



#pragma mark - 获取位置信息

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //    NSLog(@"定位到了");
    /**
     *  CLLocation 详解
     *  coordinate : 经纬度
     *  altitude : 海拔
     *  course : 航向
     *  speed ; 速度
     */
    JKLog(@"imhere");

    self.currentLocation = [locations lastObject];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    JKLog(@"%@", error);
}

#pragma mark - 设置按钮
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
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.scrollView addSubview:btn];
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
}

#pragma mark - 向Push出的控制器传值

- (void)btnClick:(UIButton *)btn
{
    LKStoreViewController *storeVc = [[LKStoreViewController alloc] init];
    
    //设置导航栏标题
    storeVc.title = btn.titleLabel.text;
    
    //隐藏导航栏
    self.hidesBottomBarWhenPushed = YES;
    
    _delegate = storeVc;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"latitude"] = @(self.currentLocation.coordinate.latitude);
    params[@"longitude"] = @(self.currentLocation.coordinate.longitude);
    params[@"category"] = storeVc.title;

    JKLog(@"%f", self.currentLocation.coordinate.latitude);
    
    if ([_delegate respondsToSelector:@selector(indexViewController:didClickBtnWithParams:)]) {
        
        [_delegate indexViewController:self didClickBtnWithParams:params];
        
    }

    [self.navigationController pushViewController:storeVc animated:YES];
    
    //为了让跳转回来时正常显示tabbar
    self.hidesBottomBarWhenPushed = NO;
    
}

@end
