//
//  UICollectionViewCell+Extensions.m
//  Category整理
//
//  Created by 孙俊 on 2018/5/10.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "UICollectionViewCell+Extensions.h"

@implementation UICollectionViewCell (Extensions)

- (void)setSelectedBackgrounColor:(UIColor *)selectedBackgrounColor
{
    UIView *selectedBGView = [[UIView alloc] init];
    [selectedBGView setBackgroundColor:selectedBackgrounColor];
    [self setSelectedBackgroundView:selectedBGView];
}

- (UIColor *)selectedBackgrounColor
{
    return self.selectedBackgroundView.backgroundColor;
}

@end
