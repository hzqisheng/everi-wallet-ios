//
//  QSEveriPassTransferAddressViewController.h
//  EVT-Wallet
//
//  Created by SJ on 2019/8/5.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCornerSectionTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^EveriPassTransferAddressSuccessBlock)(void);

@interface QSEveriPassTransferAddressViewController : QSBaseCornerSectionTableViewController

@property (nonatomic, copy) NSString *domain;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) EveriPassTransferAddressSuccessBlock everiPassTransferAddressSuccessBlock;

@end

NS_ASSUME_NONNULL_END
