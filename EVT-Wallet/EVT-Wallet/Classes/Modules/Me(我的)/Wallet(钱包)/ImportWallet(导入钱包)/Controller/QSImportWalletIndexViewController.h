//
//  QSImportWalletIndexViewController.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "YZDisplayViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, QSImportWalletType) {
    QSImportWalletTypeEVT,
    QSImportWalletTypeETH,
    QSImportWalletTypeEOS,
};

@interface QSImportWalletIndexViewController : YZDisplayViewController

- (instancetype)initWithType:(QSImportWalletType)type;

@end

NS_ASSUME_NONNULL_END
