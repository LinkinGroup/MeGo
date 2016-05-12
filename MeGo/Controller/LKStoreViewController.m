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


@interface LKStoreViewController ()<UITableViewDataSource, UITableViewDelegate, LKToolBarMenuDelegate, LKMenuDataProcessingDelegate>

/** 加载二级菜单数据*/
@property (nonatomic, strong) LKMenuDataProcessing *menuDataManager;


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

@end

@implementation LKStoreViewController

static NSString * const LKStoreCellID = @"store";

#pragma mark - 初始化控制器
- (void)viewDidLoad {
    [super viewDidLoad];

    //测试API
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    btn.frame = CGRectMake(200, 150, 90, 90);
    
    [self.view addSubview:btn];
    
    // 字体选择方法
//    NSArray *arr = [UIFont fontNamesForFamilyName:@"PingFang TC"];
//    NSArray *arr = [UIFont familyNames];
//    JKLog(@"arr:%@",arr);
    
    [btn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Semibold" size:18]];
    
    [btn setTitle:@"附近智能" forState:UIControlStateNormal];
    
    btn.backgroundColor = [UIColor redColor];
    
    [btn addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //初始化表格
    [self setUpTableView];
    
    //加载刷新功能
    [self setUpRefresh];
    
    //加载菜单栏
    [self setUpToolBar];
//    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"北京" forKey:JKCity];
    
}


#pragma mark - 首页Push本控制器时的代理方法

//首页传值到本控制器
- (void)indexViewController:(LKIndexViewController *)viewController didClickBtnWithParams:(NSMutableDictionary *)params;
{
    self.addNewParams = params;
    
    [self loadNewStores];
}

#pragma mark - 下拉菜单的代理方法
- (void)menuSelectedButtonIndex:(NSInteger)index LeftIndex:(NSInteger)left RightIndex:(NSInteger)right
{
    JKLog(@"ButtonIndex:%ld, Left:%ld, Right:%ld",index,left,right);
    
    NSString *paramter = self.dataIndexArray[index][left][right];
    
    switch (index) {
            
        case 0:
            
            if (right == 0) { // 二级菜单选项为第一项时：
                
                if (left == 0) { // 一、二级菜单选项同为第一项时：
                    
                    self.addNewParams[@"city"] = [[NSUserDefaults standardUserDefaults] objectForKey:JKCity];
                    
                    self.addNewParams[@"region"] = nil;
                    
                    self.addNewParams[@"latitude"] = nil;
                    
                    self.addNewParams[@"longitude"] = nil;
                    
                    [self loadNewStores];
                    
                    break;
                }
                
                paramter = [paramter substringFromIndex:2];
                
                self.addNewParams[@"region"] = paramter;
                
                self.addNewParams[@"latitude"] = nil;
                
                self.addNewParams[@"longitude"] = nil;
                
                [self loadNewStores];
                
                break;
            }
            
            self.addNewParams[@"region"] = paramter;
            
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

#pragma mark - 菜单栏数据的代理方法
- (void)returnMenuDataWithTitles:(NSArray *)titles LeftArray:(NSArray *)leftArray RightArray:(NSArray *)rightArray
{
//    JKLog(@"titles:%@,Left:%@,Right:%@", titles, leftArray, rightArray);
    
    self.dataIndexArray = rightArray;
    
    // 根据返回的数据创建菜单栏
    LKToolBarMenu *menu = [[LKToolBarMenu alloc] initMenuWithButtonTitles:titles andLeftListArray:leftArray andRightListArray:rightArray];
    
        menu.delegate = self;
    
        [self.view addSubview:menu.view];
}

#pragma mark - 测试API
- (void)click
{
    
    // 参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [LKBasedataAPI findCategorySuccess:^(id  _Nullable responseObject) {
        
        JKLog(@"%@",responseObject);
        
        //        将plist文件写至桌面，以便确认参数；
//                        [responseObject writeToFile:@"/Users/LinK/Desktop/Category.plist" atomically:YES];
        
    } failure:^(id  _Nullable error) {
        
        JKLog(@"%@",error);

    }];
    
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

- (void)loadNewStores
{
    JKLog(@"上拉");

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

        // 刷新表格
        [self.tableView reloadData];
        
        // 成功刷新后，结束刷新
        [self.tableView.mj_header endRefreshing];
        
        // 清空页码，最小值为1；
        self.page = 1;
       
    } Failure:^(id  _Nullable error) {
        
        // 判断是否为最新的一次请求参数，不是的话，立即返回；
        if (self.params != params) return;
        
        // 刷新失败后，结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

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
        
        //判断是否为最新的一次请求参数；
        if (self.params != params) return;
        
        //将数据加入到数组中
        [self.stores addObjectsFromArray:responseObject];
        
        //刷新表格
        [self.tableView reloadData];
        
        //成功刷新后，结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        //更新页码
        self.page = page;
        
    } Failure:^(id  _Nullable error) {
        
        //判断是否为最新的一次请求参数，不是的话，立即返回；
        if (self.params != params) return;
        
        //刷新失败后，结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - tableViewDataSouce
- (void)setUpTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 44, LKScreenSize.width, LKScreenSize.height - 44)) style:(UITableViewStylePlain)];
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
    
    //隐藏导航栏
    self.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:wvc animated:YES];
    
    //为了让跳转回来时正常显示tabbar
    self.hidesBottomBarWhenPushed = NO;
    
}

@end
