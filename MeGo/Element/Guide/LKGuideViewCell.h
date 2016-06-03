//
//  LKGuideViewCell.h
//  MeGo
//
//  Created by 郑博辰 on 16/6/1.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LKGuideViewCellDelegate <NSObject>

- (void)clickStarBtn;

@end

@interface LKGuideViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

/** 判断是否为最后一行*/
- (void)setUpIndexPath:(NSIndexPath *)indexPath count:(NSInteger)pagesCount;

/** 代理属性*/
@property (weak, nonatomic) id<LKGuideViewCellDelegate> delegate;

@end
