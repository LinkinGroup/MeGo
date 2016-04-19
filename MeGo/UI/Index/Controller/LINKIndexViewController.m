//
//  LINKIndexViewController.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/19.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LINKIndexViewController.h"
#import "LINKEncryption.h"

#import <AFNetworking.h>

@interface LINKIndexViewController ()



@end

@implementation LINKIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *baseURL = @"http://api.dianping.com/v1/deal/get_all_id_list";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"city"] = @"北京";
    
    NSString *url = [LINKEncryption serializeURL:baseURL params:params];
    
    params[@"sign"] = url;
    
    [[AFHTTPSessionManager manager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        JKLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        JKLog(@"%@",error);
        
    }];

    
        
}

@end
