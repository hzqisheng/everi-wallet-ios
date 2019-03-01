//
//  QSInputAlertView.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/3/1.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^QSInputAlertViewConfirmBlock)(NSString *text);
typedef void(^QSInputAlertViewCancelBlock)(void);

@interface QSInputAlertView : UIView

+ (void)showInputAlertViewWithTitle:(NSString *)title
                        placeholder:(NSString *)placeholder
                    confirmBlock:(QSInputAlertViewConfirmBlock _Nullable)confirmBlock
                              cancelBlock:(QSInputAlertViewCancelBlock _Nullable)cancelBlock;

@end

NS_ASSUME_NONNULL_END
