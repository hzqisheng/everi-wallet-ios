//
//  NSDate+Transform.m
//  投融社
//
//  Created by 孙俊 on 2017/12/1.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "NSDate+Transform.h"

@implementation NSDate (Transform)

+ (NSString *)dateWithTimestamp:(NSString *)timestamp format:(NSString *)format {
    if (!timestamp.length) {
        return nil;
    }
    NSTimeInterval millisecond = [timestamp doubleValue]/1000.0;
    //yyyy/MM/dd HH:mm
    //。如一个时间戳不省略的情况下为 1395399556.862046 ，省略掉后为一般所见 1395399556 。所以想取得毫秒时用获取到的时间戳 *1000 ，想取得微秒时 用取到的时间戳 * 1000 * 1000
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:millisecond];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString * string = [dateFormatter stringFromDate:date];
    return string;
}

+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:format];
    NSString * string = [dateFormatter stringFromDate:date];
    return string;
}

+ (NSTimeInterval)currentTimestamp {
    return [[NSDate date] timeIntervalSince1970];
}

+ (NSInteger)currentYear {
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    //IOS 8 之后
    NSUInteger integer = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dataCom = [currentCalendar components:integer fromDate:currentDate];
    
    NSInteger year = [dataCom year];
    return year;
}

+ (NSInteger)currentMonth {
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    //IOS 8 之后
    NSUInteger integer = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dataCom = [currentCalendar components:integer fromDate:currentDate];
    
    NSInteger month = [dataCom month];
    return month;
}

+ (NSInteger)currentDay {
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    //IOS 8 之后
    NSUInteger integer = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dataCom = [currentCalendar components:integer fromDate:currentDate];
    
    //    NSInteger year = [dataCom year];
    //    NSInteger month = [dataCom month];
    NSInteger day = [dataCom day];
    //    NSInteger hour = [dataCom hour];
    //    NSInteger minute = [dataCom minute];
    //    NSInteger second = [dataCom second];
    return day;
}

+ (NSInteger)currentHour {
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    //IOS 8 之后
    NSUInteger integer = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dataCom = [currentCalendar components:integer fromDate:currentDate];
    
    //    NSInteger year = [dataCom year];
    //    NSInteger month = [dataCom month];
    //    NSInteger day = [dataCom day];
    NSInteger hour = [dataCom hour];
    //    NSInteger minute = [dataCom minute];
    //    NSInteger second = [dataCom second];
    return hour;
}

+ (NSDate *)lastDateSinceDate:(NSString *)dateString {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateString.doubleValue/1000];
    return [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];
}

+ (NSDate *)nextDateSinceDate:(NSString *)dateString {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateString.doubleValue/1000];
    return [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];
}

@end
