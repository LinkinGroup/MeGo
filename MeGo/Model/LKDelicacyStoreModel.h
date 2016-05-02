//
//  LKDelicacyStoreModel.h
//  MeGo
//
//  Created by 郑博辰 on 16/4/29.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKDelicacyStoreModel : NSObject

/** 商户名称 */
@property (nonatomic, copy) NSString *name;

/** 星评图片 */
//@property (nonatomic, copy) NSString *rating_img_url;

/** 地区 取数组中的最后一个*/
@property (nonatomic, strong) NSArray *regions;

/** 平均价格*/
@property (nonatomic, assign) NSNumber *avg_price;

/** 平均评分*/
@property (nonatomic, strong) NSNumber *avg_rating;

/** 分类 取数组中的最后一个*/
@property (nonatomic, strong) NSArray *categories;

/** 图标URL */
@property (nonatomic, copy) NSString *photo_url;

/** 距离 */
@property (nonatomic, assign) NSNumber *distance;



/** URL*/
@property (nonatomic, strong) NSString *business_url;


@end
