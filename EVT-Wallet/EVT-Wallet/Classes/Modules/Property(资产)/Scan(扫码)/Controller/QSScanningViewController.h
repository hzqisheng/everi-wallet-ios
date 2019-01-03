//
//  QSScanningViewController.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseViewController.h"

typedef void(^ScanningViewControllerSweepBlock)(NSString *publicKey);
typedef void(^ScanningViewControllerPayBySweepBlock)(NSString *address);
typedef void(^ScanningViewControllerScanAddressBlock)(NSString *address);
typedef void(^ScanningViewControllerScanFukuanBlock)(void);
typedef void(^ScanningViewControllerHomeScan)(void);

NS_ASSUME_NONNULL_BEGIN

@interface QSScanningViewController : QSBaseViewController

@property (nonatomic, copy) ScanningViewControllerSweepBlock scanningViewControllerSweepBlock;
@property (nonatomic, copy) ScanningViewControllerPayBySweepBlock scanningViewControllerPayBySweepBlock;
@property (nonatomic, copy) ScanningViewControllerScanAddressBlock scanningViewControllerScanAddressBlock;
@property (nonatomic, copy) ScanningViewControllerScanFukuanBlock scanningViewControllerScanFukuanBlock;
@property (nonatomic, copy) ScanningViewControllerHomeScan scanningViewControllerHomeScan;

@end

NS_ASSUME_NONNULL_END
