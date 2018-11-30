//
//  QSSelectMenuCell.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseTableViewCell.h"
#import "QSSelectMenuItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSSelectMenuCell : QSBaseTableViewCell

@property (nonatomic, strong) QSSelectMenuItem *item;

@end

NS_ASSUME_NONNULL_END
