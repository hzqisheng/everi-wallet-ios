//
//  UIButton+Utils.h
//  Category整理
//
//  Created by 孙俊 on 2018/5/10.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Utils)

+ (UIButton *)buttonWithBackgroundImage:(NSString *)imageName taget:(id)taget action:(SEL)action;

+ (UIButton *)buttonWithImage:(NSString *)imageName taget:(id)taget action:(SEL)action;

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)titleFont taget:(id)taget action:(SEL)action;

@end
