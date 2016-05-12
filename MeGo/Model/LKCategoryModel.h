//
//  LKCategoryModel.h
//  MeGo
//
//  Created by 郑博辰 on 16/5/11.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKCategoryModel : NSObject

/** 类型名称*/
@property (nonatomic, copy) NSString *category_name;
/** 类型明细*/
@property (nonatomic, strong) NSMutableArray *subcategories;

@end
