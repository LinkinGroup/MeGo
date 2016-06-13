//
//  LKCollectionView.m
//  TestTest
//
//  Created by 郑博辰 on 16/6/7.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKCollectionView.h"
#import "LKCollectionHeaderView.h"
#import "LKCollectionFooterView.h"
#import "UIView+LINKExtension.h"
#import "LKCollectionViewCell.h"
#import "LKCollectionModel.h"
#import "LKCollectionItemModel.h"
#import <MJExtension/MJExtension.h>

@interface LKCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegate>

/** SelectedItems*/
@property (nonatomic, strong) NSMutableArray *selectedItems;

/** collectionView*/
@property (nonatomic, strong) UICollectionView *collectionView;

/** 数据*/
@property (nonatomic, strong) NSMutableDictionary *filterDict;

/** 索引*/
@property (nonatomic, assign) NSInteger index;


/** 数据*/
@property (nonatomic, strong) NSMutableArray *items;


@end

@implementation LKCollectionView

static NSString * const reuseIdentifier = @"Cell";
static NSString * const CellIdentifier = @"header";
static NSString * const CellIdentifierFooter = @"footer";


#pragma mark - 懒加载
- (NSMutableArray *)selectedItems
{
    if (!_selectedItems) {
        _selectedItems = [NSMutableArray array];
    }
    return _selectedItems;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame Dict:(NSMutableDictionary *)dict
{
    // 储存数据：
    self.filterDict = dict;
    
    // 尺寸计算
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat btnWidth = width *1.25 /6;
    CGFloat marginSum = width /6;
    
    LKCollectionView *view = [super initWithFrame:frame];
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    CGRect aFrame = frame;
    aFrame.size.height -= width/5;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:aFrame collectionViewLayout:flowLayout];
    
    
    view.height += width /5;

//    flowLayout.headerReferenceSize = CGSizeMake(375, 90);
    
    flowLayout.itemSize = CGSizeMake(btnWidth, btnWidth/1.8);
    flowLayout.minimumInteritemSpacing = marginSum *0.16;
    
    
    collectionView.contentInset = UIEdgeInsetsMake(0, marginSum *0.26, 0, marginSum *0.26);
    
    collectionView.bounces = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.allowsMultipleSelection = YES;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    // 注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LKCollectionViewCell class])  bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [collectionView registerClass:[LKCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier];
    
    [collectionView registerClass:[LKCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter  withReuseIdentifier:CellIdentifierFooter];
    
    [view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [self setUpBtnWithFrame:collectionView.frame];
    
    return view;
}

- (void)showCollectionViewWithIndex:(NSInteger)index
{
    if (self.items) {
        
        self.items = [self.filterDict objectForKey:@(index)];

    }else{
        
        self.items = [self.filterDict objectForKey:@(index)];
        
        [self.collectionView reloadData];
    }
}

#pragma mark - 按钮设置
- (void)setUpBtnWithFrame:(CGRect)frame
{
    CGFloat y = CGRectGetMaxY(frame);
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat margin = width /6;
    
    // 背景
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, y, width, width/5)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    // 取消按钮：
    // 创建
    UIButton *cancelBtn = [[UIButton alloc] init];
    cancelBtn.frame = CGRectMake(margin *0.26, 18, (width - margin *0.16)/2 - margin *0.26, width/5-18*2);
    [view addSubview:cancelBtn];
    
    // 文字
    [cancelBtn setTitle:@"重置" forState:(UIControlStateNormal)];
    cancelBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
    
    // 边框
    cancelBtn.layer.borderColor = [UIColor grayColor].CGColor;
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.layer.cornerRadius = (width/5-18*2) /6;
    
    // 颜色
    [cancelBtn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:(UIControlStateHighlighted)];
    [cancelBtn setBackgroundImage:[self imageWithColor:[UIColor grayColor]] forState:(UIControlStateNormal)];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateHighlighted)];
    
    // 调用方法：
    [cancelBtn addTarget:self action:@selector(didClickCancelBtn) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 确定按钮：
    // 创建
    CGFloat conBtnX = (width + margin *0.16) /2;
    UIButton *confirmBtn = [[UIButton alloc] init];
    confirmBtn.frame = CGRectMake(conBtnX, 18, (width - margin *0.16)/2 - margin *0.26, width/5-18*2);
    [view addSubview:confirmBtn];
    
    // 文字
    [confirmBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    confirmBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
    
    // 边框
    confirmBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    confirmBtn.layer.borderWidth = 1;
    confirmBtn.layer.cornerRadius = (width/5-18*2) /6;
    
    // 颜色
    [confirmBtn setBackgroundImage:[self imageWithColor:[UIColor orangeColor]] forState:(UIControlStateNormal)];
    [confirmBtn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:(UIControlStateHighlighted)];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [confirmBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateHighlighted)];
    
    // 调用方法：
    [confirmBtn addTarget:self action:@selector(didClickConfirmBtn) forControlEvents:(UIControlEventTouchUpInside)];
    
}

// 确定已经选中的按钮
- (void)didClickConfirmBtn
{
    NSMutableArray *filterArray = [NSMutableArray array];
    // 遍历已选item, 取消选中状态
    for (NSIndexPath *path in self.selectedItems) {
        
//        LKCollectionViewCell *cell = (LKCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:path];
        
        // 取得模型，改变选择状态
        LKCollectionModel *items = self.items[path.section];
        LKCollectionItemModel *item = items.items[path.row];
        [filterArray addObject:item.text];
    }

    // 通知代理
    if ([_delegate respondsToSelector:@selector(didClickConfirmBtnWithParameter:)]) {
        [_delegate didClickConfirmBtnWithParameter:filterArray];
    }
}

// 取消所有item的选中状态
- (void)didClickCancelBtn
{
    // 遍历已选item, 取消选中状态
    for (NSIndexPath *path in self.selectedItems) {
        
        LKCollectionViewCell *cell = (LKCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:path];
        
        // 取得模型，改变选择状态
        LKCollectionModel *items = self.items[path.section];
        LKCollectionItemModel *item = items.items[path.row];
        item.selectedItem = NO;
        cell.item = item;
    }
    
    // 刷新数据，清空数组
    self.selectedItems = nil;
    [self.collectionView reloadData];
}


#pragma mark - collectionView代理及数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    LKCollectionModel *item = self.items[section];
    return item.items.count;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    LKCollectionModel *items = self.items[indexPath.section];
    LKCollectionItemModel *item = items.items[indexPath.row];
    cell.item = item;
//    if (cell.item.selectedItem == YES) {
////        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:(UICollectionViewScrollPositionNone)];
////        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
//        cell.item.selectedItem = NO;
//        cell.item = item;
////        cell.item.selectedItem = YES;
////        cell.item = item;
//        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:(UICollectionViewScrollPositionNone)];
////        [collectionView reloadData];
//    }
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JKLog(@"select");

    // 取得模型，改变选择状态
    LKCollectionModel *items = self.items[indexPath.section];
    LKCollectionItemModel *item = items.items[indexPath.row];
    LKCollectionViewCell *cell = (LKCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    // 设置价格选项为单选
    if (indexPath.section == 2) {
    
        // 创建变量：
        LKCollectionModel *items = self.items[2];
        NSInteger count = items.items.count;
        LKCollectionItemModel *item = nil;
        LKCollectionViewCell *cell = nil;
        
        NSIndexPath *path = nil;

        // 遍历已选item, 取消选中状态
        for (NSInteger i = 0; i < count; i++) {
            if (i == indexPath.row) {
                continue;
            }
            path = [NSIndexPath indexPathForRow:i inSection:2];
            [collectionView deselectItemAtIndexPath:path animated:NO];
            
            cell = (LKCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:path];
            item = items.items[path.row];
            item.selectedItem = NO;
            cell.item = item;
            cell.selected = NO;
            [self.selectedItems removeObjectsInArray:[NSArray arrayWithObjects:path, nil]];
        }
    }
    
//    item.selectedItem = !item.selectedItem;
    item.selectedItem = YES;

    cell.item = item;
    
    // 记录已选中的item
    if (item.selectedItem == YES) {
        
        [self.selectedItems addObject:indexPath];
        
    }else{
        
        [self.selectedItems removeObjectsInArray:[NSArray arrayWithObjects:indexPath, nil]];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JKLog(@"deselect");

    // 取得模型，改变选择状态
    LKCollectionModel *items = self.items[indexPath.section];
    LKCollectionItemModel *item = items.items[indexPath.row];
    
//    item.selectedItem = !item.selectedItem;
    item.selectedItem = NO;
    
    LKCollectionViewCell *cell = (LKCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.item = item;
    
    // 记录已选中的item
    if (item.selectedItem == YES) {
        
        [self.selectedItems addObject:indexPath];
        
    }else{
        
        [self.selectedItems removeObjectsInArray:[NSArray arrayWithObjects:indexPath, nil]];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(150, 44);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 18);
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:@"UICollectionElementKindSectionFooter"]) {
        LKCollectionFooterView *view  = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CellIdentifierFooter forIndexPath:indexPath];
        view.backgroundColor = [UIColor clearColor];
        
        // 最后一个cell的分隔线加长
        if (indexPath.section  == self.items.count - 1) {
//            UIView *line = [[UIView alloc] initWithFrame:view.frame];
//            view.width = [UIScreen mainScreen].bounds.size.width;
            view.x = -50;
        }
        return view;
    }
    
    //从栈中获取 Headercell
    LKCollectionHeaderView *view  = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    view.text = [self.items[indexPath.section] name];

    return view;
}

#pragma mark - 私有方法

// 私有方法： image转颜色
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
