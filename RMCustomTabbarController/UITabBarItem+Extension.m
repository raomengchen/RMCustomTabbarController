//
//  UITabBarItem+Extension.m
//  ECarGroupon
//
//  Created by RaoMeng on 2017/1/18.
//  Copyright © 2017年 TianyingJiuzhou Network Technology Co. Ltd. All rights reserved.
//

#import "UITabBarItem+Extension.h"
#import <objc/runtime.h>

const NSString *UITabBarItem_Extension_Key = @"UITabBarItem+Extension";

@implementation UITabBarItem (Extension)

- (void)setOffset:(BOOL)offset{
    
    objc_setAssociatedObject(self, &UITabBarItem_Extension_Key, @(offset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isOffset{
    
    return [objc_getAssociatedObject(self, &UITabBarItem_Extension_Key) boolValue];
}
@end
