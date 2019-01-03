//
//  QSLogoutAlertView.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/21.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LogoutAlertViewSubmitBlock)(void);

@interface QSLogoutAlertView : UIView

+ (void)showLogoutAlertViewAndSubmitBlock:(void(^)(void))block;

@property (nonatomic, copy) LogoutAlertViewSubmitBlock logoutAlertViewSubmitBlock;

@end

NS_ASSUME_NONNULL_END
