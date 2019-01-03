//
//  QSHomeMyFTsCell.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/26.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseTableViewCell.h"
@class QSHomeMyFTsCell;

NS_ASSUME_NONNULL_BEGIN

typedef void(^EveriPayClickedBlock)(QSHomeMyFTsCell *cell);

@interface QSHomeMyFTsCell : QSBaseTableViewCell

@property (nonatomic, copy) EveriPayClickedBlock everiPayClickedBlock;

@property (nonatomic, copy) NSString *amountNameString;

@property (nonatomic, strong) QSFT *FTModel;

@end

NS_ASSUME_NONNULL_END
