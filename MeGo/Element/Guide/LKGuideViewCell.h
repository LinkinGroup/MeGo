//
//  LKGuideViewCell.h
//  MeGo
//
//  Created by 郑博辰 on 16/6/1.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKGuideViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

/** 判断是否为最后一行*/
- (void)setUpIndexPath:(NSIndexPath *)indexPath count:(NSInteger)pagesCount;

@end
