//
//  NSBundle+QSLanguageUtils.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QSLanguageConfigHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (QSLanguageUtils)

+ (BOOL)isChineseLanguage;

+ (NSString *)currentLanguage;

@end

NS_ASSUME_NONNULL_END
