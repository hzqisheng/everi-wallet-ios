//
//  QSMyNFTsCell.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/9.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseTableViewCell.h"
#import "QSOwnedToken.h"
@class QSMyNFTsCell;

NS_ASSUME_NONNULL_BEGIN

typedef void(^EveriPayClickedBlock)(QSMyNFTsCell *cell);
typedef void(^MyNFTsCellClickDetailBlock)(QSMyNFTsCell *cell);

@interface QSMyNFTsCell : QSBaseTableViewCell

@property (nonatomic, copy) EveriPayClickedBlock everiPayClickedBlock;

@property (nonatomic, copy) MyNFTsCellClickDetailBlock myNFTsCellClickDetailBlock;

@property (nonatomic, strong) QSOwnedToken *ownedToken;

@end

NS_ASSUME_NONNULL_END
