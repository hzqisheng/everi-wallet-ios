//
//  UIImage+QRCode.m
//  QSSmarkPark-iOS
//
//  Created by SJ on 2018/8/29.
//  Copyright © 2018年 QiSheng. All rights reserved.
//

#import "UIImage+QRCode.h"

@implementation UIImage (QRCode)

+ (void)createQRCodeImageForString:(NSString *)string size:(CGFloat)size ans:(void (^)(UIImage *))ans {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
        CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        [qrFilter setValue:stringData forKey:@"inputMessage"];
        [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
        CIImage *image = qrFilter.outputImage;
        
        CGRect extent = CGRectIntegral(image.extent);
        CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
        
        size_t width = CGRectGetWidth(extent) * scale;
        size_t height = CGRectGetHeight(extent) * scale;
        
        CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
        CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
        CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
        CGContextScaleCTM(bitmapRef, scale, scale);
        CGContextDrawImage(bitmapRef, extent, bitmapImage);
        
        CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
        CGContextRelease(bitmapRef);
        CGImageRelease(bitmapImage);
        
        UIImage *ansImage = [UIImage imageWithCGImage:scaledImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            ans(ansImage);
        });
    });
}

@end
