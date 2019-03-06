//
//  QSPayAmountViewController.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/6.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCornerSectionTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSPayAmountViewController : QSBaseCornerSectionTableViewController

/** 转账的address*/
@property (nonatomic, copy) NSString *address;

/** 转账的fungibleID */
@property (nonatomic, copy, nullable) NSString *fungibleID;

/** 转账的数量 */
@property (nonatomic, copy, nullable) NSString *amount;

@end

NS_ASSUME_NONNULL_END
