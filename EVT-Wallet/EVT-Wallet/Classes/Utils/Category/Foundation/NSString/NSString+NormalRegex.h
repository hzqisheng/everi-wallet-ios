//
//  NSString+NormalRegex.h
//  Category整理
//
//  Created by 孙俊 on 2018/5/9.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NormalRegex)

/**
 *  手机号码的有效性:分电信、联通、移动和小灵通
 */
- (BOOL)sj_isMobileNumberClassification;

/**
 *  手机号有效性
 */
- (BOOL)sj_isMobileNumber;

/**
 *  邮箱的有效性
 */
- (BOOL)sj_isEmailAddress;

/**
 *  简单的身份证有效性
 *
 */
- (BOOL)sj_simpleVerifyIdentityCardNum;

/**
 *  精确的身份证号码有效性检测
 */
- (BOOL)sj_accurateVerifyIDCardNumber;

/**
 *  车牌号的有效性
 */
- (BOOL)sj_isCarNumber;

/**
 *  银行卡的有效性
 */
- (BOOL)sj_bankCardluhmCheck;

/**
 *  IP地址有效性
 */
- (BOOL)sj_isIPAddress;

/**
 *  Mac地址有效性
 */
- (BOOL)sj_isMacAddress;

/**
 *  网址有效性
 */
- (BOOL)sj_isValidUrl;

/**
 *  纯汉字
 */
- (BOOL)sj_isValidChinese;

/**
 *  邮政编码
 */
- (BOOL)sj_isValidPostalcode;

/**
 *  工商税号
 */
- (BOOL)sj_isValidTaxNo;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)sj_isValidWithMinLenth:(NSInteger)minLenth
                      maxLenth:(NSInteger)maxLenth
                containChinese:(BOOL)containChinese
           firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLesjer   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)sj_isValidWithMinLenth:(NSInteger)minLenth
                      maxLenth:(NSInteger)maxLenth
                containChinese:(BOOL)containChinese
                 containDigtal:(BOOL)containDigtal
                 containLesjer:(BOOL)containLesjer
         containOtherCharacter:(NSString *)containOtherCharacter
           firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

@end
