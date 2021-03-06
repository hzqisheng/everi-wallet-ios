//
//  QSBaseCornerSectionTableViewController.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseTableViewController.h"
#import "QSBaseCellItem.h"
#import "QSBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QSBaseCornerSectionTableViewControllerProtocol <NSObject>

@required
/**
 dataSource
 One of the following methods must be implemented
 */
- (NSArray<id<QSBaseCellItemDataProtocol>> *)createSingleSectionDataSource;
- (NSArray<NSArray<id<QSBaseCellItemDataProtocol>> *> *)createMultiSectionDataSource;

@optional
/* default is YES */
- (BOOL)isShowCornerSection;

@end

@interface QSBaseCornerSectionTableViewController : QSBaseTableViewController<QSBaseCornerSectionTableViewControllerProtocol>

- (id<QSBaseCellItemDataProtocol>)itemInIndexPath:(NSIndexPath *)indexPath;

- (void)reloadTableViewData;

@end

NS_ASSUME_NONNULL_END
