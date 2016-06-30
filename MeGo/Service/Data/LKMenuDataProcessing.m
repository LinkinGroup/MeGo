//
//  LKMenuDataProcessing.m
//  MeGo
//
//  Created by 郑博辰 on 16/5/10.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKMenuDataProcessing.h"
#import "LKBasedataAPI.h"
#import "LKLocationModel.h"
#import "LKCategoryModel.h"
#import "LKCacheManage.h"
#import "LKCollectionModel.h"
#import "LKCollectionItemModel.h"
#import <MJExtension/MJExtension.h>

@interface LKMenuDataProcessing ()

/** 附近的街区一级菜单数据*/
@property (nonatomic, strong) NSMutableArray *districts;
/** 附近的街区二级菜单数据*/
@property (nonatomic, strong) NSMutableArray *locations;


/** 可选种类一级菜单数据(已做缓存处理)*/
@property (nonatomic, strong) NSMutableArray *categories;
/** 可选种类二级菜单数据(已做缓存处理)*/
@property (nonatomic, strong) NSMutableArray *subcategories;

@end

@implementation LKMenuDataProcessing

- (instancetype)initMenuDataWithTitle:(NSString *)title
{
    if (self = [super init]) {
        
        [self loadLocation];
        [self loadCategory];
        
        // titles;
        self.titles = @[@"附近",
                        title,
                        @"智能排序",
                        @"筛选"];
    }
    return self;
}

#pragma mark - 数据处理
- (void)setUpData
{

    if (self.districts && self.locations && self.categories && self.subcategories) {
        
        // 智能排序数据准备；
        NSMutableArray *sortArray = [LKMenuDataProcessing setUpSortArray];
        
        // 筛选数据准备
        NSMutableArray *filterArray = [LKMenuDataProcessing setUpFilterArray];
        
        // leftArray;
        NSArray *leftArray = [[NSArray alloc] initWithObjects:self.districts,
                              self.categories,
                              [[NSArray alloc] init],
                              filterArray,
                              nil];
        
        
        // rightArray;
        NSArray *rightArray = [[NSArray alloc] initWithObjects:self.locations,
                               self.subcategories,
                               sortArray,
                               [[NSArray alloc] init],
                               nil];

        if ([_delegate respondsToSelector:@selector(returnMenuDataWithTitles:LeftArray:RightArray:)]) {
        [_delegate returnMenuDataWithTitles:self.titles LeftArray:leftArray RightArray:rightArray];
        }
    }
}

#pragma mark - 数据请求
// 加载附近菜单中的数组
- (void)loadLocation
{
    // 创建临时数组，储存遍历出的数据
    NSMutableArray *locations = [NSMutableArray array];
    NSMutableArray *districts = [NSMutableArray array];
    
//    __weak LKMenuDataProcessing *weakSelf = self;
    // self 没有持有此block，无需使用weakSelf;
    // 请求数据
    [LKBasedataAPI findLocationSuccess:^(id responseObject) {
        
        NSArray *locals = responseObject;
        
        for (LKLocationModel *local in locals) {
            
            // 取出一级菜单目录名称
            [districts addObject:local.district_name];
            
            // 取出二级菜单目录名称
            [locations addObject:local.neighborhoods];
            
        }
        self.districts = districts;
        self.locations = locations;

        [self setUpLocationVaule];
        
    } failure:^(id error) {
        
        JKLog(@"%@",error);
    }];
}

- (void)setUpLocationVaule
{
    NSString *firstVaule = @"12";
    NSInteger count = self.districts.count;
    
    for (NSInteger i = 0; i < count; i++) {

        firstVaule = [NSString stringWithFormat:@"全部%@",self.districts[i]];

        [self.locations[i] insertObject:[firstVaule mutableCopy] atIndex:0];
    }
    
    // 附近中的第二个数组；
    [self.districts insertObject:@"热门商区" atIndex:0];
    
    NSArray *array = nil;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:JKCity] isEqualToString:@"北京"]) {
        
        array = [[NSArray alloc] initWithObjects:@"全部商区",@"三里屯", @"中关村",@"望京", @"国贸",@"五道口", @"西单", nil];
    }else{
        array = [[NSArray alloc] initWithObjects:@"全部商区", nil];

    }
    
    [self.locations insertObject:array atIndex:0];
    
    // 附近中的首个数组
    [self.districts insertObject:@"附近" atIndex:0];
    
    NSArray *distanceArray = [[NSArray alloc] initWithObjects:@"附近（智能范围）", @"500米", @"1000米",@"2000米",@"5000米",nil];
    
    [self.locations insertObject:distanceArray atIndex:0];
    
    [self setUpData];
}

// 加载类型菜单中的数组(已做缓存处理)
- (void)loadCategory
{
    NSTimeInterval days = [LKCacheManage checkCalendarByDayWithKey:JKFileTimeForCategory];
    
    // 获取cache
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    // 获取文件的全路径
    NSString *filePathCategory = [cachePath stringByAppendingPathComponent:JKFileCategory];
    
    NSString *filePathSubCategory = [cachePath stringByAppendingPathComponent:JKFileSubCategory];
    
    // 把自定义对象归档
    self.categories = [NSKeyedUnarchiver unarchiveObjectWithFile:filePathCategory];
    
    // 判断缓存是否有值
    if (self.categories && days < 7) {

        self.subcategories = [NSKeyedUnarchiver unarchiveObjectWithFile:filePathSubCategory];
        
        [self setUpData];

        return;
    }
/********************************* 没有缓存时 *********************************/

    // 创建临时数组，储存遍历出的数据
    NSMutableArray *categoriesArray = [NSMutableArray array];
    NSMutableArray *subcategories = [NSMutableArray array];
    
    // 请求数据
    [LKBasedataAPI findCategorySuccess:^(id responseObject) {
        
        NSArray *categories = responseObject;
        
        for (LKCategoryModel *category in categories) {
            
            // 取出一级菜单目录名称
            [categoriesArray addObject:category.category_name];
            
            // 取出二级菜单目录名称
            [subcategories addObject:category.subcategories];
            
        }
        // 数据结构复杂，需要更多变量协助解析
        // 目标数据所在数组
        NSMutableArray *arrayOne = [NSMutableArray array];
        // 目标数据所在数组的上一层数组
        NSMutableArray *arrayTwo = [NSMutableArray array];
        
        for (NSArray *array in subcategories) {
            
            for (NSDictionary *dic in array) {
                
                NSString *asd = dic[@"category_name"];
                [arrayOne addObject:asd];
            }
            [arrayTwo addObject:arrayOne];
            // 初始化arrayOne;
            arrayOne = [NSMutableArray array];
        }
        self.categories = categoriesArray;
        self.subcategories = arrayTwo;
        
//        JKLog(@"%@",arrayTwo);
        [self setUpCategoryVaule];
        
    } failure:^(id error) {
        
        JKLog(@"%@",error);
    }];
}

- (void)setUpCategoryVaule
{
    NSString *firstVaule = @"12";
    NSInteger count = self.categories.count;
    
    for (NSInteger i = 0; i < count; i++) {
        
        firstVaule = [NSString stringWithFormat:@"全部%@",self.categories[i]];
        
        [self.subcategories[i] insertObject:[firstVaule mutableCopy] atIndex:0];
    }
    
    /****************************** 存入缓存(Cache) ******************************/
    // 获取cache
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    // 获取文件的全路径
    NSString *filePathCategory = [cachePath stringByAppendingPathComponent:JKFileCategory];
    
    NSString *filePathSubCategory = [cachePath stringByAppendingPathComponent:JKFileSubCategory];
    
    // 把自定义对象归档
    [NSKeyedArchiver archiveRootObject:self.categories toFile:filePathCategory];
    
    [NSKeyedArchiver archiveRootObject:self.subcategories toFile:filePathSubCategory];
    
    // 标记时间
    [LKCacheManage markTheTimeToKey:JKFileTimeForCategory];
    
    [self setUpData];
}

// 排序数组
+ (NSMutableArray *)setUpSortArray
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"智能排序", @"星级最高", @"评价最好", @"环境最佳", @"服务最佳", @"人气最高", @"离我最近", @"人均最低", @"人均最高", nil];
    
    NSMutableArray *sortArray = [[NSMutableArray alloc] initWithObjects:array, nil];

    return sortArray;
}

// 筛选数组
+ (NSMutableArray *)setUpFilterArray
{
    // 数据
    // Section0
//    NSDictionary *items0Dict0 = [NSDictionary dictionaryWithObjectsAndKeys:@"满减", @"text", nil];
    NSDictionary *items0Dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"团购", @"text", nil];
    
    NSArray *items0ArrayNormal = [NSArray arrayWithObjects:items0Dict1, nil];
    NSMutableArray *items0Array = [LKCollectionItemModel mj_objectArrayWithKeyValuesArray:items0ArrayNormal];
    
    NSMutableDictionary *items0 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"优惠", @"name",  items0Array,  @"items",  nil];
    
    // Section1
    NSDictionary *items1Dict0 = [NSDictionary dictionaryWithObjectsAndKeys:@"预订", @"text", nil];
    
    NSArray *items1ArrayNormal = [NSArray arrayWithObjects:items1Dict0, nil];
    NSMutableArray *items1Array = [LKCollectionItemModel mj_objectArrayWithKeyValuesArray:items1ArrayNormal];
    //        NSArray *items1Array = [NSArray arrayWithObjects:@"预订", nil];
    NSMutableDictionary *items1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"服务", @"name",  items1Array,  @"items",  nil];
    
    // Section2
    NSDictionary *items2Dict0 = [NSDictionary dictionaryWithObjectsAndKeys:@"50以下", @"text", nil];
    NSDictionary *items2Dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"50-100", @"text", nil];
    NSDictionary *items2Dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"100-300", @"text", nil];
    NSDictionary *items2Dict3 = [NSDictionary dictionaryWithObjectsAndKeys:@"300以上", @"text", nil];
    
    NSArray *items2ArrayNormal = [NSArray arrayWithObjects:items2Dict0, items2Dict1, items2Dict2, items2Dict3, nil];
    NSMutableArray *items2Array = [LKCollectionItemModel mj_objectArrayWithKeyValuesArray:items2ArrayNormal];
    
    NSMutableDictionary *items2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"价格", @"name",  items2Array,  @"items",  nil];
    
    NSArray *array = [NSArray arrayWithObjects:items0, items1, items2, nil];
    NSMutableArray *filterArray = [LKCollectionModel mj_objectArrayWithKeyValuesArray:array];

    return filterArray;
}

@end
