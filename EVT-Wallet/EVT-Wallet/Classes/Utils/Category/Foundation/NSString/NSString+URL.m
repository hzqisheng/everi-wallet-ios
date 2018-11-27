//
//  NSString+URL.m
//  Category整理
//
//  Created by 孙俊 on 2018/5/9.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

- (NSURL *)toURL
{
    if (self.length > 0) {
        return [NSURL URLWithString:self];
    }
    return nil;
}

#pragma mark - # 编码
- (NSString *)urlEncode
{
    NSString *urlString = [self urlEncodeUsingEncoding:NSUTF8StringEncoding];
    return urlString;
}

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding
{
    NSString *urlString = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                (__bridge CFStringRef)self,
                                                                                                NULL,
                                                                                                (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                                CFStringConvertNSStringEncodingToEncoding(encoding));
    return urlString;
}

#pragma mark - # 解码
- (NSString *)urlDecode
{
    NSString *urlString = [self urlDecodeUsingEncoding:NSUTF8StringEncoding];
    return urlString;
}

- (NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding
{
    NSString *urlString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                (__bridge CFStringRef)self,
                                                                                                                CFSTR(""),
                                                                                                                CFStringConvertNSStringEncodingToEncoding(encoding));
    return urlString;
}


#pragma mark - # url解析
- (NSDictionary *)dictionaryFromURLParameters
{
    NSArray *pairs = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val = [[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [params setObject:val forKey:[kv objectAtIndex:0]];
    }
    return params;
}


@end
