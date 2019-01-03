//
//  QSTransferftData.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/20.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSTransferftData : QSBaseModel

@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *memo;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *to;

@property (nonatomic, copy) NSString *payee;
@property (nonatomic, strong) NSDictionary *link;

@property (nonatomic, copy) NSString *address;

@end

NS_ASSUME_NONNULL_END
