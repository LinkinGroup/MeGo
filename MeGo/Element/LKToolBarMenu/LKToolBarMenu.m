//
//  LKToolBarMenu.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/4.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKToolBarMenu.h"
#import <FlatUIKit.h>

#define LKNavationMaxY -64

@implementation LKToolBarMenu

- (id)initMenuWithButtonTitles:(NSArray*)titles andLeftListArray:(NSArray*)leftArray andRightListArray:(NSArray *)rightArray
{
    if (self = [super init]) {
        
        self.view.frame = CGRectMake(0, LKNavationMaxY - 44, LKScreenSize.width, 108);
        
        // 按钮设置
        _button = [[LKToolBarButton alloc] initWithTitles:titles];
        _button.delegate = self;
        
        // 表格设置
        _tableView = [[LKLinkageTableView alloc] initWithFrame:self.view.bounds andLeftItems:leftArray andRightItems:rightArray];
        _tableView.delegate = self;
        
        // 初始化私有属性
        _titles = titles;
        _leftArray = leftArray;
        _rightArray = rightArray;
        
        
        [self.view addSubview:_tableView.view];
        [self.view addSubview:_button];
        
        // 初始化_buttonIndexArray的对象数量；
        [self initSelectedArray:titles];
        
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:21 options:(UIViewAnimationOptionCurveLinear) animations:^{
            
            self.view.frame = CGRectMake(0, LKNavationMaxY, LKScreenSize.width, 108);
            
        } completion:^(BOOL finished) {
            
            
        }];
        
    }
    return self;
}

- (void)initSelectedArray:(NSArray *)titles
{
    // 设置容量能在很小的程度上减少内存操作中的消耗
    // 注意：虽然设置了容量，但没有内容，所以数组.count为0；
    _buttonIndexArray = [[NSMutableArray alloc] initWithCapacity:titles.count];
    
    NSInteger count = titles.count;
    
    NSString *selected = @"0-0";
    
    for (int i = 0; i<count; i++) {
        
        [_buttonIndexArray addObject:selected];
    }
}

#pragma mark - button代理方法
//button点击代理
- (void)showMenu:(NSInteger)index
{
    _lastIndex = index;
    
    CGRect frame = [UIScreen mainScreen].bounds;
    
    frame.origin.y = LKNavationMaxY;
    
    [self.view setFrame:frame];
    
    _buttonSelectedIndex = index - 10000;
    
    NSString *selected = nil;
    
    // 判断数据有效性
    if (_buttonIndexArray.count > _buttonSelectedIndex){
    
        selected = [_buttonIndexArray objectAtIndex:_buttonSelectedIndex];
    }
    
    NSArray *selectedArray = [selected componentsSeparatedByString:@"-"];
    NSString *left = [selectedArray objectAtIndex:0];
    NSString *right = [selectedArray objectAtIndex:1];
    
    [_tableView showTableView:_buttonSelectedIndex WithSelectedLeft:left Right:right];
}

- (void)hideMenu
{
    [_tableView hideTableView];
}

#pragma mark - tableView代理方法
// 监听tableView的隐藏
- (void)hideMenuWithButtonIndex:(NSString *)btnIndex
{
    // 隐藏菜单时，缩小Menu的尺寸
    [self.view setFrame:CGRectMake(0, LKNavationMaxY, LKScreenSize.width, 108)];
    
    // 调用button的方法，归位相应按钮
    [_button hideMenuWithIndex:btnIndex];
}

- (void)selectedFirstValue:(NSString *)first SecondValue:(NSString *)second
{
    NSString *index = [NSString stringWithFormat:@"%@-%@", first, second];
    
    // 将_buttonIndexArray中对应的值，设置为最后一个显示出来的菜单的索引
    [_buttonIndexArray setObject:index atIndexedSubscript:_buttonSelectedIndex];
    
    [self returnSelectedLeftIndex:first RightIndex:second];
}

- (void)returnSelectedLeftIndex:(NSString *)left RightIndex:(NSString *)right
{
    NSString *buttonIndex = [NSString stringWithFormat:@"%ld",(long)_lastIndex - 10000];
    
    // 生成带有所选按钮文本、已选中的一级菜单内容和二级菜单内容；
    NSDictionary *dic = [self returnSelectedValueWithIndex:buttonIndex Left:left Right:right];
    
    // 获得数据；
    NSString *title = [dic objectForKey:@"title"];
    NSString *leftValue = [dic objectForKey:@"left"];
    NSString *rightValue = [dic objectForKey:@"right"];
    
#warning 是否全部显示所选内容到按钮文本
    // 四个字以上的话，只显示3个...；
    if(rightValue.length>4){
        rightValue=[NSString stringWithFormat:@"%@...",[rightValue substringToIndex:3]];
    }
    
    // 改变按钮文本；
    [self changeButtonTitle:rightValue];
    
#warning Alternative
    //返回下标；如需返回选中值，则删除这三行；
    NSInteger titleInt = [buttonIndex intValue];
    NSInteger leftValueInt = [left intValue];
    NSInteger rightValueInt = [right intValue];
    
    SEL aSelector = @selector(menuSelectedButtonIndex:LeftIndex:RightIndex:);
    
    if([_delegate respondsToSelector:aSelector]) {
        
        NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[[_delegate class] instanceMethodSignatureForSelector:aSelector]];
        
        [inv setSelector:aSelector];
        
        [inv setTarget:_delegate];
        
        [inv setArgument:&titleInt atIndex:2]; //arguments 0 and 1 are self and _cmd respectively, automatically set by NSInvocation
        
        [inv setArgument:&leftValueInt atIndex:3]; //arguments 0 and 1 are self and _cmd respectively, automatically set by NSInvocation
        
        [inv setArgument:&rightValueInt atIndex:4];
        [inv invoke];
    }
}

- (NSDictionary *)returnSelectedValueWithIndex:(NSString *)index Left:(NSString *)left Right:(NSString *)right
{
    // 按钮文本
    NSString *title         = [_titles objectAtIndex:[index intValue]];
    
    // 存放一级菜单的文本内容
    NSArray *leftArray      = [_leftArray objectAtIndex:[index intValue]];
    
    // 初始化一级菜单的文本内容
    NSString *leftValue     = @"null";
    
    // 判断数据有效性
    if (leftArray.count > 0) {
        
        // 根据左边的索引，取出一级菜单中被选中的文本
        leftValue = [leftArray objectAtIndex:[left intValue]];
    }
    
    // 存放二级菜单的数组
    NSArray *rightArray     = [_rightArray objectAtIndex:[index intValue]];
    
    // 通过一级菜单的索引，取出二级菜单的文本数组
    NSArray *rightValueArray= [rightArray objectAtIndex:[left intValue]];
    
#warning 此代码为取出数组中的文本
    // 根据右边的索引，取出二级菜单中被选中的文本
    NSString *rightValue    = [rightValueArray objectAtIndex:[right intValue]];
    
    // 生成字典数据
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:title, @"title", leftValue, @"left", rightValue, @"right", nil];
    
    return dic;
}

// 改变按钮文本
- (void)changeButtonTitle:(NSString *)menu
{
    UIButton *button = (UIButton *)[_button viewWithTag:_lastIndex];
    
    [button setTitle:menu forState:UIControlStateNormal];
}

#pragma mark - collectionView代理方法
- (void)returnCollectionViewSelectedValue:(NSMutableArray *)filterArray
{
    NSString *buttonIndex = [NSString stringWithFormat:@"%ld",(long)_lastIndex - 10000];
    if ([_delegate respondsToSelector:@selector(collectionViewMenuSelectedButtonIndex:Filter:)]) {
        [_delegate collectionViewMenuSelectedButtonIndex:[buttonIndex intValue] Filter:filterArray];
    }
    
    [self changButtonTitleColorWithFilter:filterArray];
}

// 改变筛选按钮的颜色
- (void)changButtonTitleColorWithFilter:(NSMutableArray *)filterArray
{
    UIButton *button = (UIButton *)[_button viewWithTag:_lastIndex];
    
    // 判断是否有值
    if (!filterArray.firstObject) {
        
        [button setTitleColor:[UIColor colorWithWhite:0.45 alpha:1] forState:UIControlStateNormal];
        
    }else {
        
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
}

@end
