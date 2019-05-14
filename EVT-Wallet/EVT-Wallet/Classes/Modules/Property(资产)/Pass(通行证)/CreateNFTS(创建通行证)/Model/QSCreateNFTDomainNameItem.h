//
//  QSCreateNFTDomainNameItem.h
//  EVT-Wallet
//
//  Created by SJ on 2019/5/13.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"
#import "QSBaseCellItemDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSCreateNFTDomainNameItem : QSBaseModel<QSBaseCellItemDataProtocol>

@property (nonatomic, copy) NSString *domainName;

@property (nonatomic, copy) void(^domainNameDidChangeBlock)(NSString *domainName);

@end

NS_ASSUME_NONNULL_END
