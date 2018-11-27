//
//  UIImage+QRCode.h
//  QSSmarkPark-iOS
//
//  Created by SJ on 2018/8/29.
//  Copyright © 2018年 QiSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCode)

/**
 * @brief 根据字符串 生成对应的二维码
 * @param string 需要生成二维码的字符串
 * @param size   宽高
 */
+ (void)createQRCodeImageForString:(NSString *)string
                              size:(CGFloat)size
                               ans:(void (^)(UIImage *image))ans;

@end
