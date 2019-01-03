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

@property (nonatomic, copy) NSString *address;

@property (nonatomic, strong) QSFT *FTModel;

@end

NS_ASSUME_NONNULL_END
