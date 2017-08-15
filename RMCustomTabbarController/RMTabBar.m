//
//  RMTabBar.m
//  ECarGroupon
//
//  Created by RaoMeng on 2017/1/18.
//  Copyright © 2017年 TianyingJiuzhou Network Technology Co. Ltd. All rights reserved.
//

#import "RMTabBar.h"
#import "RMTabBarButton.h"
#import "UITabBarItem+Extension.h"


@interface RMTabBar()

{
    ClickBlock _clickBlock;
}
/**
 *  存储创建的 tabBarButton
 */
@property (nonatomic, strong) NSMutableArray *tabBarButtons;
/**
 *  当前选中的 button
 */
@property (nonatomic, weak) UIButton *selectedButton;
/**
 *  添加的中心按钮
 */
@property (nonatomic, weak) RMTabBarButton *plusButton;
@property (assign, nonatomic,getter=isOffset) BOOL offset;

@end

@implementation RMTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSMutableArray *)tabBarButtons{
    
    if (!_tabBarButtons){
        
        self.tabBarButtons = [@[] mutableCopy];
    }
    return _tabBarButtons;
}

- (void)addCenterBtnWithIcon:(UIImage *)icon selectedIcon:(UIImage *)selected title:(NSString *)title offset:(BOOL)offset clickBlock:(ClickBlock)block{
    
    _offset = offset;
    _clickBlock = block;
    RMTabBarButton *plusButton = [[RMTabBarButton alloc] init];
    [plusButton addTarget:self action:@selector(centerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UITabBarItem *plusItem = [[UITabBarItem alloc] initWithTitle:title image:icon selectedImage:selected];
    plusItem.offset = offset;
    plusButton.item = plusItem;
    
    plusButton.bounds = CGRectMake(0, 0, kCenterItemWidth, kSuperViewH + (offset ? kCenterBtnYOffset : 0));
    [self addSubview:plusButton];
    self.plusButton = plusButton;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item{
    
    RMTabBarButton *tabBarButton = [[RMTabBarButton alloc] init];
    [self addSubview:tabBarButton];
    [self.tabBarButtons addObject:tabBarButton];
    //设置数据
    tabBarButton.item = item;
    [tabBarButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    //默认选中第0个按钮
    if (self.tabBarButtons.count == 1){
        
        [self buttonClick:tabBarButton];
    }
}

//监听事件
- (void)buttonClick:(RMTabBarButton *)button{
    BOOL isSelect = YES;
    
    // 增加点击动画 
    [self addScaleAnimationOnView:button.imageView];
//    [self addRotateAnimationOnView:button.imageView];
    [self addYAnimationOnView:button.imageView];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabbar:didSelectedButtonFrom:to:)]){
         isSelect = [self.delegate tabbar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    if (isSelect) {
        self.selectedButton.selected = NO;
        button.selected = YES;
        self.selectedButton = button;
    }
}


//设置tabBar的选中索引
- (void)selectedButtonWithIndex:(int)index{
    
    for (int i = 0; i < self.tabBarButtons.count; i++){
        
        RMTabBarButton *button = self.tabBarButtons[i];
        if (i == index){
            
            [self buttonClick:button];
        }
    }
}


- (void)centerButtonClick{
    
    if (_clickBlock) {
        _clickBlock();
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarDidClickedCenterButton:)]){
        [self.delegate tabBarDidClickedCenterButton:self];
    }
}



//布局
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat buttonEvenW = kSuperViewW / self.subviews.count;
    CGFloat buttonW,buttonY,buttonH;
    
    NSInteger tabBarButtonCount = self.tabBarButtons.count;
    
    for (int i = 0; i < tabBarButtonCount; i++){
        //取出按钮
        RMTabBarButton *button = self.tabBarButtons[i];
        if (button.item.isOffset) {
            buttonY = -kCenterBtnYOffset;
            buttonH = kSuperViewH + kCenterBtnYOffset;
            buttonW = kCenterItemWidth;
        } else{
            
            buttonY = 0;
            buttonW = buttonEvenW;
            buttonH = kSuperViewH;
        }
        
        CGFloat buttonX = buttonEvenW * i + (buttonEvenW - buttonW) * 0.5;
        //中心按钮
        if (self.plusButton && i >= tabBarButtonCount / 2){
            
            buttonX += buttonEvenW;
        }
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.tag = RMTabBarTag + i;
    }
    
    //中心按钮(模态)
    CGFloat centerX = kSuperViewW * 0.5 - (buttonEvenW / 2) * (tabBarButtonCount % 2);
    CGFloat centerY = self.isOffset ?  self.plusButton.frame.size.height / 2 - kCenterBtnYOffset : kSuperViewH * 0.5;
    if (tabBarButtonCount % 2)
        self.plusButton.center = CGPointMake(centerX, centerY);
    else
        self.plusButton.center = CGPointMake(kSuperViewW * 0.5, centerY);
}



/**
 子视图超过父视图

 @param point <#point description#>
 @param event <#event description#>
 @return <#return value description#>
 */
- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event {
    UIView * view = [super hitTest:point withEvent:event];
    if (view == nil) {
        for (UIView * subView in self.subviews) {
            // 将坐标系转化为自己的坐标系
            CGPoint tp = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, tp)) {
                view = subView;
            }
        }
    }
    return view;
}


//缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}


- (void)addYAnimationOnView:(UIView *)animationView {
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.25f;
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    shakeAnimation.duration = 0.25f;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:-6];
    shakeAnimation.toValue = [NSNumber numberWithFloat:6];
    shakeAnimation.autoreverses = YES;
    [animationView.layer addAnimation:animation forKey:nil];
}



//旋转动画
- (void)addRotateAnimationOnView:(UIView *)animationView {
    [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}




@end
