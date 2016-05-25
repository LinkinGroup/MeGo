//
//  LKSettingViewController.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/24.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKSettingViewController.h"
#import "LKSettingPicViewController.h"
#import "LKTmpManage.h"
#import <FlatUIKit/FlatUIKit.h>


@interface LKSettingViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, FUIAlertViewDelegate>

/** 显示商品数据的表格*/
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation LKSettingViewController

static NSString * const LKSettingCellID = @"setting";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tabBarController.tabBar setBackgroundColor:[UIColor whiteColor]];
    
    [self.tableView reloadData];
    
    [self setUpNavigation];
    
    [self setUpTableView];
}

- (void)setUpNavigation
{
    // 设置导航栏是否透明
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // 此方法通常用在栈顶控制器
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置背影颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    // 设置字体颜色
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
    
    // 设置导航栏标题颜色和字体
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 200, 40))];
    titleLabel.text = @"设  置";
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:22];
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    // 设置push其他控制器之后显示的返回按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = item;
}

- (void)setUpTableView
{
    // 调整导航栏为不透明后，向下偏移量多出了64，因此减去64；
    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, LKScreenSize.width, LKScreenSize.height)) style:(UITableViewStylePlain)];
    //    self.tableView.backgroundColor = JKGlobalBg;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//
    [self.view addSubview:self.tableView];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:LKSettingCellID];

}


#pragma mark - TableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:LKSettingCellID];
    
    // 加向右箭头
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
//    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
//    cell.detailTextLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    
    // 给有内容的cell上添加分隔线
    UIView *view = [[UIView alloc] initWithFrame:(CGRectMake(10, cell.height - 1, LKScreenSize.width -10, 1))];
    view.backgroundColor = JKRGBColor(222, 222, 222);
    [cell.contentView addSubview:view];

    switch (indexPath.row) {
            
        case 0:
            
            cell.textLabel.text = @"图片设置";
            break;
            
        case 1:
            cell.textLabel.text = @"清除缓存";
            
//            CGFloat tmpSize = [LKTmpManage checkTmpSize];
//            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fM",tmpSize];
            
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
            
        case 0:
            
            [self.navigationController pushViewController:[[LKSettingPicViewController alloc] initWithStyle:(UITableViewStyleGrouped)] animated:YES];
            
            break;
            
        case 1:{
            
            CGFloat tmpSize = [LKTmpManage checkTmpSize];
            
            NSString *message = nil;
            NSString *cancelTitle = @"取消";
            NSString *clear = @"清除";
            
            if (tmpSize) {
                
                message = [NSString stringWithFormat:@"现有缓存%.1fM\n您确定要清除所有缓存数据吗？",tmpSize];
            }else{
                
                message = @"现在还没有缓存数据";
                cancelTitle = @"OK";
                clear = nil;
            }

            
            FUIAlertView *alert = [[FUIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:clear, nil];
            
            // alertView设置
            alert.titleLabel.textColor = [UIColor cloudsColor];
            alert.titleLabel.font = [UIFont boldFlatFontOfSize:16];
            alert.messageLabel.textColor = [UIColor cloudsColor];
            alert.messageLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
            alert.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
            alert.alertContainer.backgroundColor = [UIColor midnightBlueColor];
//            alert.alertContainer.backgroundColor = [UIColor orangeColor];

            alert.alertContainer.layer.cornerRadius = 6;
            alert.alertContainer.layer.shadowOffset = CGSizeMake(3, 3);
            alert.alertContainer.layer.shadowColor = [UIColor blackColor].CGColor;
            alert.alertContainer.layer.shadowRadius = 6;
            alert.alertContainer.layer.shadowOpacity = 1;

            alert.defaultButtonColor = [UIColor cloudsColor];
            alert.defaultButtonShadowColor = [UIColor asbestosColor];
            alert.defaultButtonFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
            alert.defaultButtonTitleColor = [UIColor asbestosColor];
            
            [alert show];
            
            break;}
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    JKLog(@"%ld",buttonIndex);
    
    switch (buttonIndex) {
            
        case 0:
            
            break;
            
        case 1:
            
            [LKTmpManage clearAllTmp];
            
            [self.tableView reloadData];
            
        default:
            break;
    }
}

@end
