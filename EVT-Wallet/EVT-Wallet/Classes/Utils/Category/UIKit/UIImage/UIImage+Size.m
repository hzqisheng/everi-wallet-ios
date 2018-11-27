//
//  UIImage+Size.m
//  Category整理
//
//  Created by 孙俊 on 2018/5/10.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "UIImage+Size.h"

@implementation UIImage (Size)

- (UIImage *)scalingToSize:(CGSize)size
{
    CGFloat scale = 0.0f;
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    CGFloat width = size.width;
    CGFloat height = size.height;
    if (CGSizeEqualToSize(self.size, size) == NO) {
        CGFloat widthFactor = size.width / self.size.width;
        CGFloat heightFactor = size.height / self.size.height;
        scale = (widthFactor > heightFactor ? widthFactor : heightFactor);
        width  = self.size.width * scale;
        height = self.size.height * scale;
        y = (size.height - height) * 0.5;
        
        x = (size.width - width) * 0.5;
        
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(x, y, width, height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(newImage == nil) {
        NSLog(@"绘制指定大小的图片失败");
        return self;
    }
    return newImage ;
}

//图片转字符串
- (NSString *)base64Str {
    if (self) {
        NSData *data = [NSData compressImageDataWithImage:self];
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        return encodedImageStr;
    }
    return nil;
}

@end
