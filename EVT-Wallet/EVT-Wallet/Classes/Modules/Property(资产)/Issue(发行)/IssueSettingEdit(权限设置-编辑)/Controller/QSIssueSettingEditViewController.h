//
//  QSIssueSettingEditViewController.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/13.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseViewController.h"
@class QSIssueSettingEditViewController;

NS_ASSUME_NONNULL_BEGIN

typedef void(^QSIssueSettingEditViewControllerSaveBlock)(NSString *text);

@interface QSIssueSettingEditViewController : QSBaseViewController

@property (nonatomic, copy) QSIssueSettingEditViewControllerSaveBlock issueSettingEditViewControllerSaveBlock;

@end

NS_ASSUME_NONNULL_END
