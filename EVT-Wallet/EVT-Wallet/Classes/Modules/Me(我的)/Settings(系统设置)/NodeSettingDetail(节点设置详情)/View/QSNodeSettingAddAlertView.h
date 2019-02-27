//
//  QSNodeSettingAddAlertView.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/2/26.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QSNodeSettingAddAlertView : UIView

+ (void)showAlertViewAndConfirmBlock:(void(^)(NSString *nodeAddress))block;

@end

NS_ASSUME_NONNULL_END
