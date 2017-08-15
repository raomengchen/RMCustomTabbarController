//
//  UIView+TouchAreaInsets.m
//  ECarGroupon
//
//  Created by RaoMeng on 2017/1/18.
//  Copyright © 2017年 TianyingJiuzhou Network Technology Co. Ltd. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+TouchAreaInsets.h"

@implementation UIView (TouchAreaInsets)

- (UIEdgeInsets)touchAreaInsets
{
    return [objc_getAssociatedObject(self, @selector(touchAreaInsets)) UIEdgeInsetsValue];
}

/**
 *  设置按钮额外热区
 *
 *  @param touchAreaInsets <#touchAreaInsets description#>
 */
- (void)setTouchAreaInsets:(UIEdgeInsets)touchAreaInsets
{
    NSValue *value = [NSValue valueWithUIEdgeInsets:touchAreaInsets];
    objc_setAssociatedObject(self, @selector(touchAreaInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    UIEdgeInsets touchAreaInsets = self.touchAreaInsets;
    CGRect bounds = self.bounds;
    bounds = CGRectMake(bounds.origin.x - touchAreaInsets.left,
                        bounds.origin.y - touchAreaInsets.top,
                        bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
                        bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom);
    return CGRectContainsPoint(bounds, point);
}

@end
