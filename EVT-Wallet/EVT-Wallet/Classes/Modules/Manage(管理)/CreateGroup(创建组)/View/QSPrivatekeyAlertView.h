//
//  QSPrivatekeyAlertView.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/16.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PrivatekeyAlertViewSubmitBlock)(void);

/**
 * 验证密码弹窗
 */
@interface QSPrivatekeyAlertView : UIView

/** 验证当前选中钱包的密码 */
+ (void)showPrivatekeyAlertViewAndSubmitBlock:(void(^)(void))block;

/**
 * 验证某一个钱包的密码
 */
+ (void)showAlertViewByPrivateKey:(NSString *)privateKey
                   andSubmitBlock:(void(^)(void))block;

@property (nonatomic, copy) PrivatekeyAlertViewSubmitBlock privatekeyAlertViewSubmitBlock;

@end

NS_ASSUME_NONNULL_END
