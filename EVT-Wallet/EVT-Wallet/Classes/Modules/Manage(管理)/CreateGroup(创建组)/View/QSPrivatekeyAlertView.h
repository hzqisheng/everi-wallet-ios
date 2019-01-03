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

@interface QSPrivatekeyAlertView : UIView

+ (void)showPrivatekeyAlertViewAndSubmitBlock:(void(^)(void))block;

@property (nonatomic, copy) PrivatekeyAlertViewSubmitBlock privatekeyAlertViewSubmitBlock;

@end

NS_ASSUME_NONNULL_END
