//
//  QSCreateNFTDomainNameCell.m
//  EVT-Wallet
//
//  Created by SJ on 2019/5/13.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateNFTDomainNameCell.h"
#import "QSCreateNFTDomainNameItem.h"

@interface QSCreateNFTDomainNameCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *nameTextField;

@end

@implementation QSCreateNFTDomainNameCell

- (void)configureSubViews {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.nameTextField];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kRealValue(15));
        make.width.lessThanOrEqualTo(@kRealValue(100));
    }];
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-kRealValue(15));
        make.left.equalTo(self.nameLabel.mas_right).offset(kRealValue(10));
    }];
}

- (void)configureCellWithItem:(id<QSBaseCellItemDataProtocol>)item {
    self.item = item;
    
    QSCreateNFTDomainNameItem *nameItem = (QSCreateNFTDomainNameItem *)self.item;

    self.nameTextField.text = nameItem.domainName;
}

#pragma mark - ***************** Event Response
- (void)textFieldDidChange:(UITextField *)textField {
    QSCreateNFTDomainNameItem *nameItem = (QSCreateNFTDomainNameItem *)self.item;
    nameItem.domainName = textField.text;
    
    if (nameItem.domainNameDidChangeBlock) {
        nameItem.domainNameDidChangeBlock(textField.text);
    }
}

#pragma mark - ***************** Setter Getter
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithName:QSLocalizedString(@"qs_pass_createNFTS_yu_title") font:[UIFont qs_fontOfSize16] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}

- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.placeholder = QSLocalizedString(@"qs_pass_createNFTS_yu_placeholder");
        _nameTextField.textColor = [UIColor qs_colorBlack333333];
        _nameTextField.font = [UIFont qs_fontOfSize14];
        [_nameTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        [_nameTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        _nameTextField.textAlignment = NSTextAlignmentRight;
        _nameTextField.keyboardType = UIKeyboardTypeAlphabet;
        [_nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _nameTextField;
}

@end
