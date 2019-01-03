//
//  QSManageSelectAddressItem.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/14.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCellItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSManageSelectAddressItem : QSBaseCellItem

//title
@property (nonatomic, copy) NSString *title;

//content
@property (nonatomic, copy) NSString *content;

//leftButton isSelected
@property (nonatomic, assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
