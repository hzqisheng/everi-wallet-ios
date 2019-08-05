//
//  QSNFTTransferLog.h
//  EVT-Wallet
//
//  Created by SJ on 2019/8/5.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"
@class QSNFTTransferLogData;

NS_ASSUME_NONNULL_BEGIN

@interface QSNFTTransferLog : QSBaseModel

/*
 data =             {
 domain = 599;
 memo = "";
 name = wiwijee;
 to =                 (
 EVT8mFhLBK1J49Lv1kUD1CgvqCQN6nbTHzJ99v5BZ8T6A5CzFCczx
 );
 };
 domain = 599;
 key = wiwijee;
 name = transfer;
 timestamp = "2019-08-05T01:07:21.5+00";
 "trx_id" = 23dce9d329ac10eb91b635dfc97eaa446cb243b30f7f9aff25f6b9cb71a969a9;
 */


@property (nonatomic, strong) QSNFTTransferLogData *data;
@property (nonatomic, copy) NSString *domain;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *trx_id;

@end

@interface QSNFTTransferLogData : QSBaseModel

@property (nonatomic, copy) NSString *domain;
@property (nonatomic, copy) NSString *memo;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *to;

@end


NS_ASSUME_NONNULL_END
