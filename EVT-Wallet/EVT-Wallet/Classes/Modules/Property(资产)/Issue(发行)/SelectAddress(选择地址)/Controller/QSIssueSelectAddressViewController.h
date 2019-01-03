//
//  QSIssueSelectAddressViewController.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^IssueSelectAddressViewControllerChooseAddressBlock)(NSString *address);

@interface QSIssueSelectAddressViewController : QSBaseTableViewController

@property (nonatomic, copy) IssueSelectAddressViewControllerChooseAddressBlock issueSelectAddressViewControllerChooseAddressBlock;

@end

NS_ASSUME_NONNULL_END
