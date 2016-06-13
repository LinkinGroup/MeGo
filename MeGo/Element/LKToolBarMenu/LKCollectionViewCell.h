//
//  LKCollectionViewCell.h
//  TestTest
//
//  Created by 郑博辰 on 16/6/8.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LKCollectionItemModel;

@interface LKCollectionViewCell : UICollectionViewCell

/** 模型*/
@property (nonatomic, strong) LKCollectionItemModel *item;

/** text*/
@property (nonatomic, strong) NSString *text;

/** 字体颜色*/
@property (nonatomic, strong) UIColor *textColor;

/** 标签*/
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end
