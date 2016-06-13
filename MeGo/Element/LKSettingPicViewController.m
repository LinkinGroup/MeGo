//
//  LKSettingPicViewController.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/25.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKSettingPicViewController.h"
#import <FlatUIKit/FlatUIKit.h>


@interface LKSettingPicViewController ()

@end

@implementation LKSettingPicViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.backgroundColor = JKGlobalBg;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setUpNavigationBar];
}

- (void)setUpNavigationBar
{
    // 导航栏设置
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 200, 40))];
    titleLabel.text = @"图片设置";
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // cell设置
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    FUISwitch *switchView = [[FUISwitch alloc] initWithFrame:CGRectMake(0, 0, 72, 36)];
    cell.accessoryView = switchView;
    
    // 开关控制
    int isOn = [[[NSUserDefaults standardUserDefaults] objectForKey:JKShowPicture] intValue];
    
    switch (isOn) {
            
        case 2:
            
            switchView.on = YES;
            
            break;
        case 1:
            
            switchView.on = NO;
            
        default:
            break;
    }
    
    // switchView设置
    switchView.onColor = [UIColor whiteColor];
    switchView.offColor = [UIColor whiteColor];
    switchView.onBackgroundColor = [UIColor orangeColor];
    switchView.offBackgroundColor = self.tableView.backgroundColor;
    switchView.offLabel.font = [UIFont boldFlatFontOfSize:14];
    switchView.onLabel.font = [UIFont boldFlatFontOfSize:14];
    switchView.switchCornerRadius = 6;
    
    [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    // cell设置
    cell.textLabel.text = @"2G/3G/4G网络下显示图片";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    
    // 给有内容的cell上添加分隔线
    UIView *view = [[UIView alloc] initWithFrame:(CGRectMake(10, cell.height, LKScreenSize.width -10, 1))];
    view.backgroundColor = JKRGBColor(222, 222, 222);
    [cell.contentView addSubview:view];
    
    return cell;
}

- (void)switchChanged:(id)sender
{
    UISwitch* switchControl = sender;
    
    [[NSUserDefaults standardUserDefaults] setObject:@(switchControl.on + 1) forKey:JKShowPicture];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"图片显示设置";
}

@end
