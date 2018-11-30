//
//  QSAddAddressCell.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSSettingCell.h"
#import "QSAddAddressItem.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, QSAddAddressSelectdType) {
    QSAddAddressSelectdTypeEVT,
    QSAddAddressSelectdTypeETH,
    QSAddAddressSelectdTypeEOS,
};

@interface QSAddAddressCell : QSSettingCell

//type cell
@property (nonatomic, strong) UIButton *evtButton;
@property (nonatomic, strong) UIButton *ethButton;
@property (nonatomic, strong) UIButton *eosButton;

//scan cell input cell
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *scanButton;

@property (nonatomic, assign, readonly) NSInteger selectedType;

@property (nonatomic, strong) QSAddAddressItem *addressItem;

- (void)configureLeftSubViewsWithItem:(QSAddAddressItem *)item;

@end

NS_ASSUME_NONNULL_END
