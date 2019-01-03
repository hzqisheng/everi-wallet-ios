//
//  QSMetas.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/16.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSMetas : QSBaseModel

@property (nonatomic, copy) NSString *creator;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;

@end

NS_ASSUME_NONNULL_END
