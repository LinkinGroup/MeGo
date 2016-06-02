//
//  LKLocation.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/3.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKLocation.h"

@interface LKLocation ()<CLLocationManagerDelegate>

@end

@implementation LKLocation

- (CLLocationManager *)locationManager
{
    // 创建位置管理者
    _LKLocationManager = [[CLLocationManager alloc] init];
    // 成为代理
    _LKLocationManager.delegate = self;
    
    // 每隔多少米定位一次，与精确度冲突，此项有值，则精确度无效；
    _LKLocationManager.distanceFilter = 100;
    
    /**
     kCLLocationAccuracyBestForNavigation // 最适合导航
     kCLLocationAccuracyBest; // 最好的
     kCLLocationAccuracyNearestTenMeters; // 10m
     kCLLocationAccuracyHundredMeters; // 100m
     kCLLocationAccuracyKilometer; // 1000m
     kCLLocationAccuracyThreeKilometers; // 3000m
     */
    // 精确度越高, 越耗电, 定位时间越长
    _LKLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
    // 前台定位授权(默认情况下,不可以在后台获取位置, 勾选后台模式 location update, 但是 会出现蓝条)
    [_LKLocationManager requestWhenInUseAuthorization];
    
    
    return _LKLocationManager;
}


//开始上传位置信息
- (void)starUpdateLocation
{
    [self.locationManager startUpdatingLocation];

}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //    NSLog(@"定位到了");
    /**
     *  CLLocation 详解
     *  coordinate : 经纬度
     *  altitude : 海拔
     *  course : 航向
     *  speed ; 速度
     */
    
    CLLocation *location = [locations lastObject];
    
    JKLog(@"%f", location.coordinate.latitude);
    
    
    
    
}



@end
