//
//  QSNFTTransfer.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/16.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSNFTTransfer : QSBaseModel

@property (nonatomic, copy) NSArray *authorizers;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger threshold;

@end

NS_ASSUME_NONNULL_END
