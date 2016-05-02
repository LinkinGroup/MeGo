//
//  LKLocationModel.h
//  MeGo
//
//  Created by 郑博辰 on 16/4/25.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKLocationModel : NSObject

/** 商区*/
@property (nonatomic, copy) NSString *district_name;
/** 附近*/
@property (nonatomic, strong) NSArray *neighborhoods;

@end
