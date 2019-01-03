//
//  QSPayAmountItem.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/6.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCellItem.h"
#import "QSFT.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PayAmountItemSelectAddressBlock)(void);
typedef void(^PayAmountItemSweepBlock)(void);
typedef void(^PayAmountItemTextBlock)(NSString *text);

@interface QSPayAmountItem : QSBaseCellItem

/** balance */
@property (nonatomic, copy) NSString *balance;

/** inputTitle */
@property (nonatomic, copy) NSString *inputTitle;
/** inputPlaceholder */
@property (nonatomic, copy) NSString *inputPlaceholder;

@property (nonatomic, strong) QSFT *FTModel;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) UIKeyboardType keyType;

@property (nonatomic, copy) PayAmountItemSelectAddressBlock payAmountItemSelectAddressBlock;
@property (nonatomic, copy) PayAmountItemSweepBlock payAmountItemSweepBlock;
@property (nonatomic, copy) PayAmountItemTextBlock payAmountItemTextBlock;

@end

NS_ASSUME_NONNULL_END
