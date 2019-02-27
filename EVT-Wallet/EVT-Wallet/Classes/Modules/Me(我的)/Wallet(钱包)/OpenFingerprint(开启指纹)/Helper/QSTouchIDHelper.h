//
//  QSTouchIDHelper.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/9.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, QSTouchIDAuthType) {
    /** 成功 */
    QSTouchIDAuthTypeSuccess,
    /** 点击取消 */
    QSTouchIDAuthTypeCancel,
    /** 点击输入密码 */
    QSTouchIDAuthTypeInputPwd,
    /** 设备touchid不可用 */
    QSTouchIDAuthTypeDisable,
    /** 其他错误 */
    QSTouchIDAuthTypeError
};


typedef NS_ENUM(NSUInteger, QSLABiometryType) {
    /** 不支持生物识别 */
    QSLABiometryTypeNone,
    /** 支持指纹识别 */
    QSLABiometryTypeTouchID,
    /** 支持面容识别 */
    QSLABiometryTypeFaceID,
};

@interface QSTouchIDHelper : NSObject

/** 是否支持TouchID/FaceID */
@property (nonatomic, assign, getter=isSupportAuthenticationWithBiometrics, readonly) BOOL supportAuthenticationWithBiometrics;

/** 支持生物识别的类型 */
@property (nonatomic, assign, readonly) QSLABiometryType biometryType;

/** 验证指纹/FaceId */
- (void)verificationBiometricsCompleteBlock:(void(^)(QSTouchIDAuthType result))block;

+ (instancetype)sharedHelper;

@end

NS_ASSUME_NONNULL_END
