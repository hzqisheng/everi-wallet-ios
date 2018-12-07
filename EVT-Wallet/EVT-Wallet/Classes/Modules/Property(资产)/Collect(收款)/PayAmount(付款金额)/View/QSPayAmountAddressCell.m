//
//  QSPayAmountAddressCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/6.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSPayAmountAddressCell.h"

@interface QSPayAmountAddressCell ()

@property (nonatomic, strong) UILabel *addressTitleLabel;
@property (nonatomic, strong) UIImageView *addressImageView;
@property (nonatomic, strong) UILabel *addressSelectLabel;
@property (nonatomic, strong) UIButton *addressScanButton;

@end

@implementation QSPayAmountAddressCell

- (void)configureSubViews {
    [self.contentView addSubview:self.addressTitleLabel];
    [self.contentView addSubview:self.addressImageView];
    [self.contentView addSubview:self.addressSelectLabel];
    [self.contentView addSubview:self.addressScanButton];
    
    [self.addressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-kRealValue(5));
        make.left.equalTo(self.contentView).offset(kRealValue(20));
        make.width.lessThanOrEqualTo(@kRealValue(60));
    }];
    
    [self.addressSelectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_centerY).offset(kRealValue(5));
        make.left.equalTo(self.contentView).offset(kRealValue(20));
        make.right.equalTo(self.addressScanButton.mas_left).offset(-kRealValue(20));
    }];

    [self.addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressTitleLabel.mas_right).offset(kRealValue(10));
        make.centerY.equalTo(self.addressTitleLabel);
        make.width.and.height.equalTo(@kRealValue(22));
    }];
    
    [self.addressScanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-kRealValue(10));
        make.width.and.height.equalTo(@kRealValue(42));
    }];
}

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    self.item = item;
}

#pragma mark - **************** Event Response
- (void)addressScanButtonClicked {
    
}

#pragma mark - **************** Setter Getter
- (UILabel *)addressTitleLabel {
    if (!_addressTitleLabel) {
        _addressTitleLabel = [UILabel labelWithName:QSLocalizedString(@"qs_pay_amount_item_address_title") font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    }
    return _addressTitleLabel;
}

- (UIImageView *)addressImageView {
    if (!_addressImageView) {
        _addressImageView = [[UIImageView alloc] init];
        _addressImageView.image = [UIImage imageNamed:@"icon_fukuan_dress"];
    }
    return _addressImageView;
}

- (UILabel *)addressSelectLabel {
    if (!_addressSelectLabel) {
        _addressSelectLabel = [UILabel labelWithName:QSLocalizedString(@"qs_pay_amount_item_address_placeholder") font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGrayBBBBBB] textAlignment:NSTextAlignmentLeft];
    }
    return _addressSelectLabel;
}

- (UIButton *)addressScanButton {
    if (!_addressScanButton) {
        _addressScanButton = [UIButton buttonWithImage:@"icon_fukuan_sweep" taget:self action:@selector(addressScanButtonClicked)];
    }
    return _addressScanButton;
}

@end
