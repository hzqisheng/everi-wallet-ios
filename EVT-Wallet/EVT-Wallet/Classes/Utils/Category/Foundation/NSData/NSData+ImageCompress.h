//
//  NSData+ImageCompress.h
//  投融社
//
//  Created by 孙俊 on 2017/11/29.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ImageCompress)

+ (NSData *)compressImageDataWithImage:(UIImage *)image;

@end
