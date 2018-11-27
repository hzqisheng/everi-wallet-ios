//
//  NSData+ImageCompress.m
//  投融社
//
//  Created by 孙俊 on 2017/11/29.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "NSData+ImageCompress.h"

@implementation NSData (ImageCompress)

+ (NSData *)compressImageDataWithImage:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    if (data.length > 100*1024) {
        if (data.length > 1024*1024) {//1M以及以上
            data = UIImageJPEGRepresentation(image, 0.1);
        }else if (data.length > 512*1024) {//0.5M-1M
            data = UIImageJPEGRepresentation(image, 0.5);
        }else if (data.length > 200*1024) {//0.25M-0.5M
            data = UIImageJPEGRepresentation(image, 0.9);
        }
    }
    return data;
}

@end
