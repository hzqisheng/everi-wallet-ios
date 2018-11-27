//
//  UIImage+Corner.h
//  QSkindergarten
//
//  Created by SJ on 2018/6/6.
//  Copyright © 2018年 HANGZHOU QISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Corner)

/**
 * @brief image切割圆角
 * @param size 大小
 * @param fillColor 填充颜色
 * @param compelete 返回颜色
 */
- (void)cornerImageWithSize:(CGSize)size
                  fillColor:(UIColor *)fillColor
                  compelete:(void (^)(UIImage *resultImage))compelete;

@end
