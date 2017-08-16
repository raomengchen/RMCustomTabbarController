//
//  RMTabBarButton.h
//  ECarGroupon
//
//  Created by RaoMeng on 2017/1/18.
//  Copyright © 2017年 TianyingJiuzhou Network Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+HEX.h"

#define kFontSize 11 //文字的大小
#define kCenterItemWidth 60 //centerButton W
#define kTabBarButtonTitleColor hexColor(999999)//StateNormal
#define kTabBarButtonSelectedTitleColor hexColor(333333)//StateSelected
#define kTabBarButtonImageRatio 0.5

@interface RMTabBarButton : UIButton

/**
 *  赋值
 */
@property (nonatomic, strong) UITabBarItem *item;

@end
