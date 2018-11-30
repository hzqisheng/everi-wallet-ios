//
//  QSBaseSettingViewController.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseTableViewController.h"
#import "QSSettingItem.h"
#import "QSSettingCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QSBaseSettingViewControllerProtocol <NSObject>

@required
- (NSArray<QSSettingItem *> *)createSingleSectionDataSource;
- (NSArray<NSArray<QSSettingItem *> *> *)createMultiSectionDataSource;
@optional
/** defualt is QSSettingCell */
- (Class)getRigisterCellClass;
- (NSArray<Class> *)getRigisterMultiCellClasses;

@end

@interface QSBaseSettingViewController : QSBaseTableViewController<QSBaseSettingViewControllerProtocol>

- (QSSettingItem *)itemInIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
