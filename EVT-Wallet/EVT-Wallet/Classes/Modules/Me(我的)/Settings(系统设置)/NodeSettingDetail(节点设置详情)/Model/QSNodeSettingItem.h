//
//  QSNodeSettingItem.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/2/28.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSNodeSettingItem : QSBaseModel

/** mainnet13.everitoken.io */
@property (nonatomic, copy) NSString *title;
/** 443 */
@property (nonatomic, copy) NSString *port;
/** http/https */
@property (nonatomic, copy) NSString *protocol;
/** HONG KONG */
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, assign) NSInteger isSelected;

@end

NS_ASSUME_NONNULL_END
