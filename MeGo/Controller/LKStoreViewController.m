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


@interface LKStoreViewController ()

/** 帖子数据 */
@property (nonatomic, strong) NSMutableArray *cities;

@end

@implementation LKStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    btn.frame = CGRectMake(150, 150, 99, 99);
    
    [self.view addSubview:btn];
    
    btn.backgroundColor = [UIColor redColor];
    
    [btn addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)click
{
    LKBasedataAPI *req = [[LKBasedataAPI alloc] init];
    
    NSString *url = @"http://api.dianping.com/v1/metadata/get_regions_with_businesses";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"city"] = @"北京";
    
    [req findBusinessesWithURL:url params:params success:^(id responseObject) {
        
//        self.cities = [LKStoreModel mj_objectArrayWithKeyValuesArray:[responseObject[@"cities"] firstObject][@"districts"]];
        
        self.cities = [responseObject[@"cities"] firstObject][@"districts"];
        
        JKLog(@"%@",self.cities[2]);
        //将plist文件写至桌面，以便确认参数；
//        [responseObject writeToFile:@"/Users/LinK/Desktop/cities.plist" atomically:YES];
        
        
    } failure:^(id error) {
        
        JKLog(@"%@",error);
    }];
     
}

@end
