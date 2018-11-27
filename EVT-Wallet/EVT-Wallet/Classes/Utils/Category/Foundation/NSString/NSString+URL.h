//
//  NSString+URL.h
//  Category整理
//
//  Created by 孙俊 on 2018/5/9.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)

@property (nonatomic, strong, readonly) NSURL *toURL;

#pragma mark - # 编码
/**
 *  url编码，使用 NSUTF8StringEncoding 格式
 *
 *  @return encode后的字符串
 */
- (NSString *)urlEncode;

/**
 *  url编码
 *
 *  @param encoding 编码模式
 *
 *  @return encode后的字符串
 */
- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;


#pragma mark - # 解码
/**
 *  url解码，使用 NSUTF8StringEncoding 格式
 *
 *  @return decode后的字符串
 */
- (NSString *)urlDecode;

/**
 *  url解码
 *
 *  @param encoding 编码模式
 *
 *  @return decode后的字符串
 */
- (NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding;


#pragma mark - # url解析
/**
 *  将url中的参数转成dic
 */
- (NSDictionary *)dictionaryFromURLParameters;

@end
