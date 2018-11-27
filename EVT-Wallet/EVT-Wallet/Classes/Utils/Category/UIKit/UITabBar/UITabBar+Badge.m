//
//  UITabBar+Badge.m
//  投融社
//
//  Created by 孙俊 on 2018/2/1.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "UITabBar+Badge.h"
#define TabbarItemNums 4.0

@implementation UITabBar (Badge)

- (void)showBadgeOnItemIndex:(int)index {
    [self showBadgeOnItemIndex:index badgeNumber:0];
}

//显示红点
- (void)showBadgeOnItemIndex:(int)index badgeNumber:(NSInteger)number {
    [self removeBadgeOnItemIndex:index];
    //新建小红点
    UILabel *bview = [[UILabel alloc] init];
    bview.textColor = [UIColor whiteColor];
    bview.font = [UIFont systemFontOfSize:12];
    bview.textAlignment = NSTextAlignmentCenter;
    bview.tag = 888+index;
    bview.clipsToBounds = YES;
    bview.backgroundColor = [UIColor redColor];
    CGRect tabFram = self.frame;
    
    float percentX = (index+0.6)/TabbarItemNums;
    CGFloat x = ceilf(percentX*tabFram.size.width);
    CGFloat y = ceilf(0.1*tabFram.size.height);
    
    if (number == 0) {
        bview.frame = CGRectMake(x, y, 8, 8);
        bview.layer.cornerRadius = 4;
    } else if (number < 10) {
        bview.frame = CGRectMake(x, y, 16, 16);
        bview.layer.cornerRadius = 8;
        bview.text = [NSString stringWithFormat:@"%ld",(long)number];
    } else if (number < 100) {
        bview.frame = CGRectMake(x, y, 25, 20);
        bview.layer.cornerRadius = 10;
        bview.text = [NSString stringWithFormat:@"%ld",(long)number];
    } else {
        bview.frame = CGRectMake(x, y, 35, 20);
        bview.layer.cornerRadius = 10;
        bview.text = @"99+";
    }
    [self addSubview:bview];
    [self bringSubviewToFront:bview];
}

//隐藏红点
- (void)hideBadgeOnItemIndex:(int)index {
    [self removeBadgeOnItemIndex:index];
}

//移除控件
- (void)removeBadgeOnItemIndex:(int)index {
    for (UIView*subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
