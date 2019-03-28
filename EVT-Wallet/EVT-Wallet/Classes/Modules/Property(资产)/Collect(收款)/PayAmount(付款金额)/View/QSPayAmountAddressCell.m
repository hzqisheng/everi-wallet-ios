//
//  QSPayAmountAddressCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/6.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSPayAmountAddressCell.h"
#import "QSPayAmountItem.h"

@interface QSPayAmountAddressCell ()

@property (nonatomic, strong) UILabel *addressTitleLabel;
@property (nonatomic, strong) UIButton *addressSelectButton;
@property (nonatomic, strong) UITextField *addressSelectLabel;
@property (nonatomic, strong) UIButton *addressScanButton;

@end

@implementation QSPayAmountAddressCell

- (void)configureSubViews {
    [self.contentView addSubview:self.addressTitleLabel];
    [self.contentView addSubview:self.addressSelectButton];
    [self.contentView addSubview:self.addressSelectLabel];
    [self.contentView addSubview:self.addressScanButton];
    
    [self.addressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-kRealValue(5));
        make.left.equalTo(self.contentView).offset(kRealValue(20));
        make.width.lessThanOrEqualTo(@kRealValue(60));
    }];
    
    [self.addressSelectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressTitleLabel.mas_bottom);
        make.left.equalTo(self.contentView).offset(kRealValue(20));
        make.right.equalTo(self.addressScanButton.mas_left).offset(-kRealValue(20));
        make.bottom.equalTo(self.contentView);
    }];

    [self.addressSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
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
    QSPayAmountItem *payItem = (QSPayAmountItem *)item;
    if (payItem.address.length) {
        self.addressSelectLabel.text = payItem.address;
    }
}

#pragma mark - **************** Event Response
- (void)addressScanButtonClicked {
    QSPayAmountItem *payItem = (QSPayAmountItem *)self.item;
    if (payItem.payAmountItemSweepBlock) {
        payItem.payAmountItemSweepBlock();
    }
}

- (void)addressSelectButtonClicked {
    QSPayAmountItem *payItem = (QSPayAmountItem *)self.item;
    if (payItem.payAmountItemSelectAddressBlock) {
        payItem.payAmountItemSelectAddressBlock();
    }
}

-(void)textFieldDidChange:(UITextField *)theTextField{
    QSPayAmountItem *FTItem = (QSPayAmountItem *)self.item;
    if (FTItem.addressTextChangeBlock) {
        FTItem.addressTextChangeBlock(self.addressSelectLabel.text);
    }
}

#pragma mark - **************** Setter Getter
- (UILabel *)addressTitleLabel {
    if (!_addressTitleLabel) {
        _addressTitleLabel = [UILabel labelWithName:QSLocalizedString(@"qs_pay_amount_item_address_title") font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    }
    return _addressTitleLabel;
}

- (UIButton *)addressSelectButton {
    if (!_addressSelectButton) {
        _addressSelectButton = [[UIButton alloc] init];
        [_addressSelectButton setImage:[UIImage imageNamed:@"icon_fukuan_dress"] forState:UIControlStateNormal];
        [_addressSelectButton addTarget:self action:@selector(addressSelectButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressSelectButton;
}

- (UITextField *)addressSelectLabel {
    if (!_addressSelectLabel) {
//        _addressSelectLabel = [UILabel labelWithName:QSLocalizedString(@"qs_pay_amount_item_address_placeholder") font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGrayBBBBBB] textAlignment:NSTextAlignmentLeft];
        _addressSelectLabel = [[UITextField alloc] init];
        _addressSelectLabel.placeholder = QSLocalizedString(@"qs_pay_amount_item_address_placeholder");
        _addressSelectLabel.textColor = [UIColor qs_colorBlack333333];
        _addressSelectLabel.font = [UIFont qs_fontOfSize14];
        [_addressSelectLabel setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        [_addressSelectLabel setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        _addressSelectLabel.keyboardType = UIKeyboardTypeAlphabet;
        _addressSelectLabel.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_addressSelectLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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
