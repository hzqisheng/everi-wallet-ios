//
//  QSNodeSettingDetailViewController.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/15.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSNodeSettingDetailViewController : QSBaseTableViewController

@end

@interface QSNodeSettingItem : QSBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, assign) NSInteger isSelected;

@end

NS_ASSUME_NONNULL_END
