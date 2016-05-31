//
//  LKStoreViewController.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/21.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKStoreViewController.h"
#import "LKBasedataAPI.h"
#import "LKDelicacyStoreCell.h"
#import <MJRefresh.h>
#import "LKToolBarMenu.h"
#import "LKMenuDataProcessing.h"
#import "LKDelicacyStoreModel.h"
#import "LKWebViewController.h"
#import "FeSpinnerTenDot.h"
#import "LKNetWorkReloadView.h"
#import "LKCacheManage.h"
#import <CoreLocation/CoreLocation.h>
#import <SVProgressHUD/SVProgressHUD.h>


// 枚举状态类型
typedef enum {
    
    LoadingStatusLoadingNew     = 1 << 0,   // 1
    
    LoadingStatusLoadingMore    = 2 << 1,   // 2
    
}LoadingStatus;

@interface LKStoreViewController ()<UITableViewDataSource, UITableViewDelegate, LKToolBarMenuDelegate, LKMenuDataProcessingDelegate, UITextFieldDelegate, LKNetWorkReloadViewDelegate>

/** 蒙版*/
@property (nonatomic, strong) FeSpinnerTenDot *hud;

/** 数据加载状态*/
@property (nonatomic, assign) NSInteger LoadingStatus;

/** 导航栏搜索控件*/
@property (nonatomic, strong) UIImageView *titleView;

/** 导航栏上的文本框*/
@property (nonatomic, strong) UITextField *textField;


/** 加载二级菜单数据*/
@property (nonatomic, strong) LKMenuDataProcessing *menuDataManager;

/** 菜单栏数据*/
@property (nonatomic, strong) LKToolBarMenu *toolBarMenu;



/** 显示商品数据的表格*/
@property (strong, nonatomic) UITableView *tableView;
/** 帖子数据 */
@property (nonatomic, strong) NSMutableArray *cities;

/** 上一次的请求参数 */
@property (nonatomic, strong) NSMutableDictionary *addNewParams;

/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 上一次的请求参数 */
@property (nonatomic, strong) NSDictionary *params;

/** 记录菜单数据 */
@property (nonatomic, strong) NSArray *dataIndexArray;

/** 判断是否显示动画*/
@property (nonatomic, assign) BOOL isShowAnimation;


@end

@implementation LKStoreViewController

static NSString * const LKStoreCellID = @"store";

#pragma mark - 初始化控制器
- (void)viewDidLoad {
    
    [super viewDidLoad];
    

    self.view.backgroundColor = JKGlobalBg; // [UIColor orangeColor];
    
    // 设置控制器属性，以免控件被偏移出理想位置；
    self.automaticallyAdjustsScrollViewInsets= NO;
    
    // 加载测试用按钮
    [self setUpTestBtn];
    
    // 跳转页面时，加载loading动画；
    [self setUpHud];
    
    // 初始化导航栏
    [self setUpNavationBar];
    
    //初始化表格
    [self setUpTableView];
    
    //加载刷新功能
    [self setUpRefresh];
    
    //加载菜单栏
    [self setUpToolBar];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        [self loadNewStores];
    });
}

- (void)setUpHud
{
    FeSpinnerTenDot *hud = [[FeSpinnerTenDot alloc] initWithView:self.view withBlur:YES];
    hud.backgroundColor = JKGlobalBg; // [UIColor orangeColor];
    hud.titleLabelText = @"加载中...";
    hud.fontTitleLabel = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
    
    [self.view addSubview:hud];
    self.hud = hud;
    [hud show];
}

#pragma mark - 初始化导航栏
- (void)setUpNavationBar
{
    // setTranslucent 系统默认为yes，状态栏及导航栏底部是透明的，界面上的组件应该从屏幕顶部开始显示，因为是半透明的，可以看到，所以为了不和状态栏及导航栏重叠，第一个组件的y应该从44+20的位置算起；
    // 而将setTranslucent设置为no时，则状态栏及导航样不为透明的，界面上的组件就是紧挨着导航栏显示了，所以就不需要让第一个组件在y方向偏离44+20的高度了。
    [self.navigationController.navigationBar setTranslucent:NO];
    
    //    [bar setBarTintColor:[UIColor whiteColor]];
    
    // 导航栏按钮的颜色
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
    
    // 另一种写法：
    //    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    
    // PingFangSC-Semibold
    // Georgia-BoldItalic
    // STHeitiJ-Medium
    titleAttr[NSFontAttributeName] = [UIFont fontWithName:@"STHeitiJ-Medium" size:18];
    //    titleAttr[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttr];
    
    // 设置导航栏标题颜色和字体
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 200, 44))];
    titleLabel.text = self.title;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:22];
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    // 导航栏左边按钮
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(backToIndexPage)];
    
    [itemLeft setImage:[UIImage imageNamed:@"yy_calendar_icon_previous"]];
    
    self.navigationItem.leftBarButtonItem = itemLeft;
    
#warning 下版本开启此功能
    // 导航栏右边按钮 下版本强化
//    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(pushToSearchingPage)];
//    
//    [itemRight setImage:[UIImage imageNamed:@"home_topbar_icon_search_default"]];
//    
//    self.navigationItem.rightBarButtonItem = itemRight;
    
    // 加载导航栏搜索功能 下版本强化
//    [self setUpNavigationSearchField];
    
}

- (void)backToIndexPage
{
    
//    [self.textField resignFirstResponder];
    CATransition *transion=[CATransition animation];
    //设置转场动画的类型
    transion.type=@"cube";
    //设置转场动画的方向
    transion.subtype=@"fromLeft";
    
    //把动画添加到某个view的图层上
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transion forKey:nil];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
    
}

- (void)pushToSearchingPage
{
    //    [self.textField resignFirstResponder];
    CATransition *transion=[CATransition animation];
    //设置转场动画的类型
    transion.type=@"cube";
    //设置转场动画的方向
    transion.subtype=@"fromRight";
    
    //把动画添加到某个view的图层上
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transion forKey:nil];
    
    [self.navigationController pushViewController:[[LKSearchingViewController alloc] init] animated: NO];
}

#warning 此版本暂不启用此功能
//// 导航栏搜索功能
//- (void)setUpNavigationSearchField
//{
//    // 设置导航栏搜索控件背景
//    UIImageView *titleView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, 180, 30))];
//    [titleView setImage:[UIImage imageNamed:@"home_topbar_search"]];
//    titleView.userInteractionEnabled = YES;
//    titleView.layer.cornerRadius = titleView.frame.size.height * 0.5;
//    titleView.layer.masksToBounds = YES;
//    titleView.layer.borderColor = [UIColor orangeColor].CGColor;
//    titleView.layer.borderWidth = 1.5;
//    
//    // 设置导航栏搜索控件放大镜
//    UIImageView *searchView =[[UIImageView alloc] initWithFrame:(CGRectMake(9, 6, 18, 18))];
//    [searchView setImage:[UIImage imageNamed:@"home_topbar_icon_search_default"] ];
//    [titleView addSubview:searchView];
//    
//    // 设置导航栏搜索控件占位文字
//    UITextField *text = [[UITextField alloc] initWithFrame:(CGRectMake(33, 6, 225, 18))];
//    text.placeholder = @"输入商户名、地点";
//    [text setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
//    
//    text.textColor = [UIColor blackColor];
//    text.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
//    [titleView addSubview:text];
////    [text becomeFirstResponder];
//    text.keyboardType = UIKeyboardTypeDefault;
//    text.returnKeyType = UIReturnKeySearch;
//    text.clearButtonMode = UITextFieldViewModeAlways;
//    text.delegate = self;
//    self.navigationItem.titleView = titleView;
//    
//    self.textField = text;
//    self.titleView = titleView;
//    //    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
//    
//    //    textfield.placeholder = @"🔍输入商户名、地点";
//    
//    [self titleViewAnimation];
//}
//
//// searchingField动画
//- (void)titleViewAnimation
//{
//    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:51 options:(UIViewAnimationOptionCurveLinear) animations:^{
//        
//        [self.titleView setFrame:(CGRectMake(0, 0, 261, 30))];
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//}

//#pragma mark - 导航栏搜索框的代理方法
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    // 收起键盘
//    [textField resignFirstResponder];
//    
//    if ([textField.text isEqualToString:@""]) {
//        
//        return YES;
//        
//    }else{
//        
//        // 参数
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        
//        //    params[@"latitude"] = @(self.currentLocation.coordinate.latitude);
//        //    params[@"longitude"] = @(self.currentLocation.coordinate.longitude);
//        params[@"keyword"] = textField.text;
//        
//        self.addNewParams = params;
//        
//        [self loadNewStores];
//    }
//    return YES;
//}

#pragma mark - 首页Push本控制器时的代理方法
// 首页传值到本控制器
- (void)indexViewController:(LKIndexViewController *)viewController didClickBtnWithParams:(NSMutableDictionary *)params;
{
    self.addNewParams = params;
    
//    [self loadNewStores];
}

#pragma mark - 搜索控制器Push本控制器时的代理方法
// 搜索控制器传值到本控制器
- (void)searchingWithParams:(NSMutableDictionary *)params
{
    self.title = @"全部";
    
    self.addNewParams = params;
    
//    [self loadNewStores];
}

#pragma mark - 下拉菜单的代理方法(业务逻辑)
- (void)menuSelectedButtonIndex:(NSInteger)index LeftIndex:(NSInteger)left RightIndex:(NSInteger)right
{
    JKLog(@"ButtonIndex:%ld, Left:%ld, Right:%ld",index,left,right);
    
    NSString *paramter = self.dataIndexArray[index][left][right];
    
    switch (index) {
            
        case 0:
            
            if (left == 0) { // 一级菜单选为第一项时：
                
                if (![CLLocationManager locationServicesEnabled]) { // 判断是否开启定位服务；
                    
                    [SVProgressHUD showInfoWithStatus:@"如需定位服务，请您在“设置”=>“隐私”=>“定位服务”中开启本软件的权限~"];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [SVProgressHUD dismiss];
                    });
                    return;
                }
                
                // 传入经纬度
                NSArray *location = [[NSUserDefaults standardUserDefaults]objectForKey:JKLocation];
                self.addNewParams[@"latitude"] = location[0];
                self.addNewParams[@"longitude"] = location[1];
                self.addNewParams[@"region"] = nil;
                
                switch (right) {
                        
                    case 0:
                        
                        self.addNewParams[@"radius"] = nil;
                        
                        [self loadNewStores];

                        break;
                        
                    default:
                        
                        self.addNewParams[@"radius"] = @([paramter intValue]);

                        JKLog(@"[paramter intValue]：%d", [paramter intValue]);

                        [self loadNewStores];

                        break;
                }
                return;
            }

            if (right == 0) { // 二级菜单选项为第一项时：
                
                if (left == 1) { // 一、二级菜单选项同为第一项时：
                    
                    self.addNewParams[@"city"] = [[NSUserDefaults standardUserDefaults] objectForKey:JKCity];
                    
                    self.addNewParams[@"region"] = nil;
                    
                    self.addNewParams[@"radius"] = nil;
                    
                    self.addNewParams[@"latitude"] = nil;
                    
                    self.addNewParams[@"longitude"] = nil;
                    
                    [self loadNewStores];
                    
                    break;
                }
                
                paramter = [paramter substringFromIndex:2];
                
                self.addNewParams[@"region"] = paramter;
                
                self.addNewParams[@"radius"] = nil;
                
                self.addNewParams[@"latitude"] = nil;
                
                self.addNewParams[@"longitude"] = nil;
                
                [self loadNewStores];
                
                break;
            }
            
            self.addNewParams[@"region"] = paramter;
            
            self.addNewParams[@"radius"] = nil;
            
            self.addNewParams[@"latitude"] = nil;
            
            self.addNewParams[@"longitude"] = nil;
            
            [self loadNewStores];

            break;
            
        case 1:
            
            if (right == 0) {
                
                paramter = [paramter substringFromIndex:2];
                
                self.addNewParams[@"category"] = paramter;
                
                [self loadNewStores];
                
                break;
            }
            self.addNewParams[@"category"] = paramter;
            
            [self loadNewStores];
            
            break;
            
        case 2:
            
            self.addNewParams[@"sort"] = @(right + 1);
            
            [self loadNewStores];

            break;
            
        default:
            break;
    }
}

#pragma mark - 获得菜单数据
// 发送网络请求，获得菜单数据；
- (void)setUpToolBar
{
#warning 是否需要做缓存处理
    
    LKMenuDataProcessing *mdp = [[LKMenuDataProcessing alloc] initMenuDataWithTitle:self.title];
    
    mdp.delegate = self;
    
    self.menuDataManager = mdp;
}

// 菜单栏数据的代理方法
- (void)returnMenuDataWithTitles:(NSArray *)titles LeftArray:(NSArray *)leftArray RightArray:(NSArray *)rightArray
{
//    JKLog(@"titles:%@,Left:%@,Right:%@", titles, leftArray, rightArray);
    
    self.dataIndexArray = rightArray;
    
    // 根据返回的数据创建菜单栏
    LKToolBarMenu *menu = [[LKToolBarMenu alloc] initMenuWithButtonTitles:titles andLeftListArray:leftArray andRightListArray:rightArray];
    
    menu.delegate = self;
    
    self.toolBarMenu = menu;
    
    [self.view addSubview:menu.view];
}

#pragma mark - 测试API
- (void)setUpTestBtn
{
    //测试API
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    btn.frame = CGRectMake(270, 150, 90, 30);
    
    [self.view addSubview:btn];
    
    // 字体选择方法
    //    NSArray *arr = [UIFont fontNamesForFamilyName:@"PingFang TC"];
    //    NSArray *arr = [UIFont familyNames];
    //    JKLog(@"arr:%@",arr);
    
    [btn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    
    [btn setTitle:@"API测试按钮" forState:UIControlStateNormal];
    
    btn.backgroundColor = [UIColor redColor];
    
    [btn addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
    
    //测试API2
    UIButton *btnT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    btnT.frame = CGRectMake(270, 190, 90, 30);
    
    [self.view addSubview:btnT];
    
    // 字体选择方法
    //    NSArray *arr = [UIFont fontNamesForFamilyName:@"PingFang TC"];
    //    NSArray *arr = [UIFont familyNames];
    //    JKLog(@"arr:%@",arr);
    
    [btnT.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Semibold" size:14]];
    
    [btnT setTitle:@"API测试按钮2" forState:UIControlStateNormal];
    
    btnT.backgroundColor = [UIColor redColor];
    
    [btnT addTarget:self action:@selector(click2) forControlEvents:(UIControlEventTouchUpInside)];

}

- (void)click
{
    CGFloat qwe = [LKCacheManage checkCacheSize];
    JKLog(@"%f",qwe);
    
    // 参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [LKBasedataAPI findCitySuccess:^(id  _Nullable responseObject) {
        
//        JKLog(@"%@",responseObject);
        
        //        将plist文件写至桌面，以便确认参数；
        //        [responseObject writeToFile:@"/Users/LinK/Desktop/City_Deals.plist" atomically:YES];
        
    } failure:^(id  _Nullable error) {
        
        JKLog(@"%@",error);

    }];
}

- (void)click2
{
//    JKLog(@"%@",[UIFont fontNamesForFamilyName:@"PingFang SC"]);

//    [LKCacheManage checkCalendar];
    
    JKLog(@"%f",LKScreenSize.width);
    
}

#pragma mark - Refresh
- (void)setUpRefresh
{
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStores)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
//    [self.tableView.mj_header beginRefreshing];
    
    //上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStores)];
    
    //设置页面初始值
    self.page = 1;
}

// 加载新数据
- (void)loadNewStores
{
    JKLog(@"上拉");
    
    NSThread *thread = [NSThread currentThread];
    
    JKLog(@"%@",thread);
    
    // 结束下拉刷新，避免冲突
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *params = [self.addNewParams mutableCopy];//
    
    // 上拉刷新，初始化页码；
    NSInteger page = 1;
    params[@"page"] = @(page);
    
    // 参数
    self.params = params;
    
    // 初始化页码参数
    self.addNewParams = [params mutableCopy];
    JKLog(@"上%@",self.addNewParams);
     
    // 获取API
    [LKBasedataAPI findDelicacyStoreWithParamter:params Success:^(id  _Nullable responseObject) {
        
        // 判断是否为最新的一次请求参数，不是的话，立即返回；
        if (self.params != params) return;
        
        // 获得数据
        self.stores = responseObject;

        // 上拉时打开动画开关
        _isShowAnimation = 1;
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 显示菜单栏
        self.toolBarMenu.view.hidden = NO;
        
        // 成功刷新后，结束刷新
        [self.tableView.mj_header endRefreshing];
        
        [self.hud dismiss];
        JKLog(@"load");
        // 清空页码，最小值为1；
        self.page = 1;
       
    } Failure:^(id  _Nullable error) {
        
        // 判断是否为最新的一次请求参数，不是的话，立即返回；
        if (self.params != params) return;
        
        [self.hud dismiss];
        
        self.LoadingStatus = LoadingStatusLoadingNew;
        
        // 判断是否为网络问题
        NSNumber *netStatus = [[NSUserDefaults standardUserDefaults] objectForKey:JKNetWorK];

        if ([netStatus intValue] == 0) {
            
            LKNetWorkReloadView *view = [[LKNetWorkReloadView alloc] init];

            view.delegate = self;
            [self.view addSubview:view];
            }
        
        // 刷新失败后，结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

// 加载更多数据
- (void)loadMoreStores
{
    // 避免上拉下拉同时进行引发的冲突；
    [self.tableView.mj_header endRefreshing];
    
    // 参数
    NSMutableDictionary *params = [self.addNewParams mutableCopy];
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    self.params = params;
    JKLog(@"%ld",self.page);
    
    self.addNewParams = [params mutableCopy];
    JKLog(@"下%@",self.addNewParams);
    
    //获取API
    [LKBasedataAPI findDelicacyStoreWithParamter:params Success:^(id  _Nullable responseObject) {
        JKLog(@"%@",responseObject);
        //判断是否为最新的一次请求参数；
        if (self.params != params) return;
        
        //将数据加入到数组中
        [self.stores addObjectsFromArray:responseObject];
        
        //动画开关关闭；
        _isShowAnimation = 0;
        
        //刷新表格
        [self.tableView reloadData];
        
        self.toolBarMenu.view.hidden = NO;

        
        //成功刷新后，结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        
        [self.hud dismiss];
        
        //更新页码
        self.page = page;
        
    } Failure:^(id  _Nullable error) {
        
        //判断是否为最新的一次请求参数，不是的话，立即返回；
        if (self.params != params) return;
        
        [self.hud dismiss];
        
        self.LoadingStatus = LoadingStatusLoadingMore;
        
        // 判断是否为网络问题
        NSNumber *netStatus = [[NSUserDefaults standardUserDefaults] objectForKey:JKNetWorK];
        
        if ([netStatus intValue] == 0) {
            
            LKNetWorkReloadView *view = [[LKNetWorkReloadView alloc] init];
            
            view.delegate = self;
            [self.view addSubview:view];
        }
        
        //刷新失败后，结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

// ReloadView的代理方法
- (void)tapReloadView:(LKNetWorkReloadView *)reloadView
{
    
#warning 下一版本中实现下拉菜单判断
//    switch (self.LoadingStatus) {
//            
//        case LoadingStatusLoadingNew:{
    
            [self setUpHud];
            
            self.stores = nil;
            
            [self.tableView reloadData];
            
            [reloadView removeFromSuperview];
            
            self.toolBarMenu.view.hidden = YES;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self loadNewStores];
            });

//            break;}
//            
//        case LoadingStatusLoadingMore:{
//            
////            UIView *view = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, LKScreenSize.width, LKScreenSize.height))];
////            view.backgroundColor = JKGlobalBg;
////            [self.view addSubview:view];
//            
//            [self setUpHud];
//            
//            self.stores = nil;
//            
//            [self.tableView reloadData];
//            
//            [reloadView removeFromSuperview];
//            
//            self.toolBarMenu.view.hidden = YES;
//            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                
//                [self loadMoreStores];
//            });
//            
//            break;}
//
//        default:
//            break;
//    }
}

#pragma mark - tableViewDataSouce
- (void)setUpTableView
{
    // 调整导航栏为不透明后，向下偏移量多出了64，因此减去64；
    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 44, LKScreenSize.width, LKScreenSize.height - 44-64)) style:(UITableViewStylePlain)];

    self.tableView.backgroundColor = JKGlobalBg;

    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
//    self.tableView.autoresizingMask = NO;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    [self.view sendSubviewToBack:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LKDelicacyStoreCell class]) bundle:nil] forCellReuseIdentifier:LKStoreCellID];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stores.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LKDelicacyStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:LKStoreCellID];
    
    cell.store = self.stores[indexPath.row];
    
    NSInteger rows = (LKScreenSize.height - 108) / 88 + 1;
    
    if (indexPath.row < rows && _isShowAnimation == 1) {
    
        // 动画
        CGRect frameOringe = cell.frame;
        NSInteger delayNum = indexPath.row % 7;
        
        // 取值为0和1；
        // 随机值：
//        NSInteger oddEvenNum = arc4random_uniform(2) + 1;
//        CGFloat x = cell.frame.origin.x + LKScreenSize.width * pow(-1, oddEvenNum);
        
        // 固定值：
        NSInteger rowIndex = indexPath.row;
        CGFloat x = cell.frame.origin.x + LKScreenSize.width * pow(-1, rowIndex);

        // 随机坐标飞入效果
        //    NSInteger y = arc4random_uniform(900) - 90;
        NSInteger y = cell.frame.origin.y;
        
        CGRect aFrame = CGRectMake(x , y, cell.frame.size.width, cell.frame.size.height);
        
        cell.layer.frame = aFrame;
        
        // 在layer上添加动画，动画执行过程中不会影响点击事件；
        CABasicAnimation * animation = [CABasicAnimation animation];

        animation.keyPath = @"position.x";
    
        animation.speed = 1.8;
    
        animation.fromValue = @(aFrame.origin.x);
        
        animation.toValue = @(frameOringe.origin.x);
        
        animation.duration = 0.25 +0.1 *delayNum;
        
        [cell.layer addAnimation:animation forKey:nil];
        
//        // 普通阻塞式动画
//        cell.frame = aFrame;
//        
//        [UIView animateWithDuration:0.3 delay:0.1 * delayNum usingSpringWithDamping:0.6 initialSpringVelocity:15 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
//            
//            cell.frame = frameOringe;
//            
//        } completion:^(BOOL finished) {
//        }];
        
    }else if (indexPath.row == 7){
        
//        动画开关关闭；
        _isShowAnimation = 0;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // cell在xib中的高度，+ 上下边距留出的3;
    return 88;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LKDelicacyStoreModel *store = self.stores[indexPath.row];
    
    LKWebViewController *wvc = [[LKWebViewController alloc] init];
    
    // 加载链接
    [wvc.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:store.business_url]]];
    
    wvc.title = store.name;
    
    // 隐藏tabbar
    self.hidesBottomBarWhenPushed = YES;
    
    CATransition *transion=[CATransition animation];
    //设置转场动画的类型
    transion.type=@"cube";
    //设置转场动画的方向
    transion.subtype=@"fromRight";
    
    //把动画添加到某个view的图层上
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transion forKey:nil];

    [self.navigationController pushViewController:wvc animated:NO];
}

@end
