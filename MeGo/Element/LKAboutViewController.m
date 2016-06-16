//
//  LKAboutViewController.m
//  MeGo
//
//  Created by 郑博辰 on 16/6/16.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKAboutViewController.h"
#import "LKGuideViewController.h"
#import "LKSharingMegoView.h"

@interface LKAboutViewController ()<UITableViewDataSource, UITableViewDelegate, LKGuideViewDelegate>

/** 顶部图片*/
@property (nonatomic, strong) UIImageView *headerImageView;

/** 表格顶部*/
@property (nonatomic, strong) UIImageView *tableHeaderView;

/** 功能简介控制器*/
@property (nonatomic, strong) LKGuideViewController *gvc;

/** 显示商品数据的表格*/
@property (strong, nonatomic) UITableView *tableView;

@end

static NSString * const LKAboutCellID = @"about";

@implementation LKAboutViewController

- (UIImageView *)headerImageView
{
    if (!_headerImageView) {
        _headerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LKScreenSize.width /6, LKScreenSize.width /6)];
        _headerImageView.center = CGPointMake(LKScreenSize.width /2, LKScreenSize.width /6);
    }
    return _headerImageView;
}

- (UIView *)tableHeaderView
{
    if (!_tableHeaderView) {
        
        _tableHeaderView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,LKScreenSize.width, LKScreenSize.width /3)];
    }
    return _tableHeaderView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.backgroundColor = JKGlobalBg;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setUpTableView];
    
    [self setUpNavigationBar];
}

// 设置tableView
- (void)setUpTableView
{
    // 调整导航栏为不透明后，向下偏移量多出了64，因此减去64；
    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, LKScreenSize.width, LKScreenSize.height - 64)) style:(UITableViewStylePlain)];
        self.tableView.backgroundColor = JKGlobalBg;
//    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //
    [self.view addSubview:self.tableView];
    
    
    // headerView设置
    self.headerImageView.image = [UIImage imageNamed:@"MeGoLogo"];
    [self.tableHeaderView addSubview:self.headerImageView];
    
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    // label设置
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 150, 30))];
    CGFloat y = CGRectGetMaxY(self.headerImageView.frame);
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(LKScreenSize.width /2, (LKScreenSize.width /3 -y)/2 +y);
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    NSString *ver = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    label.text = [NSString stringWithFormat:@"V%@",ver];
    [self.tableHeaderView addSubview:label];
    
}

- (void)setUpNavigationBar
{
    // 导航栏设置
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 200, 40))];
    titleLabel.text = @"MeGo";
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:22];
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    // 导航栏左边按钮
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    [itemLeft setImage:[UIImage imageNamed:@"yy_calendar_icon_previous"]];
    
    self.navigationItem.leftBarButtonItem = itemLeft;
    
}

- (void)back
{
    CATransition *transion=[CATransition animation];
    //设置转场动画的类型
    transion.type=@"cube";
    //设置转场动画的方向
    transion.subtype=@"fromLeft";
    
    //把动画添加到某个view的图层上
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transion forKey:nil];
    
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:LKAboutCellID];
    
    // 加向右箭头
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    //    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    //    cell.detailTextLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    
    // 给有内容的cell上添加分隔线
    UIView *view = [[UIView alloc] initWithFrame:(CGRectMake(10, cell.height, LKScreenSize.width -10, 1))];
    view.backgroundColor = JKRGBColor(222, 222, 222);
    [cell.contentView addSubview:view];
    
    switch (indexPath.row) {
            
        case 0:
            
            cell.textLabel.text = @"审判MeGo";
            break;
            
        case 1:
            cell.textLabel.text = @"功能简介";
            
            break;
            
        case 2:
            cell.textLabel.text = @"分享给好友";
            
            break;
            
        default:
            break;
    }
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 标准代码
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    
    if (sectionTitle == nil) {
        
        return  nil;
    }
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:(CGRectMake(15, 0, 300, 44))];
    
    label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
    label.text = sectionTitle;
    label.textColor = [UIColor darkGrayColor];
    
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 44)];
    //    [sectionView setBackgroundColor:[UIColor blackColor]];
    [sectionView addSubview:label];
    return sectionView;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
            
        case 0:
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/id1120321577?mt=8"]];
            
            break;
            
        case 1:{
            
            LKGuideViewController *gvc = [[LKGuideViewController alloc] init];
            
            [self.navigationController presentViewController:gvc animated:YES completion:^{
                
                gvc.delegate = self;
            }];
            
            self.gvc = gvc;
            
            break;}
            
        case 2:{
            
            LKSharingMegoView *sv = [[LKSharingMegoView alloc] initWithFrame:LKScreenFrame];
            
            [[UIApplication sharedApplication].keyWindow addSubview:sv];
            
            break;}
            
        default:
            break;
    }
}

// guideView 代理方法
- (void)clickStarBtn
{
    [self.gvc dismissViewControllerAnimated:YES completion:^{
        
        // 显示statusBar
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        
    }];
}

@end
