//
//  QSCollectCodeViewController.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCornerSectionTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSCollectCodeViewController : QSBaseCornerSectionTableViewController

@property (nonatomic, assign) NSInteger fungibleId;
/**
 "1.00000 S#2"
 */
@property (nonatomic, copy) NSString *amount;


@end

NS_ASSUME_NONNULL_END
