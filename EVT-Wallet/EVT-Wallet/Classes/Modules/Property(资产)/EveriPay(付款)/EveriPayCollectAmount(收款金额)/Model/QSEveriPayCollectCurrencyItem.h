//
//  QSEveriPayCollectCurrencyItem.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCellItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSEveriPayCollectCurrencyItem : QSBaseCellItem

@property (nonatomic, copy) NSString *currceny;
@property (nonatomic, strong) QSFungibleSymbol *FTModel;

@end

NS_ASSUME_NONNULL_END
