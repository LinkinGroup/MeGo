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
#import "LKScrollView.h"
#import "LKSearchingViewController.h"
#import "LKBasedataAPI.h"
#import "LKUserDefaults.h"
#import "LKStarsView.h"
#import "LKTabbarController.h"


@interface LKIndexViewController () <LKScrollViewDelegate, CLLocationManagerDelegate, LKLocationViewControllerDelegate>

/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *locationManager;

/** 导航栏地址按钮*/
@property (nonatomic, strong) UIBarButtonItem *leftButtonItem;

/** stars*/
@property (nonatomic, strong) UIImageView *starsView;

/** starsBundle*/
@property (nonatomic, strong) UIImageView *starsViewBundle;

/** stars第二张*/
@property (nonatomic, strong) UIImageView *starsViewSec;

/** stars第二张的Bundle*/
@property (nonatomic, strong) UIImageView *starsViewSecBundle;

/** starsCloud*/
@property (nonatomic, strong) UIImageView *starsCloud;

/** starsCloudBundle*/
@property (nonatomic, strong) UIImageView *starsCloudBundle;

@end

@implementation LKIndexViewController

#pragma mark - 初始化操作
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
    
    // 显示statusBar
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
    // 用户首次打开软件时调用
    // 开关控制
    int isOn = [[[NSUserDefaults standardUserDefaults] objectForKey:JKShowPicture] intValue];
    
    if (!isOn) {
        [[NSUserDefaults standardUserDefaults] setObject:@(2) forKey:JKShowPicture];
    }
    
    // 设置控制器属性，以免控件被偏移出理想位置；
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.view.backgroundColor = JKGlobalBg;
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setUpNavigation];
    
    [self.locationManager startUpdatingLocation];
    
    [self setUpBackgroundView];

    [self setUpScrollView];
    // 开启网络状态检查
    [LKBasedataAPI netWorkInspectorGoToWork];

}

- (void)setUpBackgroundView
{
    UIView *imageView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, LKScreenSize.width, LKScreenSize.width * 559 / 375))];
    
//    UIImageView *lightView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, LKScreenSize.width, LKScreenSize.width * 559 / 375))];
//    lightView.image = [UIImage imageNamed:@"light"];
    
    UIImageView *starsView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, LKScreenSize.width * 2, LKScreenSize.width * 559 / 375))];
    starsView.image = [UIImage imageNamed:@"stars"];
    
    UIImageView *starsViewSec = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, LKScreenSize.width * 2, LKScreenSize.width * 559 / 375))];
    starsViewSec.image = [UIImage imageNamed:@"starsSec"];
    
    self.starsViewBundle = [[UIImageView alloc] initWithFrame:(CGRectMake(LKScreenSize.width *2, 0, LKScreenSize.width * 2, LKScreenSize.width * 559 / 375))];
    self.starsViewBundle.image = [UIImage imageNamed:@"stars"];
    
    self.starsViewSecBundle = [[UIImageView alloc] initWithFrame:(CGRectMake(LKScreenSize.width *2, 0, LKScreenSize.width * 2, LKScreenSize.width * 559 / 375))];
    self.starsViewSecBundle.image = [UIImage imageNamed:@"starsSec"];
    
    UIImageView *starsCloud = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, LKScreenSize.width * 2, LKScreenSize.width * 960 / 640))];
    starsCloud.image = [UIImage imageNamed:@"cloudyLaydown"];
    
    UIImageView *starsCloud2 = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, LKScreenSize.width * 2, LKScreenSize.width * 960 / 640))];
    starsCloud2.image = [UIImage imageNamed:@"cloudyLaydown"];
    
    self.starsCloudBundle = [[UIImageView alloc] initWithFrame:(CGRectMake(LKScreenSize.width * 2, 0, LKScreenSize.width * 2, LKScreenSize.width * 960 / 640))];
    starsCloud2.image = [UIImage imageNamed:@"cloudyLaydown"];
    
    // LOGO位置计算
    CGFloat width = LKScreenSize.width;
    CGFloat margin = (width - 60 * 4) / (4 + 1);
    CGFloat height = margin * 2.5 + 81 * 2 + 28 ;
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:(CGRectMake(width /4, height + (LKScreenSize.height - height- width /4 - 108)/2, width /2, width /4))];
    logoView.image = [UIImage imageNamed:@"MeGo"];

    // 添加view
    self.starsView = starsView;
    self.starsViewSec = starsViewSec;
    self.starsCloud = starsCloud;
    
    [imageView sendSubviewToBack:starsView];
//    [imageView addSubview:lightView];
    [imageView addSubview:starsView];
    [imageView addSubview:starsViewSec];
    [imageView addSubview:self.starsViewBundle];
    [imageView addSubview:self.starsViewSecBundle];
    [imageView addSubview:starsCloud];
    [imageView addSubview:starsCloud2];
    [imageView addSubview:self.starsCloudBundle];
//    [imageView bringSubviewToFront:logoView];
    [imageView addSubview:logoView];


    // 自动播放开关，耗用CPU2%
//    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(starViewAnimation)];
//    
//    // 添加主运行循环
//    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    [self.view addSubview:imageView];
}

// ScrollView的滚动关联动画
- (void)starViewAnimation
{
    self.starsViewSec.x         -= 0.5;
    self.starsViewSecBundle.x   -= 0.5;
    self.starsView.x            -= 0.7;
    self.starsViewBundle.x      -= 0.7;
    self.starsCloud.x           -= 0.3;
    self.starsCloudBundle.x     -= 0.3;
    
    if (self.starsView.x < - LKScreenSize.width *2) {
        self.starsView.x = CGRectGetMaxX(self.starsViewBundle.frame);
    }
    if (self.starsViewSec.x < - LKScreenSize.width *2) {
        self.starsViewSec.x = CGRectGetMaxX(self.starsViewSecBundle.frame);
    }
    if (self.starsViewBundle.x < - LKScreenSize.width *2) {
        self.starsViewBundle.x = CGRectGetMaxX(self.starsView.frame);
    }
    if (self.starsViewSecBundle.x < - LKScreenSize.width *2) {
        self.starsViewSecBundle.x = CGRectGetMaxX(self.starsViewSec.frame);
    }
    if (self.starsCloud.x  < - LKScreenSize.width *2) {
        self.starsCloud.x  = CGRectGetMaxX(self.starsCloudBundle.frame);
    }
    if (self.starsCloudBundle.x  < - LKScreenSize.width *2) {
        self.starsCloudBundle.x  = CGRectGetMaxX(self.starsCloud.frame);
    }
}

// 走马灯ScrollView
- (void)setUpScrollView
{
//    LKScrollView *scrollView = [[LKScrollView alloc] initWithScrollViewFrame:(CGRectMake(0, 0, LKScreenSize.width, 245))];

    LKScrollView *scrollView = [[LKScrollView alloc] initWithScrollView];
    
    CGFloat width = scrollView.view.width;
    
    CGFloat height = scrollView.view.height;

    scrollView.delegate = self;
    
    [self addChildViewController:scrollView];
    
    UIView *view = [[UIView alloc] initWithFrame:(CGRectMake(0, -height, width, height))];
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:scrollView.view];

    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:9 initialSpringVelocity:1 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        
        [self.view addSubview:view];
//        scrollView.view.frame = CGRectMake(0, 0, LKScreenSize.width, 245);
        view.frame = CGRectMake(0, 0, width, height); //scrollView.view.frame;

    } completion:^(BOOL finished) {
        
    }];
}

// scrollView 代理方法
- (void)didScroll:(UIScrollView *)scrollView
{
//    CGFloat x = scrollView.contentOffset.x;
//    CGFloat moveX = 0;
//    
//    if (x - LKScreenSize.width < 0) { //左边移动
//        moveX = LKScreenSize.width - x;
//    }else{
//        moveX =
//    }
    
//    JKLog(@"123:%f",x);
    
    [self starViewAnimation];
}

#pragma mark - 导航栏初始化
- (void)setUpNavigation
{
    // 加载导航栏的搜索功能
    [self setUpNavigationSearchField];
    
    // 影响控件y值的两个方法：
    // 设置导航栏是否透明
    [self.navigationController.navigationBar setTranslucent:NO];
    // 此方法通常用在栈顶控制器
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置背影颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    // 设置字体颜色
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
    
    // 访问偏好设置，查看上次选择的城市
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:JKCity];
    
    if (city) {
        
        city = [NSString stringWithFormat:@"%@ ▽", city];
        
    }else {
        
        city = @"城市 ▽";
    }
    
    // 设置导航栏左侧按钮
    // 计算左侧偏移量：
    CGFloat margin = (LKScreenSize.width - 240) / 5;
    UIBarButtonItem *leftItem = [UIBarButtonItem alloc];
    [leftItem setTitlePositionAdjustment:UIOffsetMake(margin -9 , 0) forBarMetrics:(UIBarMetricsDefault)];
    
    self.navigationItem.leftBarButtonItem = [leftItem initWithTitle:city style:(UIBarButtonItemStyleDone) target:self action:@selector(locationSelected)];
    
//    self.navigationItem.leftBarButtonItem.
//    self.leftButtonItem = self.navigationItem.leftBarButtonItem;
    
}

// 地址选择界面代理
- (void)didSelectedButtonWithCity:(NSString *)city
{
    self.navigationItem.leftBarButtonItem.title = [NSString stringWithFormat:@"%@ ▽", city];
    
}

- (void)locationSelected
{
    LKLocationViewController *sub = [[LKLocationViewController alloc] init];
    
    sub.delegate = self;
    
    // 隐藏tabbar
    self.hidesBottomBarWhenPushed = YES;
    
    // 设置转场动画
    CATransition *transion = [CATransition animation];
    // 设置转场动画的类型
    transion.type = @"cube";
    // 设置转场动画的方向
    transion.subtype = @"fromBottom";
    
    //把动画添加到某个view的图层上
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transion forKey:nil];

    [self.navigationController pushViewController:sub animated:NO];
    
    // 为了让跳转回来时正常显示tabbar
    self.hidesBottomBarWhenPushed = NO;
}

// 导航栏搜索功能
- (void)setUpNavigationSearchField
{
    // 设置导航栏搜索控件背景
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, LKScreenSize.width / 2, 30))];
    [titleView setImage:[UIImage imageNamed:@"home_topbar_search"]];
    titleView.userInteractionEnabled = YES;
        titleView.layer.cornerRadius = titleView.frame.size.height * 0.5;
        titleView.layer.masksToBounds = YES;
    titleView.layer.borderColor = [UIColor orangeColor].CGColor;
    titleView.layer.borderWidth = 1.5;
    
    // 设置导航栏搜索控件放大镜
    UIImageView *searchView =[[UIImageView alloc] initWithFrame:(CGRectMake(9, 6, 18, 18))];
    [searchView setImage:[UIImage imageNamed:@"home_topbar_icon_search_default"] ];
    [titleView addSubview:searchView];
    
    // 设置导航栏搜索控件占位文字
    UILabel *text = [[UILabel alloc] initWithFrame:(CGRectMake(33, 6, 120, 18))];
    text.text = @"输入商户名、地点";//
    text.textColor = [UIColor lightGrayColor];
    text.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
    [titleView addSubview:text];
    
    // 添加点击监听控件
    UIView *view = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, LKScreenSize.width / 2, 30))];
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushSearchView)];
    [view addGestureRecognizer:tap];
    [titleView addSubview:view];
    
    self.navigationItem.titleView = titleView;

    //    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
//    textfield.placeholder = @"🔍输入商户名、地点";
}

// 导航栏搜索控件点击监听
- (void)pushSearchView
{
    //隐藏导航栏
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:[[LKSearchingViewController alloc] init] animated: NO];
    
    //为了让跳转回来时正常显示tabbar
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - tabbar指示器消失BUG修复代码
// 控制器显示时调用
- (void)viewWillAppear:(BOOL)animated
{
    LKTabbarController *tabbarController = (LKTabbarController *)self.tabBarController;
    
    tabbarController.indicator.hidden = NO;
    
    [self.tabBarController.view bringSubviewToFront:tabbarController.indicator];
    
    [self.tabBarController.view insertSubview:tabbarController.indicator aboveSubview:self.tabBarController.view];
    
    [tabbarController.indicator setFrame:tabbarController.indicator.frame];
    
}

// 控制器显示时调用
- (void)viewWillLayoutSubviews
{
    LKTabbarController *tabbarController = (LKTabbarController *)self.tabBarController;
    
    tabbarController.indicator.hidden = NO;
    
    [self.tabBarController.view bringSubviewToFront:tabbarController.indicator];
    
    [self.tabBarController.view insertSubview:tabbarController.indicator aboveSubview:self.tabBarController.view];
    
    [tabbarController.indicator setFrame:tabbarController.indicator.frame];
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

    // 写入缓存
    [LKUserDefaults saveLocation:[locations lastObject]];
    
#warning 下一版本开启
    // 城市定位
//    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
//    
//    [geoCoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        
//        for (CLPlacemark * placemark in placemarks) {
//            
//            NSDictionary *test = [placemark addressDictionary];
//            //  Country(国家)  State(城市)  SubLocality(区)
//            NSLog(@"%@", [test objectForKey:@"State"]);
//        }
//    }];
}

// 位置信息获取失败反馈：
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    JKLog(@"%@", error);
}
#pragma mark - 向Push出的控制器传值
- (void)didSelectedBtn:(UIButton *)sender
{
    LKStoreViewController *storeVc = [[LKStoreViewController alloc] init];
    
    //设置导航栏标题
    storeVc.title = sender.titleLabel.text;
    
    //隐藏导航栏
    self.hidesBottomBarWhenPushed = YES;
    
    _delegate = storeVc;
    
    // 创建参数字典
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 传入经纬度
    NSArray *location = [[NSUserDefaults standardUserDefaults]objectForKey:JKLocation];
    params[@"latitude"] = location[0];
    params[@"longitude"] = location[1];
    
    params[@"category"] = storeVc.title;
    
//    JKLog(@"%@", location[0]);
    
    if ([_delegate respondsToSelector:@selector(indexViewController:didClickBtnWithParams:)]) {
        
        [_delegate indexViewController:self didClickBtnWithParams:params];
    }
    
    CATransition *transion=[CATransition animation];
    //设置转场动画的类型
    transion.type=@"cube";
    //设置转场动画的方向
    transion.subtype=@"fromRight";
    
    //把动画添加到某个view的图层上
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transion forKey:nil];
    
    [self.navigationController pushViewController:storeVc animated:NO];
    
    //为了让跳转回来时正常显示tabbar
    self.hidesBottomBarWhenPushed = NO;
//    self.tabBarController.tabBar.hidden = NO;

}

@end
