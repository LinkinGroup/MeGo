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
    
    [self setUpTableView];
    
    [self loadData];
}

#pragma mark - 初始化表格
- (void)setUpTableView
{
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:LKLocationCellID];

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

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = [self.indexArray objectAtIndex:section];
    
    return key;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
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
    
    lab.text = [NSString stringWithFormat:@"   %@", [self.indexArray objectAtIndex:section]];
    
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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:city forKey:JKCity];
    
    if ([_delegate respondsToSelector:@selector(didSelectedButtonWithCity:)]) {
        [_delegate didSelectedButtonWithCity:city];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
