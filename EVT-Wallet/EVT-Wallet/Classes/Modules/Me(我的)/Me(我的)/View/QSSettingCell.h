//
//  QSSettingCell.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/27.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseTableViewCell.h"
#import "QSSettingItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QSSettingCellProtocol <NSObject>

@optional
- (void)configureCellWithItem:(QSSettingItem *)item;

@end

@interface QSSettingCell : QSBaseTableViewCell<QSSettingCellProtocol>

/** left imageView */
@property (nonatomic,strong) UIImageView *leftImageView;
/** left titleLabel */
@property (nonatomic,strong) UILabel *leftTitleLabel;

/** right titleLabel */
@property (nonatomic,strong) UILabel *rightTitleLabel;
/** right arrow imageView */
@property (nonatomic,strong) UIImageView *arrowImageView;

@property (nonatomic, strong) QSSettingItem *item;

@end

NS_ASSUME_NONNULL_END
