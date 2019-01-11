//
//  QSTouchIDHelper.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/9.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSTouchIDHelper.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation QSTouchIDHelper

+ (instancetype)sharedHelper {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (BOOL)isSupportTouchID {
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    return [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
}

- (void)verificationTouchIDCompleteBlock:(void (^)(QSTouchIDAuthType))block {
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    NSString *reason = QSLocalizedString(@"qs_wallet_touchid_verify_title");
    // 判断设置是否支持指纹识别
    if([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
    {
        // 指纹识别只判断当前用户是否是机主
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL success, NSError * _Nullable error) {
            if(success)
            {
                DLog(@"指纹认证成功");
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (block) {
                        block(QSTouchIDAuthTypeSuccess);
                    }
                });
            }
            else
            {
                DLog(@"指纹认证失败");
                DLog(@"错误码：%zd",error.code);
                DLog(@"出错信息：%@",error);
                // 错误码 error.code
                // -1: 连续三次指纹识别错误
                // -2: 在TouchID对话框中点击了取消按钮
                // -3: 在TouchID对话框中点击了输入密码按钮
                // -4: TouchID对话框被系统取消，例如按下Home或者电源键
                // -8: 连续五次指纹识别错误，TouchID功能被锁定，下一次需要输入系统密码
                QSTouchIDAuthType resut = QSTouchIDAuthTypeError;
                if (error.code == -2) {
                    resut = QSTouchIDAuthTypeCancel;
                } else if (error.code == -3) {
                    resut = QSTouchIDAuthTypeInputPwd;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(block) {
                        block(resut);
                    }
                });
            }
        }];
    }
    else
    {
        DLog(@"TouchID设备不可用");
        DLog(@"错误码：%zd",error.code);
        DLog(@"出错信息：%@",error);
        dispatch_async(dispatch_get_main_queue(), ^{
            if(block) {
                block(QSTouchIDAuthTypeDisable);
            }
        });
    }
}

@end
