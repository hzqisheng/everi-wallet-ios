//
//  QSAddress.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/15.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSAddress : QSBaseModel

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *publicKey;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *note;

@end

NS_ASSUME_NONNULL_END
