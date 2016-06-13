//
//  LKCollectionView.h
//  TestTest
//
//  Created by 郑博辰 on 16/6/7.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LKcollectionViewDelegate <NSObject>

@optional
- (void)didClickConfirmBtnWithParameter:(NSMutableArray *)filterArray;

@end

@interface LKCollectionView : UIView

/** 代理属性*/
@property (nonatomic, weak) id<LKcollectionViewDelegate> delegate;

/** 创建方法*/
- (instancetype)initWithFrame:(CGRect)frame Dict:(NSMutableDictionary *)dict;

/** 根据索引，显示数据*/
- (void)showCollectionViewWithIndex:(NSInteger)index;

@end
