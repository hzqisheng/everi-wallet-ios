//
//  QSPayAmountBalanceCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/6.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSPayAmountBalanceCell.h"
#import "QSPayAmountItem.h"

@interface QSPayAmountBalanceCell ()

@property (nonatomic, strong) UILabel *balanceTitleLabel;
@property (nonatomic, strong) UILabel *balanceLabel;

@end

@implementation QSPayAmountBalanceCell

- (void)configureSubViews {
    [self.contentView addSubview:self.balanceTitleLabel];
    [self.contentView addSubview:self.balanceLabel];

    [self.balanceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-kRealValue(5));
        make.left.equalTo(self.contentView).offset(kRealValue(20));
        make.right.equalTo(self.contentView).offset(-kRealValue(20));
        make.height.equalTo(@([UIFont qs_fontOfSize15].lineHeight));
    }];
    
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_centerY).offset(kRealValue(5));
        make.left.equalTo(self.contentView).offset(kRealValue(20));
        make.right.equalTo(self.contentView).offset(-kRealValue(20));
        make.height.equalTo(@([UIFont qs_fontOfSize14].lineHeight));
    }];
}

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    self.item = item;
    
    QSPayAmountItem *payItem = (QSPayAmountItem *)item;
    self.balanceLabel.text = payItem.balance;
}

#pragma mark - **************** Setter Getter
- (UILabel *)balanceTitleLabel {
    if (!_balanceTitleLabel) {
        _balanceTitleLabel = [UILabel labelWithName:QSLocalizedString(@"qs_pay_amount_item_balance_title") font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    }
    return _balanceTitleLabel;
}

- (UILabel *)balanceLabel {
    if (!_balanceLabel) {
        _balanceLabel = [UILabel labelWithName:nil font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    }
    return _balanceLabel;
}

@end
