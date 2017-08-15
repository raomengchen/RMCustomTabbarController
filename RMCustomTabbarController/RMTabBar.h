//
//  RMTabBar.h
//  ECarGroupon
//
//  Created by RaoMeng on 2017/1/18.
//  Copyright © 2017年 TianyingJiuzhou Network Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RMTabBarTag  888888
#define kSuperViewW  self.frame.size.width
#define kSuperViewH  self.frame.size.height
#define kCenterBtnYOffset kCenterItemWidth / 2//中心按钮向上偏移

typedef void(^ClickBlock) (void);

@class RMTabBar;

@protocol RMTabBarDelegate <NSObject>

@optional

//监听 tabBar的点击事件
- (BOOL)tabbar:(RMTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;
//中心按钮点击事件
- (void)tabBarDidClickedCenterButton:(RMTabBar *)tabBar;

@end


@interface RMTabBar : UIView

@property (nonatomic, assign)id<RMTabBarDelegate>delegate;

/**
 创建tabBarButton

 @param item <#item description#>
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;


/**
 创建中间按钮

 @param icon 默认图片
 @param selected 选择图片
 @param title 标题
 @param offset 偏移
 @param block 点击事件
 */
- (void)addCenterBtnWithIcon:(UIImage *)icon selectedIcon:(UIImage *)selected title:(NSString *)title offset:(BOOL)offset clickBlock:(ClickBlock)block;


/**
 设置tabBar的选中索引

 @param index <#index description#>
 */
- (void)selectedButtonWithIndex:(int)index;


@end
