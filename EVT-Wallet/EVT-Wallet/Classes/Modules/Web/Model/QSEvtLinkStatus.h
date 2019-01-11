//
//  QSEvtLinkStatus.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/10.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSEvtLinkStatus : QSBaseModel

@property (nonatomic, assign) NSInteger pending;
@property (nonatomic, copy) NSString *transactionId;

@end

NS_ASSUME_NONNULL_END
