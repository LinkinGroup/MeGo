//
//  LKCollectionItemModel.h
//  MeGo
//
//  Created by 郑博辰 on 16/6/10.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKCollectionItemModel : NSObject

/** text*/
@property (nonatomic, strong) NSString *text;

/** 记录选中状态*/
@property (nonatomic, assign, getter=isSelectedItem) BOOL selectedItem;

@end
