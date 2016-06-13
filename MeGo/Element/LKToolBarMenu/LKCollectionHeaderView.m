//
//  LKCollectionHeaderView.m
//  TestTest
//
//  Created by 郑博辰 on 16/6/7.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKCollectionHeaderView.h"
#import "UIView+LINKExtension.h"

@interface LKCollectionHeaderView ()

/** label*/
@property (nonatomic, strong) UILabel *label;


@end

@implementation LKCollectionHeaderView

- (void)setText:(NSString *)text
{
    _text = text;
    
    if (!_label) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(0, (self.height - 30)/2, 150, 30))];
        label.textColor = [UIColor grayColor];
        label.text = text;
        label.font = [UIFont fontWithName:@"PingFangSC-regular" size:18];
        [self addSubview:label];
        _label = label;
    }
    _label.text = text;
    
}

@end
