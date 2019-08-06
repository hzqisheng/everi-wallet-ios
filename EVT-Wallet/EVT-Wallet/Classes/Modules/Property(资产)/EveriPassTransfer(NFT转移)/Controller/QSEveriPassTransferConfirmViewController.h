//
//  QSEveriPassTransferConfirmViewController.h
//  EVT-Wallet
//
//  Created by SJ on 2019/8/6.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCornerSectionTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^QSEveriPassTransferConfirmSuccessBlock)(void);

@interface QSEveriPassTransferConfirmViewController : QSBaseCornerSectionTableViewController

@property (nonatomic, copy) NSDictionary *actions;

@property (nonatomic, copy) QSEveriPassTransferConfirmSuccessBlock everiPassTransferConfirmSuccessBlock;

@end

NS_ASSUME_NONNULL_END
