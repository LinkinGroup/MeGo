//
//  LKLinkageTableView.h
//  MeGo
//
//  Created by 郑博辰 on 16/5/5.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKCollectionView.h"

@protocol LKLinkageTableViewDelegate <NSObject>

@required

- (void)selectedFirstValue:(NSString *)first SecondValue:(NSString *)second;

- (void)hideMenu;

- (void)hideMenuWithButtonIndex:(NSString *)btnIndex;

@optional

- (void)returnCollectionViewSelectedValue:(NSMutableArray *)filterArray;

@end


@interface LKLinkageTableView : UIViewController<UITableViewDelegate, UITableViewDataSource, LKcollectionViewDelegate> {
    
    UIView *_rootView;              // 添加表格使用
    
    UITableView *_firstTableView;       // 左边表格
    UITableView *_secondTableView;      // 右边表格
    LKCollectionView *_collectionView;  // collectionView
    
    NSArray *_leftItems;            // 左边表格数据数组
    NSArray *_rightItems;           // 右边表格数据数组
    NSArray *_leftArray;            // 左边表格的数据
    NSArray *_rightArray;           // 右边表格的数据
    
    NSInteger firstSelectedIndex;   //左边表格选中的cell的索引
    NSInteger secondSelectedIndex;  //右边表格选中的cell的索引
    
    NSInteger _buttonIndex;         //按钮的索引
    
    BOOL isHidden;                  //表格是否已隐藏
}

@property (nonatomic, strong) id <LKLinkageTableViewDelegate>delegate;

//初始化下拉菜单
- (id)initWithFrame:(CGRect)frame andLeftItems:(NSArray *)leftItems andRightItems:(NSArray *)RightItems;

//显示下拉菜单
- (void)showTableView:(NSInteger)index WithSelectedLeft:(NSString *)left Right:(NSString *)right;

//隐藏下拉菜单
- (void)hideTableView;



@end
