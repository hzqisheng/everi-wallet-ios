//
//  QSManageAddressCell.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseTableViewCell.h"
#import "QSAddress.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSManageAddressCell : QSBaseTableViewCell

@property (nonatomic, strong) QSAddress *addressModel;

@end

NS_ASSUME_NONNULL_END
