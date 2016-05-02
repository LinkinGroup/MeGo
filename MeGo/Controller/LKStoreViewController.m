//
//  LKStoreViewController.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/21.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKStoreViewController.h"
#import "LKBasedataAPI.h"
#import "LKStoreModel.h"
#import "MJExtension.h"
#import "LKLocalViewController.h"
#import "LKDelicacyStoreCell.h"

#import "LKPopUpMenu.h"


@interface LKStoreViewController ()<UITableViewDataSource, UITableViewDelegate>

/** 记录工具栏按钮状态*/
@property (nonatomic, strong) UIButton *selectedBtn;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 帖子数据 */
@property (nonatomic, strong) NSMutableArray *cities;

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
    
}



#pragma mark - menu

- (IBAction)aroundClick:(UIButton *)sender
{
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
}

#pragma mark - 测试API
- (void)click
{
    
    [LKBasedataAPI findDelicacyStoreSuccess:^(id responseObject) {
        
        JKLog(@"%@",responseObject);
        
//        将plist文件写至桌面，以便确认参数；
//                [responseObject writeToFile:@"/Users/LinK/Desktop/DelicacyStore.plist" atomically:YES];
        
    } failure:^(id error) {
        
        JKLog(@"%@",error);
    }];
}

#pragma mark - tableViewDataSouce

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
