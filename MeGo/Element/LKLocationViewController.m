//
//  LKLocationViewController.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/13.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKLocationViewController.h"
#import "LKBasedataAPI.h"

@interface LKLocationViewController ()

/** 记录Header的数组*/
@property(nonatomic,strong)NSMutableArray *indexArray;

/** 储存城市名称的数组*/
@property(nonatomic,strong)NSMutableArray *letterResultArr;

@end

@implementation LKLocationViewController

static NSString *LKLocationCellID = @"Cell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"城市列表";
    
    [self setUpTableView];
    
    [self setUpNavigation];
    
    [self loadData];
    
}

#pragma mark - 初始化导航栏
- (void)setUpNavigation
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(backToIndexPage)];
    
    [item setImage:[UIImage imageNamed:@"yy_calendar_icon_previous"]];
    
    self.navigationItem.leftBarButtonItem = item;
}

- (void)backToIndexPage
{
    // 设置转场动画
    CATransition *transion = [CATransition animation];
    // 设置转场动画的类型
    transion.type = @"cube";
    // 设置转场动画的方向
    transion.subtype = @"fromTop";
    
    //把动画添加到某个view的图层上
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transion forKey:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 初始化表格
- (void)setUpTableView
{
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:LKLocationCellID];
    
    // 修改索引
//    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexColor = [UIColor orangeColor];
//    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor blackColor];
    self.tableView.sectionIndexMinimumDisplayRowCount = 3;

}

#pragma mark - 载入数据
- (void)loadData
{
    [LKBasedataAPI findCitySuccess:^(id  _Nullable responseObject) {
        
        self.indexArray = responseObject[0];
        
        self.letterResultArr = responseObject[1];

        [self.tableView reloadData];
        
    } failure:^(id  _Nullable error) {
        
        JKLog(@"%@",error);
    }];
}

#pragma mark - Table view data source

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

// 实现viewForHeaderInSection，就不会调用此方法；
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = [self.indexArray objectAtIndex:section];

    return key;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.letterResultArr objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LKLocationCellID];
    
    cell.textLabel.text = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, LKScreenSize.width, 20)];
    
    lab.backgroundColor = [UIColor grayColor];
    
    NSString *textName = [self.indexArray objectAtIndex:section];
    
    if ([textName isEqualToString:@"热门"]) {
        textName = @"热门城市";
    }
    
    lab.text = [NSString stringWithFormat:@"   %@", textName];
    
    lab.textColor = [UIColor whiteColor];
    
    return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 39.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *city = self.letterResultArr[indexPath.section][indexPath.row];
    
    // 保存城市选项
    [[NSUserDefaults standardUserDefaults] setObject:city forKey:JKCity];
    
    if ([_delegate respondsToSelector:@selector(didSelectedButtonWithCity:)]) {
        [_delegate didSelectedButtonWithCity:city];
    }
    
    // 设置转场动画
    CATransition *transion = [CATransition animation];
    // 设置转场动画的类型
    transion.type = @"cube";
    // 设置转场动画的方向
    transion.subtype = @"fromTop";
    
    //把动画添加到某个view的图层上
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transion forKey:nil];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
