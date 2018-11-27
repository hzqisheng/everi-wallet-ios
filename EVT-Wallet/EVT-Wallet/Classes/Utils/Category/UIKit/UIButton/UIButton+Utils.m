//
//  UIButton+Utils.m
//  Category整理
//
//  Created by 孙俊 on 2018/5/10.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "UIButton+Utils.h"

@implementation UIButton (Utils)

+ (UIButton *)buttonWithBackgroundImage:(NSString *)imageName taget:(id)taget action:(SEL)action{
    UIButton * button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithImage:(NSString *)imageName taget:(id)taget action:(SEL)action {
    UIButton * button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)titleFont taget:(id)taget action:(SEL)action {
    UIButton * button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
