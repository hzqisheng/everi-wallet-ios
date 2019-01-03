//
//  QSNFT.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/16.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"
#import "QSNFTTransfer.h"
#import "QSAuthorizers.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSNFT : QSBaseModel

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *creator;
@property (nonatomic, strong) QSNFTTransfer *issue;
@property (nonatomic, strong) QSNFTTransfer *manage;
@property (nonatomic, strong) QSNFTTransfer *transfer;
@property (nonatomic, strong) NSArray *metas;
@property (nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
