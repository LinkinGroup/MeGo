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
#import "LKPopUpMenu.h"


@interface LKStoreViewController ()<UITableViewDataSource, UITableViewDelegate>

/** 记录工具栏按钮状态*/
@property (nonatomic, strong) UIButton *selectedBtn;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 帖子数据 */
@property (nonatomic, strong) NSMutableArray *cities;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 上一次的请求参数 */
@property (nonatomic, strong) NSDictionary *params;

@end

@implementation LKStoreViewController

static NSString * const LKStoreCellID = @"store";

- (UIButton *)selectedBtn
{
    if (!_selectedBtn) {
        _selectedBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return _selectedBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //测试API
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    btn.frame = CGRectMake(300, 150, 60, 30);
    
    [self.view addSubview:btn];
    
    [btn setTitle:@"testAPI" forState:UIControlStateNormal];
    
    btn.backgroundColor = [UIColor redColor];
    
    [btn addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //初始化表格
    [self setUpTableView];
    
    //加载刷新功能
    [self setUpRefresh];
    
}



#pragma mark - menu

- (IBAction)aroundClick:(UIButton *)sender
{
    if (self.selectedBtn == sender) {
        if (sender.selected == NO) {
            
            [LKPopUpMenu menuWithLinkageMenuInController:self completion:^{
                
                sender.selected = YES;
                self.selectedBtn = sender;
            }];
        }else{
            
            [LKPopUpMenu dismissInViewController:self completion:^{
                
                sender.selected = NO;
            }];
        }
    }else{
        
        [LKPopUpMenu dismissInViewController:self completion:^{
            
            self.selectedBtn.selected = NO;
        }];
        
        [LKPopUpMenu menuWithLinkageMenuInController:self completion:^{
            
            sender.selected = YES;
            self.selectedBtn = sender;
        }];
    }
}

#pragma mark - 测试API
- (void)click
{
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    NSInteger page = self.page + 1;
    params[@"page"] = @2;
    
    [LKBasedataAPI findDelicacyStoreWithParamter:params Success:^(id responseObject) {
        
        JKLog(@"%@",responseObject);
        
//        将plist文件写至桌面，以便确认参数；
//                [responseObject writeToFile:@"/Users/LinK/Desktop/DelicacyStore.plist" atomically:YES];
        
    } Failure:^(id error) {
        
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
    
    //结束上拉刷新，避免冲突
    [self.tableView.mj_footer endRefreshing];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    self.params = params;

    
    //获取API
    [LKBasedataAPI findDelicacyStoreWithParamter:params Success:^(id  _Nullable responseObject) {
        
        //判断是否为最新的一次请求参数，不是的话，立即返回；
        if (self.params != params) return;
        
        //获得数据
        self.stores = responseObject;
        
        //刷新表格
        [self.tableView reloadData];
        
        //成功刷新后，结束刷新
        [self.tableView.mj_header endRefreshing];
        
        //清空页码，最小值为1；
        self.page = 1;
       
    } Failure:^(id  _Nullable error) {
        
        //判断是否为最新的一次请求参数，不是的话，立即返回；
        if (self.params != params) return;
        
        //刷新失败后，结束刷新
        [self.tableView.mj_header endRefreshing];
        
    }];

}

- (void)loadMoreStores
{
    //避免上拉下拉同时进行引发的冲突；
    [self.tableView.mj_header endRefreshing];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    self.params = params;
    
    
    //获取API
    [LKBasedataAPI findDelicacyStoreWithParamter:params Success:^(id  _Nullable responseObject) {
        
        //判断是否为最新的一次请求参数，不是的话，立即返回；
        if (self.params != params) return;
        
        //将数据加入到数组中
        [self.stores addObjectsFromArray:responseObject];
        
        //刷新表格
        [self.tableView reloadData];
        
        //成功刷新后，结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        //更新页码
        self.page = page;
        JKLog(@"%ld",page);
        
    } Failure:^(id  _Nullable error) {
        
        //判断是否为最新的一次请求参数，不是的话，立即返回；
        if (self.params != params) return;
        
        //刷新失败后，结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


#pragma mark - tableViewDataSouce

//首页传值到本控制器
- (void)indexViewController:(LKIndexViewController *)viewController didClickBtnWithArray:(NSMutableArray *)stores
{
    self.stores = stores;
    
    [self.tableView reloadData];
}

- (void)setUpTableView
{
    self.tableView.dataSource = self;
//    self.tableView.autoresizingMask = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

@end
