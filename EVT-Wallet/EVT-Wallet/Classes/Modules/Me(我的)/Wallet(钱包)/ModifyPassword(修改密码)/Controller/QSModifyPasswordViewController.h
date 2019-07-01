//
//  QSModifyPasswordViewController.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/3.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSModifyPasswordViewController : QSBaseViewController

- (instancetype)initWithWalletPrivateKey:(NSString *)privateKey;

@end

NS_ASSUME_NONNULL_END
