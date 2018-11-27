//
//  UIBarButtonItem+Actions.h
//  Category整理
//
//  Created by 孙俊 on 2018/5/10.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SJBarButtonActionBlock)(void);

@interface UIBarButtonItem (Actions)

+ (instancetype)fixItemSpace:(CGFloat)space;

/**
 * 只有图片的返回按钮
 */
- (instancetype)initWithImage:(NSString *)imageName actionBlock:(SJBarButtonActionBlock)actionBlock;

/**
 * 只有返回文字的返回按钮
 */
- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)color actionBlock:(SJBarButtonActionBlock)actionBlock;

- (instancetype)initWithImage:(UIImage *)image target:(id)target action:(SEL)action;

- (instancetype)initWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;

@end
