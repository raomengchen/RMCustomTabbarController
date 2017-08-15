//
//  RMTabBarViewController.m
//  ECarGroupon
//
//  Created by RaoMeng on 2017/1/18.
//  Copyright © 2017年 TianyingJiuzhou Network Technology Co. Ltd. All rights reserved.
//

#import "RMTabBarViewController.h"
#import "UITabBarItem+Extension.h"


@interface RMTabBarViewController ()<RMTabBarDelegate>

/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) RMTabBar *myTabBar;
@property (assign, nonatomic) BOOL observeTag;

@end

@implementation RMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTabBar];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    /// 隐藏底部 TabBar 的上横线
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1) {
            UIImageView *ima = (UIImageView *)view;
            ima.hidden = YES;
        }
    }
}

/**
 *  初始化tabbar
 */
- (void)setupTabBar {
    
    RMTabBar *myTabBar = [[RMTabBar alloc] initWithFrame:self.tabBar.bounds];
    myTabBar.backgroundColor = [UIColor clearColor];
    myTabBar.delegate = self;
    [self.tabBar addSubview:myTabBar];
    [self.tabBar bringSubviewToFront:myTabBar];
    self.myTabBar = myTabBar;
//    self.tabBar.touchAreaInsets = UIEdgeInsetsMake(30, 0, 0, 0); // 设置额外的点击区域
    // KVO 监听属性改变(tabBar的切换)
    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"viewControllers" options:NSKeyValueObservingOptionNew context:nil];
    [self.tabBar addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:nil];

}


/**
 *
 *  子类调用
 *
 *  ＃添加中心按钮（特殊样式、Modal...）
 */
- (void)addCenterItemWithIcon:(NSString *)iconName selectedIcon:(NSString *)selectedIconName title:(NSString *)title offset:(BOOL)offset clickBlock:(ClickBlock)block;
{
    [self.myTabBar addCenterBtnWithIcon:[UIImage imageNamed:iconName] selectedIcon:[UIImage imageNamed:selectedIconName] title:title offset:offset clickBlock:block];
}


//传递tabBarItem
- (void)transmitTabBarItem{
    
    for (UIViewController *subViewControllview in self.viewControllers) {
        [self.myTabBar addTabBarButtonWithItem:subViewControllview.tabBarItem];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"selectedIndex"] && _observeTag) {
        [self.myTabBar selectedButtonWithIndex:[change[@"new"] intValue]];
    } else if ([keyPath isEqualToString:@"viewControllers"])
    {
        //传递 tabBarItem
        [self transmitTabBarItem];
    } else if ([keyPath isEqualToString:@"hidden"])
    {
        [self hideTabBarSubViews];
    }
}



/**
 *  自己定义的tabbar在iOS8 中重叠的情况.就是原本已经移除的UITabBarButton再次出现
 在iOS8 是允许动态添加tabbaritem的
 */
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self hideTabBarSubViews];
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param navigationController 导航控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 *  @param offset            是否突出偏移
 */
- (UIViewController *)setupChildViewController:(UIViewController *)childVc navigationController:(Class)navigationController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName offset:(BOOL)offset{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.offset = offset;
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.selectedImage = selectedImage;
    // 2.包装一个导航控制器
    UINavigationController *naVc = [[navigationController alloc] initWithRootViewController:childVc];
    
    return naVc;
}


#pragma mark - <FUTabBarDelegate>
//监听 tabBar按钮改变
- (BOOL)tabbar:(RMTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to {
    _observeTag = NO; //防止KVO执行多次
//    if (to - RMTabBarTag == 1) {
//        [ECGStatisticalTool statisticsBuyCar];
//    }
//    if (to - RMTabBarTag == 3) {
//        [ECGStatisticalTool statisticsLiveAction];
//    }
//    if (to - RMTabBarTag == 3) {
//        if ([[ECGUserDefaultManager shareCenter] userIsLogin]) {
//            self.selectedIndex = to - RMTabBarTag;
//        }else{
//            ECGLoginViewController *vc = [[ECGLoginViewController alloc] init];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//            [self presentViewController:nav animated:YES completion:nil];
//            return NO;
//        }
//        
//    }else
        self.selectedIndex = to - RMTabBarTag;
    _observeTag = YES;
    
    //删除自带tabBarButton
    [self hideTabBarSubViews];
    return YES;
}


////中心按钮点击事件
//- (void)tabBarDidClickedCenterButton:(FUTabBar *)tabBar
//{
//    /**
//     *  子类去实现
//     */
//}


#pragma mark - 隐藏tabBar
- (void) hideTabBarSubViews{
    
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIControl class]])
        {
            [obj removeFromSuperview];
        }
    }];
}



- (void)dealloc{
    
    [self removeObserver:self forKeyPath:@"selectedIndex" context:nil];
    [self removeObserver:self forKeyPath:@"viewControllers" context:nil];
    [self.tabBar removeObserver:self forKeyPath:@"hidden" context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
