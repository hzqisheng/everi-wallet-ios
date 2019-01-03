//
//  QSTransferftModel.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/20.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"
#import "QSTransferftData.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSTransferftModel : QSBaseModel

@property (nonatomic, strong) QSTransferftData *data;
@property (nonatomic, copy) NSString *domain;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *trx_id;

@end

NS_ASSUME_NONNULL_END
