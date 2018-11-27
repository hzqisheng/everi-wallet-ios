//
//  UIImage+Corner.m
//  QSkindergarten
//
//  Created by SJ on 2018/6/6.
//  Copyright © 2018年 HANGZHOU QISHENG. All rights reserved.
//

#import "UIImage+Corner.h"

@implementation UIImage (Corner)

- (void)cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor compelete:(void (^)(UIImage *))compelete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //打开绘图
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        //设置填充颜色
        [fillColor setFill];
        UIRectFill(rect);
        //设置路径
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        [path addClip];
        //绘制图像
        [self drawInRect:rect];
        //取得结果
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //回调
        dispatch_async(dispatch_get_main_queue(), ^{
            if (compelete) {
                compelete(result);
            }
        });
    });
}

@end
