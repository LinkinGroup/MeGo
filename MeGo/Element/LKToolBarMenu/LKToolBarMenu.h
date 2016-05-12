//
//  LKToolBarMenu.h
//  MeGo
//
//  Created by 郑博辰 on 16/5/4.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKToolBarButton.h"
#import "LKLinkageTableView.h"

@protocol LKToolBarMenuDelegate <NSObject>

@optional
- (void)menuSelectedButtonIndex:(NSInteger)index LeftIndex:(NSInteger)left RightIndex:(NSInteger)right;

@end

@interface LKToolBarMenu : UIViewController <LKToolBarButtonDelegate, LKLinkageTableViewDelegate> {
    
    LKToolBarButton *_button;
    LKLinkageTableView *_tableView;
    NSInteger _lastIndex;
    
    NSInteger _buttonSelectedIndex;
    NSMutableArray *_buttonIndexArray;
    
    NSArray *_titles;
    NSArray *_leftArray;
    NSArray *_rightArray;

}

/** 代理属性*/
@property (nonatomic, weak) id<LKToolBarMenuDelegate> delegate;


- (instancetype)initWithMenuFrame:(CGRect)frame;

- (id)initMenuWithButtonTitles:(NSArray*)titles andLeftListArray:(NSArray*)leftArray andRightListArray:(NSArray *)rightArray;

@end
