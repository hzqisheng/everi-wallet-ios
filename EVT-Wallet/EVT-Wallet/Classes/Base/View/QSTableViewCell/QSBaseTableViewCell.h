//
//  QSBaseTableViewCell.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QSBaseCellItem;

NS_ASSUME_NONNULL_BEGIN

@protocol QSBaseTableViewCellProtocol <NSObject>

@required
- (void)configureSubViews;
- (void)configureCellWithItem:(QSBaseCellItem *)item;

@end

@interface QSBaseTableViewCell : UITableViewCell<QSBaseTableViewCellProtocol>

@property (nonatomic, strong) QSBaseCellItem *item;

@end

NS_ASSUME_NONNULL_END
