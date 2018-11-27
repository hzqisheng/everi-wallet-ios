//
//  UIImage+Color.h
//  Category整理
//
//  Created by 孙俊 on 2018/5/10.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 * @brief 生成一个frame大小color颜色的图片
 *
 * @param frame 图片frame
 * @param color 图片颜色
 * @return 生成的图片
 */
+ (UIImage *)imageWithFrame:(CGRect)frame color:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)imageWithColor:(UIColor *)color;

@end
