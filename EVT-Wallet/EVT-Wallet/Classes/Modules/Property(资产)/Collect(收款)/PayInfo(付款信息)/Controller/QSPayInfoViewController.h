//
//  QSPayInfoViewController.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/6.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCornerSectionTableViewController.h"
#import "QSFT.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSPayInfoViewController : QSBaseCornerSectionTableViewController

@property (nonatomic, strong) QSFT *FTModel;
@property (nonatomic, copy) NSString *shoukuanAddress;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *note;

@end

NS_ASSUME_NONNULL_END
