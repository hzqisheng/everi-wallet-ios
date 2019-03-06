//
//  QSScanAddress.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/17.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSScanAddress : QSBaseModel

/** 44 publicKey 45fungibleID */
@property (nonatomic, assign) NSInteger typeKey;
@property (nonatomic, copy) NSString *value;

@end

NS_ASSUME_NONNULL_END
