//
//  NSDate+Transform.h
//  投融社
//
//  Created by 孙俊 on 2017/12/1.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Transform)

/**
 * @brief 时间戳转为字符串
 *
 * @param timestamp 时间戳
 * @param format 转换后的格式
 *
 * @return 转换后的字符串
 */
+ (NSString *)dateWithTimestamp:(NSString *)timestamp format:(NSString *)format;

/**
 * @brief date转为字符串
 *
 * @param date date
 * @param format 转换后的格式
 *
 * @return 转换后的字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)format;

/**
 * @brief 当前的时间戳
 */
+ (NSTimeInterval)currentTimestamp;

/**
 * @brief 当前年
 */
+ (NSInteger)currentYear;

/**
 * @brief 当前月
 */
+ (NSInteger)currentMonth;

/**
 * @brief 当前天
 */
+ (NSInteger)currentDay;

/**
 * @brief 当前小时
 */
+ (NSInteger)currentHour;

/**
 * @brief 前一天的date
 */
+ (NSDate *)lastDateSinceDate:(NSString *)dateString;

/**
 * @brief 上一天的date
 */
+ (NSDate *)nextDateSinceDate:(NSString *)dateString;

@end
