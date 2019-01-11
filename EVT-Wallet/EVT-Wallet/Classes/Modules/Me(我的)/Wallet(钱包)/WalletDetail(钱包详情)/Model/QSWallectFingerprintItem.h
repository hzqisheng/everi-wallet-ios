//
//  QSWallectFingerprintItem.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/9.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCellItem.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SwitchValueChangedBlock)(BOOL isOn);

@interface QSWallectFingerprintItem : QSBaseCellItem

@property (nonatomic, assign, getter=isOpenFingerprint) BOOL openFingerprint;

@property (nonatomic, copy) SwitchValueChangedBlock switchValueChangedBlock;

@end

NS_ASSUME_NONNULL_END
