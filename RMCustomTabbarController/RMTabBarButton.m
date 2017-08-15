//
//  RMTabBarButton.m
//  ECarGroupon
//
//  Created by RaoMeng on 2017/1/18.
//  Copyright © 2017年 TianyingJiuzhou Network Technology Co. Ltd. All rights reserved.
//

#import "RMTabBarButton.h"
#import "RMBadgeButton.h"
#import "UITabBarItem+Extension.h"

@interface RMTabBarButton()

/**
 *  提醒数字
 */
@property (nonatomic, strong) RMBadgeButton *badgeButton;

@end

@implementation RMTabBarButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:kFontSize];
        [self setTitleColor:kTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:kTabBarButtonSelectedTitleColor forState:UIControlStateSelected];
        // 添加提醒数字按钮
        self.badgeButton = [[RMBadgeButton alloc] init];
        //距右、上距离不变
        //        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:_badgeButton];
    }
    return self;
}

//去掉高亮状态
- (void)setHighlighted:(BOOL)highlighted{
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * kTabBarButtonImageRatio;
    CGFloat imageY = 3;
    //中心按钮宽等于高
    if (self.item.isOffset) {
        imageH = contentRect.size.width;
        imageY = 0;
    }
    if (!self.item.isOffset && !self.item.title.length)
        return CGRectMake(0, imageY, imageW, contentRect.size.height - imageY * 2);
    else
        return CGRectMake(0, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    //中心按钮，标题的位置应与其他一样
    CGFloat titleY = (self.item.isOffset ? self.superview.frame.size.height : contentRect.size.height) * kTabBarButtonImageRatio + (contentRect.size.height - self.superview.frame.size.height) + 2;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

- (void)setItem:(UITabBarItem *)item {
    
    _item = item;
    // KVO 监听属性改变
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}


/**
 *  监听到某个对象的属性改变了,就会调用
 *
 *  @param keyPath 属性名
 *  @param object  哪个对象的属性被改变
 *  @param change  属性发生的改变
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    // 设置文字
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
    
    // 设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    // 设置提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    // 设置提醒数字的位置
    CGFloat badgeY = 2;
    CGFloat badgeX = self.center.x;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
}



- (void)dealloc{
    
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}

@end
