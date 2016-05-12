//
//  LKLocation.h
//  MeGo
//
//  Created by 郑博辰 on 16/5/3.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface LKLocation : NSObject

/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *LKLocationManager;

@end
