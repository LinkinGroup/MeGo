//
//  LKSearchingViewController.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/17.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKSearchingViewController.h"
#import "LKStoreViewController.h"

@interface LKSearchingViewController ()<UITextFieldDelegate>

/** 导航栏搜索控件*/
@property (nonatomic, strong) UIImageView *titleView;

@property (nonatomic, strong) UITextField *textField;

@end

@implementation LKSearchingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpTableView];
    
    [self setUpNavigation];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 收起键盘
    [textField resignFirstResponder];

    if ([textField.text isEqualToString:@""]) {
        
        [self backToIndexPage];
        
    }else{
    
    [self pushToStoreViewControllerWithKeyWord:textField.text];
        
    JKLog(@"%@",textField.text);
    }
    return YES;
}

- (void)pushToStoreViewControllerWithKeyWord:(NSString *)keyWord
{
    
    LKStoreViewController *storeVc = [[LKStoreViewController alloc] init];
    
    //设置导航栏标题
    storeVc.title = keyWord;
    
    //隐藏导航栏
    self.hidesBottomBarWhenPushed = YES;
    
    _delegate = storeVc;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
//    params[@"latitude"] = @(self.currentLocation.coordinate.latitude);
//    params[@"longitude"] = @(self.currentLocation.coordinate.longitude);
    params[@"keyword"] = keyWord;
    
    if ([_delegate respondsToSelector:@selector(searchingWithParams:)]) {
        
        [_delegate searchingWithParams:params];
    }
    
    // 添加转场动画
    CATransition *transion = [CATransition animation];
    //设置转场动画的类型
    transion.type = @"cube";
    //设置转场动画的方向
    transion.subtype = @"fromRight";
    
    //把动画添加到某个view的图层上
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transion forKey:nil];
    
    [self.navigationController pushViewController:storeVc animated:NO];
    
    //为了让跳转回来时正常显示tabbar
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - 导航栏设置
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
    
    // 加载搜索控件
    [self setUpNavigationSearchField];

}

// 导航栏搜索功能
- (void)setUpNavigationSearchField
{
    // 设置导航栏搜索控件背景
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, 180, 30))];
    [titleView setImage:[UIImage imageNamed:@"home_topbar_search"]];
    titleView.userInteractionEnabled = YES;
    titleView.layer.cornerRadius = titleView.frame.size.height * 0.5;
    titleView.layer.masksToBounds = YES;
    titleView.layer.borderColor = [UIColor orangeColor].CGColor;
    titleView.layer.borderWidth = 1.5;
    
    // 设置导航栏搜索控件放大镜
    UIImageView *searchView =[[UIImageView alloc] initWithFrame:(CGRectMake(9, 6, 18, 18))];
    [searchView setImage:[UIImage imageNamed:@"home_topbar_icon_search_default"] ];
    [titleView addSubview:searchView];
    
    // 设置导航栏搜索控件占位文字
    UITextField *text = [[UITextField alloc] initWithFrame:(CGRectMake(33, 6, 225, 18))];
    text.placeholder = @"输入商户名、地点";
    [text setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    text.textColor = [UIColor blackColor];
    text.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
    [titleView addSubview:text];
    [text becomeFirstResponder];
    text.keyboardType = UIKeyboardTypeDefault;
    text.returnKeyType = UIReturnKeySearch;
    text.clearButtonMode = UITextFieldViewModeAlways;
    text.delegate = self;
    self.navigationItem.titleView = titleView;
    
    self.textField = text;
    self.titleView = titleView;
    //    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //    textfield.placeholder = @"🔍输入商户名、地点";
    
    // 设置push其他控制器之后显示的返回按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(backToIndexPage)];
    
    [item setImage:[UIImage imageNamed:@"yy_calendar_icon_previous"]];
    
    self.navigationItem.leftBarButtonItem = item;

    [self titleViewAnimation];
}

// 返回首页
- (void)backToIndexPage
{
    [self.textField resignFirstResponder];
    
    // 仿造目标控制器导航栏布局
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:51 options:(UIViewAnimationOptionCurveLinear) animations:^{
        
        [self.titleView setFrame:(CGRectMake(0, 0, 180, 30))];
        
        // 访问偏好设置，查看上次选择的城市
        NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:JKCity];
        
        if (city) {
            
            city = [NSString stringWithFormat:@"     %@ ▽", city];
            
        }else {
            
            city = @"     城市 ▽";
        }
        
        //设置导航栏左侧按钮
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:city style:(UIBarButtonItemStyleDone) target:nil action:nil];
        
    } completion:^(BOOL finished) {
        
        // 添加转场动画
        CATransition *transion = [CATransition animation];
        //设置转场动画的类型
        transion.type = @"fade";
        
        transion.duration = 0.05;
        
        //把动画添加到某个view的图层上
        [[UIApplication sharedApplication].keyWindow.layer addAnimation:transion forKey:nil];
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        
    }];
    
    
    
}

// searchingField动画
- (void)titleViewAnimation
{
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:51 options:(UIViewAnimationOptionCurveLinear) animations:^{
        
        [self.titleView setFrame:(CGRectMake(0, 0, 261, 30))];
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark tableView方法

static NSString * const LKSearchingCellID = @"searching";

- (void)setUpTableView
{
    self.tableView.backgroundColor = JKGlobalBg;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //    self.tableView.autoresizingMask = NO;
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:LKSearchingCellID];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LKSearchingCellID];
    
    return cell;
}

@end
