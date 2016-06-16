//
//  LKGuideViewController.m
//  MeGo
//
//  Created by 郑博辰 on 16/6/1.
//  Copyright © 2016年 com.link. All rights reserved.
//

#import "LKGuideViewController.h"
#import "LKGuideViewCell.h"
#import "LKTabbarController.h"

@interface LKGuideViewController ()<LKGuideViewCellDelegate>

@property (nonatomic, assign) CGFloat lastOffsetY;

/** Logo*/
@property (nonatomic, strong) UIImageView *logoView;

/** slogan*/
@property (nonatomic, strong) UIImageView *sloganView;

/** slogan1*/
@property (nonatomic, strong) UIImageView *sloganView1;

/** slogan2*/
@property (nonatomic, strong) UIImageView *sloganView2;

/** imageView1*/
@property (nonatomic, strong) UIImageView *imageView1;

/** imageView2*/
@property (nonatomic, strong) UIImageView *imageView2;

/** storeView1*/
@property (nonatomic, strong) UIImageView *storeView1;

/** storeView2*/
@property (nonatomic, strong) UIImageView *storeView2;

/** storeView3*/
@property (nonatomic, strong) UIImageView *storeView3;

@end

@implementation LKGuideViewController

static NSString * const reuseIdentifier = @"Cell";

// UICollectionViewController层次结构：控制器View 上面UICollectionView
// self.view != self.collectionView

// 1.初始化的时候必须设置布局参数，通常使用系统提供的流水布局UICollectionViewFlowLayout

// 2.cell必须通过注册

// 3.自定义cell

#pragma  mark - 懒加载
- (UIImageView *)logoView
{
    if (!_logoView) {
        _logoView = [[UIImageView alloc] init];
        [self.view addSubview:_logoView];
    }
    return _logoView;
}

- (UIImageView *)sloganView
{
    if (!_sloganView) {
        _sloganView = [[UIImageView alloc] init];
        [self.view addSubview:_sloganView];
    }
    return _sloganView;
}

- (UIImageView *)sloganView1
{
    if (!_sloganView1) {
        _sloganView1 = [[UIImageView alloc] init];
        [self.view addSubview:_sloganView1];
    }
    return _sloganView1;
}

- (UIImageView *)sloganView2
{
    if (!_sloganView2) {
        _sloganView2 = [[UIImageView alloc] init];
        [self.view addSubview:_sloganView2];
    }
    return _sloganView2;
}

- (UIImageView *)imageView1
{
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc] init];
        [self.view addSubview:_imageView1];
    }
    return _imageView1;
}

- (UIImageView *)imageView2
{
    if (!_imageView2) {
        _imageView2 = [[UIImageView alloc] init];
//        [self.view addSubview:_imageView2];
        [self.view insertSubview:_imageView2 belowSubview:_imageView1];
    }
    return _imageView2;
}

- (UIImageView *)storeView1
{
    if (!_storeView1) {
        _storeView1 = [[UIImageView alloc] init];
        [self.view addSubview:_storeView1];
    }
    return _storeView1;
}

- (UIImageView *)storeView2
{
    if (!_storeView2) {
        _storeView2 = [[UIImageView alloc] init];
        [self.view addSubview:_storeView2];
    }
    return _storeView2;
}

- (UIImageView *)storeView3
{
    if (!_storeView3) {
        _storeView3 = [[UIImageView alloc] init];
        [self.view addSubview:_storeView3];
    }
    return _storeView3;
}

#pragma mark - 初始化方法
- (instancetype)init
{
    // 流水布局对象,设置cell的尺寸和位置
    UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // 设置cell的尺寸
    layout.itemSize = LKScreenSize;
    //    // 设置cell之间间距
    layout.minimumInteritemSpacing = 0;
    //    // 设置行距
    layout.minimumLineSpacing = 0;
    //
    //    // 设置每一组的内间距
    //    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    return  [super initWithCollectionViewLayout:layout];
}

#pragma mark - UICollectionView有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


#define XMGPages 4
#pragma mark - 返回第section组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return XMGPages;
}

#pragma mark - 返回每个cell长什么样
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    LKGuideViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 创建需要使用的变量
    NSInteger index = indexPath.item;
    NSString *imageName = nil;
    CGFloat height = LKScreenSize.height;
    CGFloat width = LKScreenSize.width;
    
    switch (index) {
            
        case 0:
            // 背影设置
            imageName = [NSString stringWithFormat:@"GuideBackGround_NoIcon"];
            
            // LOGO设置
            if (self.collectionView.contentOffset.y < 10) {
                
            self.logoView.frame = CGRectMake((width / 2) / 2, height * 0.3, width / 2, width / 4);
                
            self.logoView.image = [UIImage imageNamed:@"MeGo"];
            }
            
            // Slogan设置
            self.sloganView.frame = CGRectMake((width - width / 4) / 2, height * 0.6, width / 4, width / 4);
            self.sloganView.image = [UIImage imageNamed:@"upSlide"];
            break;
            
        case 1:
            // 背影设置
            imageName = [NSString stringWithFormat:@"GuideBackGround2"];
            
            // Slogan1设置
            self.sloganView1.frame = CGRectMake(width *0.05, height * 0.04 + width /4, width *0.9, width *0.18);
            self.sloganView1.image = [UIImage imageNamed:@"slogan1"];
            self.sloganView1.alpha = 0;
            
            // Slogan2设置
            self.sloganView2.frame = CGRectMake(width *0.05, height * 0.04 + width *1.2, width *0.9, width *0.18);
            self.sloganView2.image = [UIImage imageNamed:@"slogan2"];
            self.sloganView2.alpha = 0;

            // 图片1设置：图片右边空白比例为 1:9
            self.imageView1.frame = CGRectMake(width /9 /2 - width /2, height *0.04 + width*0.45, width /2, width *3 /4);
            self.imageView1.image = [UIImage imageNamed:@"location1"];
            
            // 图片2设置
            self.imageView2.frame = CGRectMake(width /9  /2 - width /2, height *0.04 + width*0.45, width /2, width *3 /4);
            self.imageView2.image = [UIImage imageNamed:@"location2"];
            
            break;
            
        case 2:
            // 背影设置
            imageName = [NSString stringWithFormat:@"GuideBackGround2"];
            
            // Slogan设置
            self.sloganView.frame = CGRectMake(width *0.05, height * 0.04 + width /4, width *0.9, width *0.18);
            self.sloganView.image = [UIImage imageNamed:@"slogan3"];
            self.sloganView.alpha = 0;
            
            // storeView设置
            self.storeView2.image = [UIImage imageNamed:@"store2"];
            self.storeView2.alpha = 0;
            self.storeView3.image = [UIImage imageNamed:@"store3"];
            self.storeView3.alpha = 0;
            self.storeView1.image = [UIImage imageNamed:@"store1"];
            self.storeView1.alpha = 0;
            
            break;
            
        case 3:
            // 背影设置
            imageName = [NSString stringWithFormat:@"GuideBackGroundCloudy"];
            
            // Slogan1设置
            self.sloganView1.frame = CGRectMake(width *0.05, height * 0.3 + width / 4 + (height * 0.51 - width *0.4) /2, width *0.9, width *0.15);
            self.sloganView1.image = [UIImage imageNamed:@"sloganLast"];
            self.sloganView1.alpha = 0;
            
            cell.delegate = self;
            
            break;
            
        default:
            break;
    }
    
    cell.image = [UIImage imageNamed:imageName];
    
    // 告诉cell什么时候是最后一行
    [cell setUpIndexPath:indexPath count:XMGPages];
    
    return cell;
    
}

- (void)clickStarBtn
{
    // 跳转到核心界面,push,modal,切换跟控制器的方法
    
    if ([_delegate respondsToSelector:@selector(clickStarBtn)]) {
        [_delegate clickStarBtn];
        return;
    }
    
    JKLog(@"%@",self.tabBarController);
    if (self.tabBarController) {
        [UIApplication sharedApplication].keyWindow.rootViewController = self.tabBarController;
    }else{
        [UIApplication sharedApplication].keyWindow.rootViewController = [[LKTabbarController alloc] init];
    }
    
    CATransition *anim = [CATransition animation];
    anim.duration = 0.5;
    anim.type = @"rippleffect";
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 隐藏statusBar
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

    self.collectionView.bounces = NO;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.pagingEnabled = YES;
    
    // 注册cell
    [self.collectionView registerClass:[LKGuideViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}

// 减速完成
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 用到的变量
    CGFloat y = scrollView.contentOffset.y;
    CGFloat height = LKScreenSize.height;
    CGFloat width = LKScreenSize.width;
    CGFloat oriY = height*0.3;
    CGFloat stWidth = 0;
    CGFloat stHeight = 0;
    CGFloat stWidthSpe = 0;
    CGFloat stHeightSpe = 0;
    
    if (y < height * 0.26) {
        
        // 第一页的效果
        self.logoView.y = oriY - y;
        self.sloganView.alpha = (oriY - y)/oriY;
        self.sloganView1.alpha = 0;
        self.imageView1.x = - width /2;
        self.imageView2.x = - width /2;
        
    }else if (y > height * 0.26 && y < height * 1){
        
        // 处理偏移量跳动过大时导致的图片不能归位；
        self.logoView.y = height *0.04;
         // 处理偏移量跳动过大时导致的图片不能隐藏；
        self.sloganView.alpha = 0;
        
        // 第二页控件逐渐显示
        // 第二页第一个动作逐渐显示
        if (y > height * 0.26 && y < height * 0.63) {
            
            self.sloganView1.alpha = (y -height *0.26) / (height *0.37);
            
            self.imageView1.x = (y -height *0.26) / (height *0.37) * width /2 + (width /9  /2 - width /2) ;
            self.imageView2.x = (y -height *0.26) / (height *0.37) * width /2 + (width /9  /2 - width /2) ;
            
            self.sloganView2.alpha = 0;
            
        }else {
            
            // 第一个动作显示
            self.sloganView1.alpha = 1;
            self.imageView1.x = width /9  /2;
            
            // 第二页第一个动作逐渐显示
            self.sloganView2.alpha = (y -height *0.63) / (height *0.37);
            
            self.imageView2.x = (y -height *0.63) / (height *0.37) * (width /2 - width /9  /2)+ width /9 /2;
        }
        
    }else if (y == height *1){
        
        //第二页控件显示
        self.sloganView2.alpha = 1;
        self.imageView2.x = width /2;
        
    }else if (y > height *1 && y < height * 1.26){
        
        // 第二页的隐藏效果
        self.sloganView1.alpha = (height *1.26 - y) / (height *0.26);
        self.sloganView2.alpha = (height *1.26 - y) / (height *0.26);
        self.imageView1.x = -width /2 + (height *1.26 - y) / (height *0.26) * (width /2 + width /9 /2);
        self.imageView2.x = width - (height *1.26 - y) / (height *0.26) * width /2;
        
        // 第三页控件隐藏
        self.sloganView.alpha = 0;
        self.storeView2.alpha = 0;
        self.storeView3.alpha = 0;
        self.storeView1.alpha = 0;
        
    }else if (y > height * 1.26 && y < height * 2){
        
        // 处理偏移量跳动过大时导致的图片不能归位问题；
        self.sloganView1.alpha = 0;
        self.sloganView2.alpha = 0;
        self.imageView1.x = - width /2;
        self.imageView2.x = width;
        
        // 第三页控件逐渐显示
        self.sloganView.alpha = (y -height *1.26) / (height *0.74);
        self.storeView1.alpha = (y -height *1.66) / (height *0.05);
        self.storeView2.alpha = (y -height *1.26) / (height *0.74);
        self.storeView3.alpha = (y -height *1.46) / (height *0.54);
        
        // 商户图片逐渐放大
        stWidth  = (y -height *1.26) / (height *0.74) * width /2;
        stHeight = (y -height *1.26) / (height *0.74) * width *3 /4;
        self.storeView2.size = CGSizeMake(stWidth, stHeight);
        self.storeView3.size = CGSizeMake(stWidth, stHeight);
        
        // 商户图片逐渐缩小
        stWidthSpe  = pow((y -height *1.66) / (height *0.34), -2) * width /2;
        stHeightSpe = pow((y -height *1.66) / (height *0.34), -2) * width *3 /4;
        self.storeView1.size = CGSizeMake(stWidthSpe, stHeightSpe);
//        self.storeView1.center = CGPointMake(width /2 +width /9 /2, height *0.04 + width*0.825);
        self.storeView1.center = CGPointMake(width /2 +width /9 /2, height - width *0.375 - width *0.025 - width *0.025 );
        self.storeView2.center = CGPointMake(width /4 +width /9 /2, height *0.04 + width*0.825 - width *0.025);
        self.storeView3.center = CGPointMake(width *3 /4 , height *0.04 + width*0.825 + width *0.05 - width *0.025);
        
    }else if (y == height *2){
    
        // 第三页效果显示
        self.sloganView.alpha = 1;
        self.storeView1.alpha = 1;
        self.storeView2.alpha = 1;
        self.storeView3.alpha = 1;
        
        // 商户图片尺寸固定
        stWidth  = width /2;
        stHeight = width *3 /4;
        self.storeView1.size = CGSizeMake(stWidth, stHeight);
        self.storeView2.size = CGSizeMake(stWidth, stHeight);
        self.storeView3.size = CGSizeMake(stWidth, stHeight);
        // 商户图片位置固定
        self.storeView1.center = CGPointMake(width /2 +width /9 /2, height - width *0.375 - width *0.025 - width *0.025 );
        self.storeView2.center = CGPointMake(width /4 +width /9 /2, height *0.04 + width*0.825 - width *0.025);
        self.storeView3.center = CGPointMake(width *3 /4 , height *0.04 + width*0.825 + width *0.05 - width *0.025);
    
    }else if (y > height *2 && y < height * 2.26){
        
        // 第三页的隐藏效果
        self.sloganView.alpha = (height *2.26 - y) / (height *0.26);
        self.storeView1.alpha = (height *2.26 - y) / (height *0.26);
        self.storeView2.alpha = (height *2.26 - y) / (height *0.26);
        self.storeView3.alpha = (height *2.26 - y) / (height *0.26);
        // 商户图片缩小
        stWidth  = (height *2.26 - y) / (height *0.26) * width /2;
        stHeight = (height *2.26 - y) / (height *0.26) * width *3 /4;
        self.storeView1.size = CGSizeMake(stWidth, stHeight);
        self.storeView2.size = CGSizeMake(stWidth, stHeight);
        self.storeView3.size = CGSizeMake(stWidth, stHeight);
        
        self.storeView1.y = height *1 + (height *2.26 - y) / (height *0.26) * (height - width *0.75 - width *0.025 - width *0.025 - height);
        self.storeView2.x = -width /2 + (height *2.26 - y) / (height *0.26) * (width /9 /2 + width /2);
        self.storeView3.x = width *1 - (height *2.26 - y) / (height *0.26) * (width *1 /2);

        // LoGo定位
        self.logoView.y = height *0.04;
        
    }else if (y > height * 2.26 && y < height * 3){
        
        // 第三页隐藏
        self.sloganView.alpha = 0;
        self.storeView1.alpha = 0;
        self.storeView2.alpha = 0;
        self.storeView3.alpha = 0;
        self.storeView1.y = height *1;
        self.storeView2.x = -width /2;
        self.storeView3.x = width *1;
        
        if (y > height * 2.74) {
            
            // LoGo下降
            self.logoView.y = oriY - (height *3 - y);
        }
        // 第四页控件逐渐显示
        self.sloganView1.alpha = (y -height *2.26) / (height *0.74);
        
    }else if (y == height *3){
     
        // LoGo定位
        self.logoView.y = oriY;
        
        self.sloganView1.alpha = 1;
    }
}

@end
