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

@interface QSTouchIDHelper : NSObject

/** 是否支持TouchID */
@property (nonatomic, assign, getter=isSupportTouchID, readonly) BOOL supportTouchID;

/** 验证指纹 */
- (void)verificationTouchIDCompleteBlock:(void(^)(QSTouchIDAuthType result))block;

+ (instancetype)sharedHelper;

@end

NS_ASSUME_NONNULL_END
