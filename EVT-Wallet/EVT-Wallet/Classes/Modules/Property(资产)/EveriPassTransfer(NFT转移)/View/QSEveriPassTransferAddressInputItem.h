//
//  QSEveriPassTransferAddressInputItem.h
//  EVT-Wallet
//
//  Created by SJ on 2019/8/5.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCellItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSEveriPassTransferAddressInputItem : QSBaseCellItem

@property (nonatomic, copy) NSString *inputText;

@property (nonatomic, copy) void(^everiPassTransferAddressInputAddBlock)(NSString *text);

@property (nonatomic, copy) void(^everiPassTransferAddressInputScanBlock)(QSEveriPassTransferAddressInputItem *item);

@end

NS_ASSUME_NONNULL_END
