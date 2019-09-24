//
//  QSEveriPassTransferAddressInputCell.m
//  EVT-Wallet
//
//  Created by SJ on 2019/8/5.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSEveriPassTransferAddressInputCell.h"
#import "QSEveriPassTransferAddressInputItem.h"

@interface QSEveriPassTransferAddressInputCell ()

@property (nonatomic, strong) UITextField *addressTextField;

@end

@implementation QSEveriPassTransferAddressInputCell

- (void)configureSubViews {
    UITextField *addressTextField = [[UITextField alloc] init];
    addressTextField.placeholder = QSLocalizedString(@"qs_transfer_nft_address_placeholder");
    addressTextField.textColor = [UIColor qs_colorBlack333333];
    addressTextField.font = [UIFont qs_fontOfSize14];
//    [addressTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
//    [addressTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
    
    //* iOS 13关闭了权限， 不允许KVC给PlaceholderLabel属性赋值 */
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc]  initWithString:QSLocalizedString(@"qs_transfer_nft_address_placeholder") attributes:@{NSForegroundColorAttributeName : [UIColor qs_colorGrayBBBBBB], NSFontAttributeName : [UIFont qs_fontOfSize14]}];
    addressTextField.attributedPlaceholder = placeholderString;
    
    addressTextField.textAlignment = NSTextAlignmentLeft;
    [addressTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    addressTextField.keyboardType = UIKeyboardTypeAlphabet;
    _addressTextField = addressTextField;
    [self.contentView addSubview:addressTextField];
    
    UIButton *scanButton = [UIButton buttonWithImage:@"icon_wodeyu_sweep" taget:self action:@selector(scanButtonClicked)];
    [self.contentView addSubview:scanButton];
    
    UIButton *addButton = [UIButton buttonWithImage:@"icon_wodeyu_plus1" taget:self action:@selector(addButtonClicked)];
    [self.contentView addSubview:addButton];
    
    
    [addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kRealValue(15));
        make.right.equalTo(scanButton.mas_left).offset(-kRealValue(15));
    }];
    
    [scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(addButton.mas_left).offset(-kRealValue(10));
        make.width.and.height.equalTo(@kRealValue(30));
    }];
    
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-kRealValue(15));
        make.width.and.height.equalTo(@kRealValue(30));
    }];
}

- (void)scanButtonClicked {
    QSEveriPassTransferAddressInputItem *inputItem = (QSEveriPassTransferAddressInputItem *)self.item;
    if (inputItem.everiPassTransferAddressInputScanBlock) {
        inputItem.everiPassTransferAddressInputScanBlock(inputItem);
    }
}

- (void)addButtonClicked {
    QSEveriPassTransferAddressInputItem *inputItem = (QSEveriPassTransferAddressInputItem *)self.item;
    if (inputItem.everiPassTransferAddressInputAddBlock) {
        inputItem.everiPassTransferAddressInputAddBlock(self.addressTextField.text);
    }
}

- (void)textFieldChanged:(UITextField *)textField {
    QSEveriPassTransferAddressInputItem *inputItem = (QSEveriPassTransferAddressInputItem *)self.item;
    inputItem.inputText = textField.text;
}

- (void)configureCellWithItem:(id<QSBaseCellItemDataProtocol>)item {
    self.item = item;
    
    QSEveriPassTransferAddressInputItem *inputItem = (QSEveriPassTransferAddressInputItem *)self.item;

    self.addressTextField.text = inputItem.inputText;
}

@end
