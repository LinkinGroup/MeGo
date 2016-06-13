//
//  LKCollectionModel.h
//  TestTest
//
//  Created by 郑博辰 on 16/6/8.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKCollectionModel : NSObject

/** name*/
@property (nonatomic, strong) NSString *name;

/** name*/
@property (nonatomic, strong) NSArray *items;

/** 记录选中状态*/
@property (nonatomic, assign, getter=isSelected) BOOL selected;

@end
