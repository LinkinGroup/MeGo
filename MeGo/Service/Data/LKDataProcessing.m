//
//  LKDataProcessing.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/25.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKDataProcessing.h"
#import "LKLocationModel.h"
#import <MJExtension.h>

@implementation LKDataProcessing

+ (NSMutableArray *)localWithArray:(NSDictionary *)dict
{
    NSMutableArray *modelArray = [NSMutableArray array];
    
    modelArray = [LKLocationModel mj_objectArrayWithKeyValuesArray:[dict[@"cities"] firstObject][@"districts"]];
    
    return modelArray;
}

@end
