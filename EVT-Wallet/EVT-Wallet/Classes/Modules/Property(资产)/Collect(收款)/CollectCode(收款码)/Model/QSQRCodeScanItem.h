//
//  QSQRCodeScanItem.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCellItem.h"
#import "QSFT.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^QSQRCodeScanItemTextChangedBlock)(NSString *text);
typedef void(^QSQRCodeScanItemEndEditingBlock)(void);

@interface QSQRCodeScanItem : QSBaseCellItem
//address
@property (nonatomic, copy) NSString *address;

//qrcode
@property (nonatomic, copy) NSString *qrcodeImageString;

@property (nonatomic, assign) BOOL isShowCopyButton;

//maxpay
@property (nonatomic, copy) NSString *maxPayAmount;
@property (nonatomic, assign) UIKeyboardType keyboardType;

@property (nonatomic, strong) QSFT *FTModel;

@property (nonatomic, strong) UIImage *codeImage;

@property (nonatomic, copy) QSQRCodeScanItemTextChangedBlock codeScanItemTextChangedBlock;
@property (nonatomic, copy) QSQRCodeScanItemEndEditingBlock codeScanItemEndEditingBlock;

@end

NS_ASSUME_NONNULL_END
