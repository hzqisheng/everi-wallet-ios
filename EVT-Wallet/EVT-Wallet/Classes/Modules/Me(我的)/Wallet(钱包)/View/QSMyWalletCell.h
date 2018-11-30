//
//  QSMyWalletCell.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseTableViewCell.h"
@class QSMyWalletCell;

NS_ASSUME_NONNULL_BEGIN

typedef void(^MoreButtonClickedBlock)(QSMyWalletCell *cell);
typedef void(^PasteButtonClickedBlock)(QSMyWalletCell *cell);

@interface QSMyWalletCell : QSBaseTableViewCell

@property (nonatomic, copy) MoreButtonClickedBlock moreButtonClickedBlock;
@property (nonatomic, copy) PasteButtonClickedBlock pasteButtonClickedBlock;

@end

NS_ASSUME_NONNULL_END
