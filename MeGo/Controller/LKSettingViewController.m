//
//  LKSettingViewController.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/24.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKSettingViewController.h"
#import "LKSettingPicViewController.h"
#import "LKCacheManage.h"
#import <FlatUIKit/FlatUIKit.h>
#import "LKTabbarController.h"
#import "LKGuideViewController.h"


@interface LKSettingViewController ()<UITableViewDataSource, UITableViewDelegate,  FUIAlertViewDelegate, LKGuideViewDelegate>

/** 顶部图片*/
@property (nonatomic, strong) UIImageView *headerImageView;

/** 顶部图片*/
@property (nonatomic, strong) UIImageView *headerHudImageView;

/** 表格顶部*/
@property (nonatomic, strong) UIImageView *tableHeaderView;

/** 功能简介控制器*/
@property (nonatomic, strong) LKGuideViewController *gvc;


/** 显示商品数据的表格*/
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation LKSettingViewController

static NSString * const LKSettingCellID = @"setting";

#pragma mark - 懒加载
- (UIImageView *)headerImageView
{
    if (!_headerImageView) {
        _headerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LKScreenSize.width, LKScreenSize.width * 240 / 375)];
        _headerImageView.autoresizingMask=UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _headerImageView.clipsToBounds=YES;
        _headerImageView.contentMode = UIViewContentModeScaleToFill; //UIViewContentModeScaleAspectFill;
    }
    return _headerImageView;
}

- (UIImageView *)headerHudImageView
{
    if (!_headerHudImageView) {
        _headerHudImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LKScreenSize.width, LKScreenSize.width * 240 / 375)];
        _headerHudImageView.autoresizingMask=UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _headerHudImageView.clipsToBounds=YES;
        _headerHudImageView.contentMode = UIViewContentModeScaleToFill; //UIViewContentModeScaleAspectFill;
    }
    return _headerHudImageView;
}

- (UIView *)tableHeaderView
{
    if (!_tableHeaderView) {
        
        _tableHeaderView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,LKScreenSize.width, LKScreenSize.width * 240 / 375)];
    }
    return _tableHeaderView;
}

#pragma mark - 初始化设置
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tabBarController.tabBar setBackgroundColor:[UIColor whiteColor]];
    
    [self.tableView reloadData];
    
    [self setUpNavigation];
    
    [self setUpTableView];
}

// 控制器显示时调用
- (void)viewWillAppear:(BOOL)animated
{
    // 处理tabbar指示器的消失问题
    LKTabbarController *tabbarController = (LKTabbarController *)self.tabBarController;
    
    tabbarController.indicator.hidden = NO;
    
    [self.tabBarController.view bringSubviewToFront:tabbarController.indicator];
    
    [self.tabBarController.view insertSubview:tabbarController.indicator aboveSubview:self.tabBarController.view];
    
    [tabbarController.indicator setFrame:tabbarController.indicator.frame];
    
    // 刷新数据，缓存大小
    [self.tableView reloadData];
    JKLogFunction;

}

- (void)showIndicator
{
    LKTabbarController *tabbarController = (LKTabbarController *)self.tabBarController;
    
    tabbarController.indicator.hidden = NO;
    
    [self.tabBarController.view bringSubviewToFront:tabbarController.indicator];
    
    [tabbarController.indicator setFrame:tabbarController.indicator.frame];
}

// 导航栏初始化
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
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 200, 44))];
    titleLabel.text = @"设  置";
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:22];
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    // 设置push其他控制器之后显示的返回按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = item;
}

// 设置tableView
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
    
    // headerView设置
    self.headerImageView.image = [UIImage imageNamed:@"Flag"];
    self.headerImageView.contentMode = UIViewContentModeScaleToFill;
    [self.tableHeaderView addSubview:self.headerImageView];
    
    // headerHudView设置
    self.headerHudImageView.image = [UIImage imageNamed:@"HudS"];
    self.headerHudImageView.contentMode = UIViewContentModeScaleToFill;
    [self.tableHeaderView addSubview:self.headerHudImageView];
    
    self.tableView.tableHeaderView = self.tableHeaderView;

}


#pragma mark - TableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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
            
#warning 缓存显示开关
            CGFloat cacheSize = [LKCacheManage checkCacheSize];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fM",cacheSize];
            break;
            
        case 2:
            cell.textLabel.text = @"功能简介";
            
            break;
            
        case 3:
            
            cell.textLabel.text = @"审判MeGo";
            
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if (offset.y < 0) {
        CGRect rect = self.tableHeaderView.frame;
        rect.origin.y = offset.y;
        rect.size.height = CGRectGetHeight(rect)-offset.y;
        rect.origin.x += offset.y;
        rect.size.width -= offset.y *2;
        self.headerImageView.frame = rect;
        
//        CGRect rectHud = self.tableHeaderView.frame;
//        rectHud.origin.y = offset.y *4;
//        rectHud.size.height = CGRectGetHeight(rect)-offset.y *5.5;
//        rectHud.origin.x += offset.y *4;
//        rectHud.size.width -= offset.y *8;
        CGRect rectHud = self.tableHeaderView.frame;

        rectHud.size.height = rectHud.size.height * (-offset.y *2) +0.5;
        rectHud.size.width = rectHud.size.width * (-offset.y *2);
        self.headerHudImageView.frame = rectHud;
        self.headerHudImageView.center = self.headerImageView.center;
        self.tableHeaderView.clipsToBounds = NO;
        
    }else {
        // 复位，处理6Plus下拉时Hudview放大后无法归位问题；
        _headerHudImageView.frame=CGRectMake(0, 0, LKScreenSize.width, LKScreenSize.width * 240 / 375);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
            
        case 0:{
            
            //隐藏导航栏
            self.hidesBottomBarWhenPushed = YES;
            
            CATransition *transion=[CATransition animation];
            //设置转场动画的类型
            transion.type=@"cube";
            //设置转场动画的方向
            transion.subtype=@"fromRight";
            
            //把动画添加到某个view的图层上
            [[UIApplication sharedApplication].keyWindow.layer addAnimation:transion forKey:nil];
            
            [self.navigationController pushViewController:[[LKSettingPicViewController alloc] initWithStyle:(UITableViewStyleGrouped)] animated:YES];
            
            //为了让跳转回来时正常显示tabbar
            self.hidesBottomBarWhenPushed = NO;
            
            break;}
            
        case 1:{
            
            CGFloat tmpSize = [LKCacheManage checkCacheSize];
            
            NSString *message = nil;
            NSString *cancelTitle = @"取消";
            NSString *clear = @"清除所有缓存";
            
            if (tmpSize) {
                
                message = [NSString stringWithFormat:@"现有缓存%.1fM\n您确定要清除所有缓存数据吗？",tmpSize];
            }else{
                
                message = @"现在还没有缓存数据";
                cancelTitle = @"OK";
                clear = nil;
            }
            
            FUIAlertView *alert = [[FUIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:clear, @"只清除图片缓存", nil];
            
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
            
        case 2:{
            
            LKGuideViewController *gvc = [[LKGuideViewController alloc] init];
            
            [self.navigationController presentViewController:gvc animated:YES completion:^{
                
                gvc.delegate = self;
            }];
            
            self.gvc = gvc;
            
            break;}
            
        case 3:
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/id1120321577?mt=8"]];
            
            break;
            
        default:
            break;
    }
}

- (void)clickStarBtn
{
    [self.gvc dismissViewControllerAnimated:YES completion:^{
        
        // 显示statusBar
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
            
        case 0:
            
            [self.tableView reloadData];
            
            break;
            
        case 1:
            
            [LKCacheManage clearAllCache];
            
            [self.tableView reloadData];
            
        case 2:
            
            [LKCacheManage clearPics];
            
            [self.tableView reloadData];
            
        default:
            break;
    }
}

@end
