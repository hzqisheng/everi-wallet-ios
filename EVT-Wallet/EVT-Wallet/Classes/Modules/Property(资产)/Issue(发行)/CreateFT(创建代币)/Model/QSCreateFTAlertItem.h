//
//  QSCreateFTAlertItem.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCellItem.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^QSCreateFTAlertItemJurisdictionBlock)(NSInteger jurisdiction);

@interface QSCreateFTAlertItem : QSBaseCellItem

//title
@property (nonatomic, copy) NSString *title;

//jurisdiction   0 only one who can publish Cannot be changed ,1 only one who can publish Can be changed ,2 Advanced Settings
@property (nonatomic, assign) NSInteger jurisdiction;

@property (nonatomic, copy) QSCreateFTAlertItemJurisdictionBlock createFTAlertItemJurisdictionBlock;

@end

NS_ASSUME_NONNULL_END
