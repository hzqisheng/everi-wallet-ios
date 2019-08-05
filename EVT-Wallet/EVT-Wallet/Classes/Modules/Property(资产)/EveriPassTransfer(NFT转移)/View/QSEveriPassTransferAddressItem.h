//
//  QSEveriPassTransferAddressItem.h
//  EVT-Wallet
//
//  Created by SJ on 2019/8/5.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCellItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSEveriPassTransferAddressItem : QSBaseCellItem

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) void(^everiPassTransferAddressDeleteBlock)(QSEveriPassTransferAddressItem *item);

@end

NS_ASSUME_NONNULL_END
