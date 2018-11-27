//
//  NSData+Gzip.h
//  Category整理
//
//  Created by 孙俊 on 2018/5/9.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Gzip)

/**
 *  GZIP压缩
 *
 *  @param level 压缩级别
 */
- (NSData *)gzippedDataWithCompressionLevel:(float)level;

/**
 *  GZIP压缩 压缩级别 默认-1
 *
 *  @return 压缩后的数据
 */
- (NSData *)gzippedData;

/**
 *  GZIP解压
 *
 *  @return 解压后数据
 */
- (NSData *)gunzippedData;

- (BOOL)isGzippedData;

@end
