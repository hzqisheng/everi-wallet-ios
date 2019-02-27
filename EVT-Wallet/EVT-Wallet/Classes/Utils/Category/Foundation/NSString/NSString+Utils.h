//
//  NSString+Utils.h
//  投融社
//
//  Created by 孙俊 on 2017/11/15.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

/**
 * @brief 改变string的一部分的大小颜色
 *
 * @param bigText 需要变大的文字
 * @param font 字体
 * @param color 颜色
 *
 * @return NSMutableAttributedString 富文本
 */
- (NSMutableAttributedString *)stringByChangingBigText:(NSString *)bigText font:(UIFont *)font color:(UIColor *)color;

/**
 * @brief 获取下划线富文本
 *
 * @param font ziti
 * @param textColor yanse
 *
 * @return 下划线富文本
 */
- (NSMutableAttributedString *)getUnderLineAttrStrWithFont:(UIFont *)font textColor:(UIColor *)textColor;

/**
 * @brief 获取不同颜色的富文本
 *
 * @param text       所有文字
 * @param rangeText  改变的文字
 * @param color      改变文字的颜色
 * @param font       改变文字的大小
 */
+ (NSMutableAttributedString *)setupAttributeString:(NSString *)text rangeText:(NSString*)rangeText textColor:(UIColor *)color textHighLightColor:(UIColor *)highLightColor font:(UIFont *)font;

/**
 *  label文本高度
 *
 *  @param lineSpeace 行高
 *  @param width 宽度
 */
-(CGFloat)heightWithSpeace:(CGFloat)lineSpeace font:(UIFont*)font maxWidth:(CGFloat)width;


/**
 *  label计算文本宽度
 *
 *  @param font   字体
 *  @param height 高度
 */
- (CGFloat)caculateWidthWithFont:(UIFont *)font height:(CGFloat)height;

/** 正则匹配手机号 */
- (BOOL)checkTelNumber;

/** 是否是数字 */
- (BOOL)checkIsAllNumber;

/** 是否是小数 */
- (BOOL)checkIsDecimalNumber;

/** 判断输入的位数 */
- (BOOL)checkPwdCount;

/* 判断是否是正确的身份证号码*/
- (BOOL)isValidWithIdentityNum;

/* 隐藏手机号中间4位 */
- (NSString *)numberSuitScanf;

/*!
 @brief  修正金额相关浮点型精度 保留2位小数四舍五入
 @return 修正精度后的数据
 */
- (NSString *)reviseString;

/**
 *  金额字符串转大写
 */
-(NSString *)digitUppercase;

/**
 *  是否是正确的网站
 */
- (BOOL)isValidUrl;

@end
