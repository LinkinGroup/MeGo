//
//  LKLinkageTableView.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/5.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKLinkageTableView.h"

#define cellHeight 44.0;

@interface LKLinkageTableView ()

@end

@implementation LKLinkageTableView

#pragma mark - 初始化
- (id)initWithFrame:(CGRect)frame andLeftItems:(NSArray *)leftItems andRightItems:(NSArray *)RightItems{
    
    frame = [UIScreen mainScreen].bounds;
    
    //    self = [super initWithFrame:CGRectMake(0, STATUS_AND_NAVIGATION_HEIGHT + 40, frame.size.width, frame.size.height - STATUS_AND_NAVIGATION_HEIGHT - 40)];
    
    if (self = [super init]) {
        
        // View的y值为：导航栏 + 状态栏 +按钮高度；
        CGFloat y = 64 + 44;
        
        self.view.frame = CGRectMake(0, y, frame.size.width, frame.size.height - y);
        
#warning 背景颜色
        self.view.backgroundColor = [UIColor colorWithRed:210 green:210 blue:210 alpha:0.6];
        
        // 设置表格父控件的尺寸
        _rootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height * 0.7)];
        
        // 表格底部，用来触发点击隐藏功能
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height / 2, frame.size.width, frame.size.height / 2 - y)];
        
        UITapGestureRecognizer *tapDimissMenu = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideTableView)];
        [bottomView addGestureRecognizer:tapDimissMenu];
        
        _buttonIndex = -1;          // 初始化按钮索引，未选中任何按钮；
        isHidden = YES;             // 初始化时，表格处于隐藏状态；
        _leftItems = leftItems;     // 左边表格数据数组
        _rightItems = RightItems;   // 右边表格数据数组
        
        
        [self initFirstTableViewWithFrame:frame];
        [self initSecondTableViewWithFrame:frame];
        
        // 添加表格的父控件，表格的隐藏触发View;
        [self.view addSubview:_rootView];
        [self.view insertSubview:bottomView belowSubview:_rootView];
//        [self.view addSubview:bottomView];
    }
    
    // 初始化表格状态
    [self.view setHidden:YES];
    
    return self;
}

// 创建左边的表格
- (void)initFirstTableViewWithFrame:(CGRect)frame {
    
    // 创建左边表格
    _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width / 2, frame.size.height *0.7) style:UITableViewStylePlain];
    
    // 设置表格的分隔线
    _firstTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    // 隐藏滚动条
    _firstTableView.showsVerticalScrollIndicator = NO;
    
    // 设置表格的背景颜色
    _firstTableView.backgroundColor = [UIColor lightGrayColor];
    
    // 设置数据源和代理
    _firstTableView.delegate = self;
    _firstTableView.dataSource = self;
    
    // 添加表格
    [_rootView addSubview:_firstTableView];
    //    [_firstTableView reloadData];
}

- (void)initSecondTableViewWithFrame:(CGRect)frame {
    
    // 创建左边表格
    _secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width / 2, 0, frame.size.width, frame.size.height *0.7) style:UITableViewStylePlain];
    
    // 设置表格的分隔线
    //    _secondTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    // 隐藏滚动条
    _firstTableView.showsVerticalScrollIndicator = NO;
    
    // 设置表格的背景颜色
    _secondTableView.backgroundColor = [UIColor whiteColor];
    
    // 设置数据源和代理
    _secondTableView.delegate = self;
    _secondTableView.dataSource = self;
    
    // 添加表格
    [_rootView addSubview:_secondTableView];
}

#pragma mark - 表格代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _firstTableView) {
        
        return _leftArray.count;
        
    } else if (tableView == _secondTableView) {
        
        // 判断索引是否有效；
        if (_rightArray.count > firstSelectedIndex) {
            
            NSArray *array = [_rightArray objectAtIndex:firstSelectedIndex];
            
            return array.count;
            
        } else {
            
            return 0;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (tableView == _firstTableView) {
        
        switch (indexPath.section) {
            case 0:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"FirstCell"];
                
                if (cell == nil) {
                    
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FirstCell"];
                }
                //移除选中时添加的view
                [self removeCellView:cell];
                
                // 判断是否为联动菜单
                if (_leftArray.count > 0) {
                    cell.textLabel.text = [_leftArray objectAtIndex:indexPath.row];
                }
                break;
            }
            default:
                break;
        }
        
        // 为记录选中状态
        UIView *selectView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
        selectView.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = selectView;
        cell.backgroundColor = [UIColor clearColor];
        
    } else if (tableView == _secondTableView){
        
        switch (indexPath.section) {
            case 0:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell"];
                
                if (cell == nil) {
                    
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecondCell"];
                }
                
                [self removeCellView:cell];

                // 根据左边表格中所选出的按钮，取出相应的数组
                NSArray *array = [_rightArray objectAtIndex:firstSelectedIndex];
                
                // 判断数组中是否有值
                if (array.count <= 0) {
                    break;
                }
                
#warning Alternative
                // 从数组中取值，若取出的是数组数据，改为：
                cell.textLabel.text = array[indexPath.row];
                // 若取出的是字典，改为：
//                NSDictionary *dic = [array objectAtIndex:indexPath.row];
//                cell.textLabel.text = [dic valueForKey:@"title"];
                
                //选中后的字体颜色
                cell.textLabel.highlightedTextColor = [UIColor orangeColor];
                break;
            }
            default:
                break;
        }
        
        // 未选中的cell显示的view
        UIView *noSelectView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
        UIView *noSelectLine = [[UIView alloc] initWithFrame:CGRectMake(15, cell.contentView.bounds.size.height-1, cell.contentView.bounds.size.width - 15, 2)];
        
#warning 背景view的颜色
        noSelectLine.backgroundColor = [UIColor clearColor];
        [noSelectView addSubview:noSelectLine];
        
        // cell选中后显示的view
        UIView *selectView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
        UIView *selectLine = [[UIView alloc] initWithFrame:CGRectMake(15, cell.contentView.bounds.size.height-1, cell.contentView.bounds.size.width - 15, 2)];
        selectLine.backgroundColor = [UIColor orangeColor];
        [selectView addSubview:selectLine];
        
        //添加view进cell
        cell.backgroundView = noSelectView;
        cell.selectedBackgroundView = selectView;
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _firstTableView && _leftArray.count > 0) {
        
        firstSelectedIndex = indexPath.row;
        [_secondTableView reloadData];
        
    } else {
        
        [self returnSelectedValue:indexPath.row];
    }
    
}

#pragma mark - 私有方法
// 返回选中位置
- (void)returnSelectedValue:(NSInteger)index
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedFirstValue:SecondValue:)]) {
        
        // 赋值左边表格最后一次选中的索引
        NSInteger firstSelected = firstSelectedIndex;
        
        NSString *firstIndex = [NSString stringWithFormat:@"%ld", firstSelected];
        NSString *indexObj = [NSString stringWithFormat:@"%ld", (long)index];
        
        // 运行时，让代理执行该方法，无论是否声明此方法；
        [self.delegate performSelector:@selector(selectedFirstValue:SecondValue:) withObject:firstIndex withObject:indexObj];
        [self hideTableView];
    }
}


//删除cell中的view
- (void)removeCellView:(UITableViewCell*)cell {
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
}

//显示下拉菜单
- (void)showTableView:(NSInteger)index WithSelectedLeft:(NSString *)left Right:(NSString *)right
{
    // 判断菜单是否已隐藏 || 判断要点击的按钮的索引是否还未点击过；
    if (isHidden == YES || _buttonIndex != index) {
        
        _buttonIndex = index;
        isHidden = NO;
        self.view.alpha = 1.0;
        [self.view setHidden:NO];
        
        // 刷新数据
        [self reloadTableViewData:index];
        [self showSingleOrDouble];
        [self showLastSelectedLeft:left Right:right];
        
        _rootView.center = CGPointMake(self.view.frame.size.width / 2, 0 - _rootView.bounds.size.height / 2);
        [UIView animateWithDuration:0.5 animations:^{
            _rootView.center = CGPointMake(self.view.frame.size.width / 2, _rootView.bounds.size.height / 2);
        }];
    } else {
        [self hideTableView];
    }
}

//按了不同按钮,刷新菜单数据
- (void)reloadTableViewData:(NSInteger)index {
    
    _leftArray = [[NSArray alloc] initWithArray:[_leftItems objectAtIndex:index]];
    _rightArray = [[NSArray alloc] initWithArray:[_rightItems objectAtIndex:index]];
}

- (void)showSingleOrDouble {
    if (_leftArray.count <= 0) {
        [_firstTableView setHidden:YES];
        _secondTableView.frame = CGRectMake( 0, 0, LKScreenSize.width, LKScreenSize.height *0.7);
    } else {
        [_firstTableView setHidden:NO];
        _secondTableView.frame = CGRectMake(LKScreenSize.width / 2, 0, LKScreenSize.width, LKScreenSize.height *0.7);
    }
}

//渐渐隐藏菜单
#warning 可修改此处
- (void)hideTableView {
    
    isHidden = YES;
    [UIView animateWithDuration:0.2 animations:^{
        self.view.alpha = 0.0;
    } completion:^(BOOL finish){
        [self.view setHidden:YES];
        _rootView.center = CGPointMake(self.view.frame.size.width / 2, 0 - _rootView.bounds.size.height *0.7);
        
        
        // 要传递的参数；
        NSString *obj = [NSString stringWithFormat:@"%ld",(long)_buttonIndex];
        
        // 通知方法
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideMenu" object:obj];
        
        // 代理方法
        if (self.delegate && [self.delegate respondsToSelector:@selector(hideMenuWithButtonIndex:)]) {
            
            [self.delegate hideMenuWithButtonIndex:obj];
        }
    }];
}

//显示最后一次选中位置
- (void)showLastSelectedLeft:(NSString *)leftSelected Right:(NSString *)rightSelected
{
    
    NSInteger left = [leftSelected intValue];
    
    if (_leftArray.count > 0) {
        
        [_firstTableView reloadData];
        NSIndexPath *leftSelectedIndexPath = [NSIndexPath indexPathForRow:left inSection:0];
        [_firstTableView selectRowAtIndexPath:leftSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    firstSelectedIndex = left;
    
    NSInteger right = [rightSelected intValue];
    [_secondTableView reloadData];
    NSIndexPath *rightSelectedIndexPath = [NSIndexPath indexPathForRow:right inSection:0];
    [_secondTableView selectRowAtIndexPath:rightSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

@end
