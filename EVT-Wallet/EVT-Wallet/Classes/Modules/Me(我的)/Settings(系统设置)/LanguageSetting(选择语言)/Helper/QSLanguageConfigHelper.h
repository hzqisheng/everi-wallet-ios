//
//  QSLanguageConfigHelper.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QSLanguageConfigHelper : NSObject

/**
 用户自定义使用的语言，当传nil时，等同于resetSystemLanguage
 */
@property (class, nonatomic, strong) NSString *userLanguage;

/**
 重置系统语言
 */
+ (void)resetSystemLanguage;

/**
 设置系统语言为中文
 */
+ (void)setSystemLanguageChinese;

/**
 设置系统语言为英文
 */
+ (void)setSystemLanguageEnglish;

@end

NS_ASSUME_NONNULL_END
