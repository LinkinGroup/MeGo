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
#import "LKCategoryModel.h"
#import <MJExtension.h>
#import "ChineseString.h"
#import "LKUserDefaults.h"


@implementation LKDataProcessing

//地区数据转换
+ (NSMutableArray *)localWithArray:(NSDictionary *)dict
{
    NSMutableArray *modelArray = [NSMutableArray array];
    
    modelArray = [LKLocationModel mj_objectArrayWithKeyValuesArray:[dict[@"cities"] firstObject][@"districts"]];
    
    return modelArray;
}

// 可选城市
+ (NSMutableArray *)cityWithArray:(NSDictionary *)dict
{
    // 热门城市
    NSMutableArray *hotCityArray = [NSMutableArray array];
    // 全部城市数组
    NSMutableArray *cityArray = [NSMutableArray arrayWithArray:dict[@"cities"]];

    // 遍历数组前30条数据，将@“全国“后面到@”其它城市“ 之前的数据，取出到热门城市数组
    for (int i = 0; i < 30; i++) {
        
        if ([cityArray[i] isEqualToString:@"全国"]) {
            
            continue;
            
        }else if ([cityArray[i] isEqualToString:@"其它城市"]) {
            
            // 退出循环；
            i = 30;
            
            break;
        }
        [hotCityArray addObject:cityArray[i]];
    }
    // 遍历数组的前30项，删除类名：全国，其它城市；
    [cityArray removeObject:@"全国" inRange:NSMakeRange(0, 30)];
    [cityArray removeObject:@"其它城市" inRange:NSMakeRange(0, 30)];
    
    // 排列数组，生成索引
    NSMutableArray *indexArray = [ChineseString IndexArray:cityArray];
    NSMutableArray *letterResultArr = [ChineseString LetterSortArray:cityArray];
    
    // 加入热门城市
    [indexArray insertObject:@"热门" atIndex:0];
    [letterResultArr insertObject:hotCityArray atIndex:0];
    
    // 加入GPRS定位城市
    [indexArray insertObject:@"定位" atIndex:0];
    NSArray *GPRSArray = [NSArray arrayWithObjects:[LKUserDefaults objectForKey:JKCurrentCity], nil];
    [letterResultArr insertObject:GPRSArray atIndex:0];
    
    // 生成数组
    NSMutableArray *locationArray = [NSMutableArray arrayWithObjects:indexArray, letterResultArr, nil];
    
    return locationArray;
}

//类型数据转换
+ (NSMutableArray *)categoryWithArray:(NSDictionary *)dict
{
    NSMutableArray *modelArray = [NSMutableArray array];
    
    modelArray = [LKCategoryModel mj_objectArrayWithKeyValuesArray:dict[@"categories"]];
    
    return modelArray;
}

//商户数据转换
+ (NSMutableArray *)storeWithArray:(NSDictionary *)dict
{
    NSMutableArray *modelArray = [NSMutableArray array];
    
    modelArray = [LKDelicacyStoreModel mj_objectArrayWithKeyValuesArray:dict[@"businesses"]];
    
    return modelArray;
}

#pragma mark - 私有方法



@end
