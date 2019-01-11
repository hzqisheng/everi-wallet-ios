//
//  QSPasswordHelper.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/9.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QSPasswordHelper : NSObject

/**
 验证某一个钱包的密码
 没有指纹验证本地密码
 有指纹验证指本地指纹
 后续如果加面容识别 可以在此方法拓展
 */
+ (void)verificationPasswordByPrivateKey:(NSString *)privateKey
                         andSuccessBlock:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
