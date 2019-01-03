//
//  QSWalletDetailViewController.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/4.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCornerSectionTableViewController.h"
#import "QSCreateEvt.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSWalletDetailViewController : QSBaseCornerSectionTableViewController

@property (nonatomic, strong) QSCreateEvt *evtModel;

@end

NS_ASSUME_NONNULL_END
