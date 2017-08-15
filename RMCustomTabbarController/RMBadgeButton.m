//
//  RMBadgeButton.m
//  ECarGroupon
//
//  Created by RaoMeng on 2017/1/18.
//  Copyright © 2017年 TianyingJiuzhou Network Technology Co. Ltd. All rights reserved.
//

#import "RMBadgeButton.h"

@implementation RMBadgeButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
//        [self setBackgroundImage:[UIImage resizedImageWithName:@"tabbar_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue {
    
    _badgeValue = badgeValue;
    
    if (badgeValue.intValue > 99) {
        badgeValue = @"99+";
    } else if (badgeValue.intValue == 0){
        badgeValue = @"";
    }
    
    if (badgeValue && badgeValue.length) {
        self.hidden = NO;
        
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            // 文字的尺寸
            CGSize badgeSize = [self getStringSizeWithfont:self.titleLabel.font bound:CGSizeMake(CGFLOAT_MAX, badgeH) lineBreakMode:NSLineBreakByCharWrapping withString:badgeValue];
            badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    } else {
        self.hidden = YES;
    }

    
    
}


//获取字符串的大小size
- (CGSize)getStringSizeWithfont:(UIFont*)font bound:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode withString:(NSString *)string{
    
    CGSize sizeResult = CGSizeZero;
    if ((id) self != [NSNull null] && self != nil){
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        sizeResult = [string sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
        
        }
    return  sizeResult;
}





@end
