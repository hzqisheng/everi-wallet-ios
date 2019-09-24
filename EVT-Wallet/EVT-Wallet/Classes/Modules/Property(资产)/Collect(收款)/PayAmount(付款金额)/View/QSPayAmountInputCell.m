//
//  QSPayAmountInputCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/6.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSPayAmountInputCell.h"
#import "QSPayAmountItem.h"

@interface QSPayAmountInputCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation QSPayAmountInputCell

- (void)configureSubViews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-kRealValue(5));
        make.left.equalTo(self.contentView).offset(kRealValue(20));
        make.right.equalTo(self.contentView).offset(-kRealValue(20));
        make.height.equalTo(@([UIFont qs_fontOfSize15].lineHeight));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.equalTo(self.contentView).offset(kRealValue(20));
        make.right.equalTo(self.contentView).offset(-kRealValue(20));
        make.bottom.equalTo(self.contentView);
    }];
}

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    self.item = item;
    
    QSPayAmountItem *amountItem = (QSPayAmountItem *)item;
    self.titleLabel.text = amountItem.inputTitle;
    self.textField.placeholder = amountItem.inputPlaceholder;
    self.textField.keyboardType = amountItem.keyType;
}

#pragma mark - **************** Block
- (void)textFieldDidChange :(UITextField *)theTextField {
    QSPayAmountItem *FTItem = (QSPayAmountItem *)self.item;
    if (FTItem.payAmountItemTextBlock) {
        FTItem.payAmountItemTextBlock(self.textField.text);
    }
}

#pragma mark - **************** Setter Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithName:QSLocalizedString(@"") font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"Please input";
//        [_textField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
//        [_textField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        
        //* iOS 13关闭了权限， 不允许KVC给PlaceholderLabel属性赋值 */
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc]  initWithString:@"Please input" attributes:@{NSForegroundColorAttributeName : [UIColor qs_colorGrayBBBBBB], NSFontAttributeName : [UIFont qs_fontOfSize14]}];
        _textField.attributedPlaceholder = placeholderString;
        
        _textField.textColor = [UIColor qs_colorBlack313745];
        _textField.font = [UIFont qs_fontOfSize14];
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}


@end
