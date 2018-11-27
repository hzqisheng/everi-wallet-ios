//
//  UIColor+Gradient.h
//  Category整理
//
//  Created by 孙俊 on 2018/5/10.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Gradient)

/**
 *  渐变颜色
 *
 *  @param fromColor    开始颜色
 *  @param toColor      结束颜色
 *  @param height       渐变高度
 *  @param width       渐变宽度
 *
 *  @return 渐变颜色
 */
+ (UIColor *)gradientColorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor withHeight:(CGFloat)height withWidth:(CGFloat)width;


@end
