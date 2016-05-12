//
//  LKMenuDataProcessing.h
//  MeGo
//
//  Created by 郑博辰 on 16/5/10.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LKMenuDataProcessingDelegate <NSObject>

@optional
- (void)returnMenuDataWithTitles:(NSArray *)titles LeftArray:(NSArray *)leftArray RightArray:(NSArray *)rightArray;

@end


@interface LKMenuDataProcessing : NSObject

/** 代理属性*/
@property (nonatomic, weak) id<LKMenuDataProcessingDelegate> delegate;

/** titles*/
@property (nonatomic, strong) NSArray *titles;

/**
 * 返回最标准的完整菜单；
 */
//+ (NSMutableDictionary *)menuDataWithTitle:(NSString *)title;

- (instancetype)initMenuDataWithTitle:(NSString *)title;

@end
