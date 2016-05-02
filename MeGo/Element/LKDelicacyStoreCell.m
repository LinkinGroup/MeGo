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


@interface LKDelicacyStoreCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *starView;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end

@implementation LKDelicacyStoreCell

- (void)setStore:(LKDelicacyStoreModel *)store
{
    _store = store;    
    
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:store.photo_url]];
    
    self.nameLabel.text = store.name;
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@/人", store.avg_price];
    
    self.locationLabel.text = store.regions.lastObject;
    
    self.categoryLabel.text = store.categories.lastObject;
    
    int stars = [store.avg_rating intValue] * 10;
    self.starView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ShopStar%d", stars ]];
    
}

- (void)awakeFromNib {
    // Initialization code
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
