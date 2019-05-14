//
//  QSAddAddressPopupView.h
//  EVT-Wallet
//
//  Created by SJ on 2019/5/13.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddAddressConfirmBlock)(NSString *publicKey, NSString *weight);

@interface QSAddAddressPopupView : UIView

+ (void)showInView:(UIView *)view
             title:(NSString *)title
      confirmBlock:(AddAddressConfirmBlock)confirmBlock;

@end

NS_ASSUME_NONNULL_END
