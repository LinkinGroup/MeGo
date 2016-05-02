//
//  LKLocalViewController.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/25.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKLocalViewController.h"
#import "LKBasedataAPI.h"
#import "LKlocationModel.h"

@interface LKLocalViewController ()<UITableViewDataSource, UITableViewDelegate>

/** 地址信息数组*/
@property (nonatomic, strong) NSArray *locals;

@property (weak, nonatomic) IBOutlet UITableView *distreetTableView;

@property (weak, nonatomic) IBOutlet UITableView *localTableView;

@end

@implementation LKLocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUp];
    
    [self loadDistreet];
    
}

//- (void)presentModalViewController:(UIViewController *)aViewController
//{
//    CATransition *animation = [CATransition animation];
//    [animation setDuration:0.5];
//    [animation setType: kCATransitionPush];
//    [animation setSubtype:kCATransitionFromTop];//从上推入
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
//    [self.navigationController  pushViewController:aViewController animated:NO];
//    [self.view.layer addAnimation:animation forKey:nil];
//}

static NSString * const distreetID = @"distreet";
static NSString * const localID = @"local";

- (void)setUp
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.distreetTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.localTableView.contentInset = self.distreetTableView.contentInset;
    
    self.view.width = LKScreenSize.width;
    self.view.height = LKScreenSize.height *0.6;
    self.view.backgroundColor = LKGlobalBg;
    self.distreetTableView.backgroundColor = LKGlobalBg;
    
    
    [self.distreetTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:distreetID];
    [self.localTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:localID];
    
    
}

- (void)loadDistreet
{
    [LKBasedataAPI findLocationSuccess:^(id responseObject) {
        
        self.locals = responseObject;
        
        [self.distreetTableView reloadData];
        
        [self.distreetTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:(UITableViewScrollPositionTop)];
        
        [self.localTableView reloadData];
        
        //将plist文件写至桌面，以便确认参数；
        //        [responseObject writeToFile:@"/Users/LinK/Desktop/cities.plist" atomically:YES];
        
    } failure:^(id error) {
        
        JKLog(@"%@",error);
    }];

}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.distreetTableView) {
        
        return self.locals.count;
        
    }else{
        
        LKLocationModel *local = self.locals[self.distreetTableView.indexPathForSelectedRow.row];
        
        return local.neighborhoods.count;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.distreetTableView) {
    
        UITableViewCell *cell = [self.distreetTableView dequeueReusableCellWithIdentifier:distreetID];
        
        LKLocationModel *local = self.locals[indexPath.row];
        
        cell.textLabel.text = local.district_name;
        
        cell.backgroundColor = LKGlobalBg;
        
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        
        return cell;
        
    }else{
        
        UITableViewCell *cell = [self.localTableView dequeueReusableCellWithIdentifier:localID];
        
        LKLocationModel *local = self.locals[self.distreetTableView.indexPathForSelectedRow.row];
        
        cell.textLabel.text = local.neighborhoods[indexPath.row];
        
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.distreetTableView) {
        
        [self.localTableView reloadData];
    }
}

@end
