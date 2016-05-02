//
//  LKDataProcessing.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/25.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKDataProcessing.h"
#import "LKLocationModel.h"
#import "LKDelicacyStoreModel.h"
#import <MJExtension.h>

@implementation LKDataProcessing

//地区数据转换
+ (NSMutableArray *)localWithArray:(NSDictionary *)dict
{
    NSMutableArray *modelArray = [NSMutableArray array];
    
    modelArray = [LKLocationModel mj_objectArrayWithKeyValuesArray:[dict[@"cities"] firstObject][@"districts"]];
    
    return modelArray;
}

//商户数据转换
+ (NSMutableArray *)storeWithArray:(NSDictionary *)dict
{
    NSMutableArray *modelArray = [NSMutableArray array];
    
    modelArray = [LKDelicacyStoreModel mj_objectArrayWithKeyValuesArray:dict[@"businesses"]];
    
    return modelArray;
}



@end
