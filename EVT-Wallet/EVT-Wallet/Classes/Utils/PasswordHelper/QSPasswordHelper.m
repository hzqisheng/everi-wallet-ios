//
//  QSPasswordHelper.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/9.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSPasswordHelper.h"
#import "QSPrivatekeyAlertView.h"

@implementation QSPasswordHelper

+ (void)verificationPasswordByPrivateKey:(NSString *)privateKey andSuccessBlock:(void (^)(void))block {
    /* 检查这个钱包是否开启了指纹/FaceId */
    QSCreateEvt *wallet = [[QSWalletHelper sharedHelper] getWalletByPrivateKey:privateKey];
    if (wallet.isOpenFingerprint
        && [QSTouchIDHelper sharedHelper].isSupportAuthenticationWithBiometrics) {
        [[QSTouchIDHelper sharedHelper] verificationBiometricsCompleteBlock:^(QSTouchIDAuthType result) {
            if (result == QSTouchIDAuthTypeSuccess) {
                if (block) {
                    block();
                }
            } else if (result == QSTouchIDAuthTypeInputPwd) {
                [QSPrivatekeyAlertView showAlertViewByPrivateKey:privateKey andSubmitBlock:^{
                    if (block) {
                        block();
                    }
                }];
            } else if (result == QSTouchIDAuthTypeCancel) {
                [QSAppKeyWindow hideHud];
            }
        }];
    } else {
        [QSPrivatekeyAlertView showAlertViewByPrivateKey:privateKey andSubmitBlock:^{
            if (block) {
                block();
            }
        }];
    }
}

@end
