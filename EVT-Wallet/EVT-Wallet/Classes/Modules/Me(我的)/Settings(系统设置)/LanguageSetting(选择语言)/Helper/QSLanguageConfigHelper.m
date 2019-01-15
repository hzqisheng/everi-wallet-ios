//
//  QSLanguageConfigHelper.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSLanguageConfigHelper.h"

static NSString *const QSUserLanguageKey = @"QSUserLanguageKey";
#define STANDARD_USER_DEFAULT  [NSUserDefaults standardUserDefaults]

@implementation QSLanguageConfigHelper

+ (void)setUserLanguage:(NSString *)userLanguage {
    //跟随手机系统
    if (!userLanguage.length) {
        [self resetSystemLanguage];
        return;
    }
    //用户自定义
    [STANDARD_USER_DEFAULT setValue:userLanguage forKey:QSUserLanguageKey];
    [STANDARD_USER_DEFAULT setValue:@[userLanguage] forKey:@"AppleLanguages"];
    [STANDARD_USER_DEFAULT synchronize];
}

+ (NSString *)userLanguage {
    return [STANDARD_USER_DEFAULT valueForKey:QSUserLanguageKey];
}

/**
 重置系统语言
 */
+ (void)resetSystemLanguage {
    [STANDARD_USER_DEFAULT removeObjectForKey:QSUserLanguageKey];
    [STANDARD_USER_DEFAULT setValue:nil forKey:@"AppleLanguages"];
    [STANDARD_USER_DEFAULT synchronize];
}

/**
 设置系统语言为中文
 */
+ (void)setSystemLanguageChinese {
    [self setUserLanguage:@"zh-Hans"];
}

/**
 设置系统语言为英文
 */
+ (void)setSystemLanguageEnglish {
    [self setUserLanguage:@"en"];
}

@end
