//
//  QSCreateFTTextCell.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/11.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateFTTextCell.h"
#import "QSCreateFTItem.h"

@implementation QSCreateFTTextCell

- (void)configureSubViews {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self loadUI];
}

- (void)loadUI {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kRealValue(20));
        make.top.equalTo(self.contentView).offset(kRealValue(15));
        make.right.equalTo(self.contentView).offset(-kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.right.equalTo(self.contentView).offset(-kRealValue(20));
        make.bottom.equalTo(self.contentView);
    }];
}

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    self.item = item;
    
    QSCreateFTItem *FTItem = (QSCreateFTItem *)item;
    self.titleLabel.text = FTItem.title;
    self.contentTextField.text = FTItem.content;
    if (FTItem.placeholde) {
        //* iOS 13关闭了权限， 不允许KVC给PlaceholderLabel属性赋值 */
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc]  initWithString:FTItem.placeholde attributes:@{NSForegroundColorAttributeName : [UIColor qs_colorGrayBBBBBB], NSFontAttributeName : [UIFont qs_fontOfSize15]}];
        _contentTextField.attributedPlaceholder = placeholderString;
    }else{
        _contentTextField.attributedPlaceholder = nil;
    }
    
    self.contentTextField.keyboardType = FTItem.KeyboardType;
}

#pragma mark - **************** Block
- (void)textFieldDidChange :(UITextField *)theTextField {
    QSCreateFTItem *FTItem = (QSCreateFTItem *)self.item;
    if ([FTItem.title isEqualToString:QSLocalizedString(@"qs_select_ft_token_title")]) {
        //代币简称
        theTextField.text = [theTextField.text uppercaseString];
        if (theTextField.text.length > 7) {
            theTextField.text = [theTextField.text substringToIndex:7];
        }
    } else if ([FTItem.title isEqualToString:QSLocalizedString(@"qs_select_ft_assetNumbers_title")]) {
        //资产编号
        if (theTextField.text.length > 9) {
            theTextField.text = [theTextField.text substringToIndex:9];
        }
    } else if ([FTItem.title isEqualToString:QSLocalizedString(@"qs_select_ft_precision_title")]) {
        //精度
        if (theTextField.text.length > 2) {
            theTextField.text = [theTextField.text substringToIndex:2];
        }
    } else if ([FTItem.title isEqualToString:QSLocalizedString(@"qs_select_ft_circulation_title")]) {
        //发行总量
        if (theTextField.text.length > 19) {
            theTextField.text = [theTextField.text substringToIndex:19];
        }
    }
    
    FTItem.content = theTextField.text;
    
    if (FTItem.createFTItemTextBlock) {
        FTItem.createFTItemTextBlock(theTextField.text);
    }
}

#pragma mark - **************** Setter Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont qs_fontOfSize16];
        _titleLabel.textColor = [UIColor qs_colorBlack333333];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UITextField *)contentTextField {
    if (!_contentTextField) {
        _contentTextField = [[UITextField alloc] init];
        _contentTextField.textColor = [UIColor qs_colorBlack333333];
        _contentTextField.font = [UIFont qs_fontOfSize15];
//        [_contentTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
//        [_contentTextField setValue:[UIFont qs_fontOfSize15] forKeyPath:@"_placeholderLabel.font"];
                
        [_contentTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:_contentTextField];
    }
    return _contentTextField;
    
}

@end
