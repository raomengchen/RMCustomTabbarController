//
//  RMTabBarViewController.h
//  ECarGroupon
//
//  Created by RaoMeng on 2017/1/18.
//  Copyright © 2017年 TianyingJiuzhou Network Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMTabBar.h"

@interface RMTabBarViewController : UITabBarController


//添加中心按钮：特殊样式、Modal...（子类调用）
- (void)addCenterItemWithIcon:(NSString *)iconName selectedIcon:(NSString *)selectedIconName title:(NSString *)title offset:(BOOL)offset clickBlock:(ClickBlock)block;
/**
 *  初始化一个子控制器
 *
 *  @param childVc               需要初始化的子控制器
 *  @param navigationController  导航控制器
 *  @param title                 标题
 *  @param imageName             图标
 *  @param selectedImageName     选中的图标
 *  @param offset                是否突出偏移
 */
- (UIViewController *)setupChildViewController:(UIViewController *)childVc navigationController:(Class)navigationController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName offset:(BOOL)offset;

@end
