//
//  LKCollectionViewCell.m
//  TestTest
//
//  Created by 郑博辰 on 16/6/8.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKCollectionViewCell.h"
#import "LKCollectionModel.h"
#import "LKCollectionItemModel.h"

@interface LKCollectionViewCell ()

@end

@implementation LKCollectionViewCell

//- (void)setItem:(LKCollectionModel *)item
//{
//    _item = item;
//    
//    self.textLabel.text = item.text;
//    
//    // normal
//    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.backgroundColor = [UIColor clearColor];
//    self.layer.borderWidth = 0.5;
//    self.layer.cornerRadius = 4;
//    
//    // selected
//    UIView *view = [[UIView alloc] initWithFrame:self.frame];
//    view.backgroundColor = [UIColor clearColor];
//    self.selectedBackgroundView = view;
//    
//    if (item.selected == 1) {
////        _item.selected = 1;
//        self.layer.borderColor = [UIColor orangeColor].CGColor;
//        self.layer.borderWidth =5;
//    }
//    
//    
//}
- (void)setItem:(LKCollectionItemModel *)item
{
    _item = item;
    
    self.textLabel.text = item.text;
    
    // 判断是否为选择状态
    if (item.selectedItem) {
        
        // selected
        self.textLabel.textColor = [UIColor orangeColor];
        self.layer.borderColor = [UIColor orangeColor].CGColor;
        self.layer.borderWidth = 5;

    }else{
    
        // normal
        self.textLabel.textColor = [UIColor darkGrayColor];
        
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderWidth = 0.5;
    }
    
    // normal
//    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.backgroundColor = [UIColor clearColor];
//    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 4;
    
    // selected
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    view.backgroundColor = [UIColor clearColor];
//    self.selectedBackgroundView = view;
    
}
//- (void)setText:(NSString *)text
//{
//    _text = text;
//    
//    self.textLabel.text = text;
//    
//        // normal
//        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        self.backgroundColor = [UIColor clearColor];
//        self.layer.borderWidth = 0.5;
//        self.layer.cornerRadius = 4;
//    
//        // selected
//        UIView *view = [[UIView alloc] initWithFrame:self.frame];
//        view.backgroundColor = [UIColor clearColor];
//        self.selectedBackgroundView = view;
//    
////        if (item.selected == 1) {
////    //        _item.selected = 1;
////            self.layer.borderColor = [UIColor orangeColor].CGColor;
////            self.layer.borderWidth =5;
//}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.textLabel.textColor = [UIColor orangeColor];
    self.textLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
