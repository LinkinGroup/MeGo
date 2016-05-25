//
//  LKDelicacyStoreCell.m
//  MeGo
//
//  Created by 郑博辰 on 16/4/29.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKDelicacyStoreCell.h"
#import "LKDelicacyStoreModel.h"
#import <UIImageView+WebCache.h>
#import <CoreLocation/CoreLocation.h>


@interface LKDelicacyStoreCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *starView;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation LKDelicacyStoreCell

- (void)setStore:(LKDelicacyStoreModel *)store
{
    _store = store;    
    
    int status = [[[NSUserDefaults standardUserDefaults] objectForKey:JKNetWorK] intValue];
    int isOn = [[[NSUserDefaults standardUserDefaults] objectForKey:JKShowPicture] intValue];

    if (status == 2 && isOn == 0) {
        
        self.photoImageView.hidden = YES;
        
    }else{
    
        self.photoImageView.hidden = NO;

        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:store.photo_url]];
        
    }
    self.nameLabel.text = store.name;
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@/人", store.avg_price];
    
    self.locationLabel.text = store.regions.lastObject;
    
    self.categoryLabel.text = store.categories.lastObject;
    
    int stars = [store.avg_rating intValue] * 10;
    self.starView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ShopStar%d", stars ]];
    
    // 距离处理
    CGFloat distance = [self distanceFromStore];

    if (distance < 0) { // 没有取得自己的定位信息时
        
        self.distanceLabel.hidden = YES;

    }else if (distance < 1000){
        
        self.distanceLabel.hidden = NO;
        
        self.distanceLabel.text = [NSString stringWithFormat:@"%.0fm", distance];

    }else if (distance >= 1000){
        
        self.distanceLabel.hidden = NO;

        self.distanceLabel.text = [NSString stringWithFormat:@"%.1fkm", (distance / 1000)];

    }
    
}

- (void)awakeFromNib
{
    // Initialization code
}

// 计算距离
- (CGFloat)distanceFromStore
{
    NSArray *location = [[NSUserDefaults standardUserDefaults]objectForKey:JKLocation];
    
    // 判断是否有坐标
    if (!location) {return -1.0;}
    
    CLLocation* curLocation = [[CLLocation alloc] initWithLatitude:[location[0] floatValue] longitude:[location[1] floatValue]];
    
    CLLocation* otherLocation = [[CLLocation alloc] initWithLatitude:self.store.latitude longitude:self.store.longitude];
    
    double distance  = [curLocation distanceFromLocation:otherLocation];
    return distance;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += 3;
    frame.size.height -= 3;
    
    [super setFrame:frame];
}

@end
