//
//  QSQRCodeScanItem.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCellItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSQRCodeScanItem : QSBaseCellItem
//address
@property (nonatomic, copy) NSString *address;

//qrcode
@property (nonatomic, copy) NSString *qrcodeImageString;

//selected wallet


//maxpay
@property (nonatomic, copy) NSString *maxPayAmount;


@end

NS_ASSUME_NONNULL_END
