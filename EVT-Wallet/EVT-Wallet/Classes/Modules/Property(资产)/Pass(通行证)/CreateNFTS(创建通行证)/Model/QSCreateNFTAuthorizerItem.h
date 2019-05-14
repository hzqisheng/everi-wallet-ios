//
//  QSCreateNFTAuthorizerItem.h
//  EVT-Wallet
//
//  Created by SJ on 2019/5/13.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"
#import "QSBaseCellItemDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSCreateNFTAuthorizerItem : QSBaseModel<QSBaseCellItemDataProtocol>

@property (nonatomic, copy) NSString *authorizer;

@property (nonatomic, copy) void(^deleteAuthorizerClickedBlock)(QSCreateNFTAuthorizerItem *item);

@end

NS_ASSUME_NONNULL_END
