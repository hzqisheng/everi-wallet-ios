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
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRealValue(11));
        make.right.equalTo(self.contentView).offset(-kRealValue(20));
        make.height.equalTo(@kRealValue(14));
    }];
}

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    self.item = item;
    
    QSCreateFTItem *FTItem = (QSCreateFTItem *)item;
    self.titleLabel.text = FTItem.title;
    self.contentTextField.placeholder = FTItem.placeholde;
    self.contentTextField.keyboardType = FTItem.KeyboardType;
}

#pragma mark - **************** Block
-(void)textFieldDidChange :(UITextField *)theTextField{
    QSCreateFTItem *FTItem = (QSCreateFTItem *)self.item;
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
        [_contentTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        [_contentTextField setValue:[UIFont qs_fontOfSize15] forKeyPath:@"_placeholderLabel.font"];
        [_contentTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:_contentTextField];
    }
    return _contentTextField;
    
}

@end
