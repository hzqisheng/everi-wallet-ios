//
//  QSQRCodeMaxPayAmountCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSQRCodeMaxPayAmountCell.h"
#import "QSQRCodeScanItem.h"

@interface QSQRCodeMaxPayAmountCell ()

@property (nonatomic, strong) UILabel *maxPayAmountTipsLabel;
@property (nonatomic, strong) UITextField *maxPayAmountTextField;

@end

@implementation QSQRCodeMaxPayAmountCell

- (void)configureSubViews {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.maxPayAmountTipsLabel];
    [self.contentView addSubview:self.maxPayAmountTextField];
    
    [self.maxPayAmountTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kRealValue(24));
        make.width.lessThanOrEqualTo(@kRealValue(140));
    }];
    
    [self.maxPayAmountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-kRealValue(24));
        make.left.equalTo(self.maxPayAmountTipsLabel.mas_right).offset(kRealValue(15));
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
}

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    self.item = item;
    QSQRCodeScanItem *codeItem = (QSQRCodeScanItem *)self.item;
    self.maxPayAmountTextField.keyboardType = codeItem.keyboardType;
}

#pragma mark - **************** Private Methods
- (void)textFieldChanged {
    QSQRCodeScanItem *codeItem = (QSQRCodeScanItem *)self.item;
    if (codeItem.codeScanItemTextChangedBlock) {
        codeItem.codeScanItemTextChangedBlock(self.maxPayAmountTextField.text);
    }
}

- (void)textFieldEndEditing {
    QSQRCodeScanItem *codeItem = (QSQRCodeScanItem *)self.item;
    if (codeItem.codeScanItemEndEditingBlock) {
        codeItem.codeScanItemEndEditingBlock();
    }
}

#pragma mark - **************** Setter Getter
- (UILabel *)maxPayAmountTipsLabel {
    if (!_maxPayAmountTipsLabel) {
        _maxPayAmountTipsLabel = [UILabel labelWithName:QSLocalizedString(@"qs_everipay_item_max_pay_title") font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    }
    return _maxPayAmountTipsLabel;
}

- (UITextField *)maxPayAmountTextField {
    if (!_maxPayAmountTextField) {
        _maxPayAmountTextField = [[UITextField alloc] init];
        _maxPayAmountTextField.text = @"100";
        _maxPayAmountTextField.placeholder = QSLocalizedString(@"qs_sytem_setting_item_payment_title");
        _maxPayAmountTextField.textColor = [UIColor qs_colorBlue4D7BF3];
        _maxPayAmountTextField.font = [UIFont qs_fontOfSize14];
        [_maxPayAmountTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        [_maxPayAmountTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        _maxPayAmountTextField.textAlignment = NSTextAlignmentRight;
        [_maxPayAmountTextField addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
        [_maxPayAmountTextField addTarget:self action:@selector(textFieldEndEditing) forControlEvents:UIControlEventEditingDidEnd];
        _maxPayAmountTextField.keyboardType = UIKeyboardTypeAlphabet;
    }
    return _maxPayAmountTextField;
}
@end
