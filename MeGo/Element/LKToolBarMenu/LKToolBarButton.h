//
//  LKToolBarButton.h
//  MeGo
//
//  Created by 郑博辰 on 16/5/4.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LKToolBarButtonDelegate <NSObject>

- (void)showMenu:(NSInteger)index;
- (void)hideMenu;

@end


@interface LKToolBarButton : UIView{
    
    NSInteger _count;       //按钮数量
    NSInteger _lastTap;     //最后点击的按钮
    NSString *_lastTapObj;  //最后点击的按钮内容
    UIImage *_image;        //按钮的箭头图片
    BOOL _isButton;         //最后点击的是按钮还是cell
}

@property (nonatomic, strong) UIImageView *buttonImageView;
@property (nonatomic, assign) id<LKToolBarButtonDelegate> delegate;

- (instancetype)initWithTitles:(NSArray *)titles;

/**
 * 专门提供给Menu的方法，用来监听tableView的点击
 */
- (void)hideMenuWithIndex:(NSString *)btnIndex;

@end
