//
//  QSAddAddressCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSAddAddressCell.h"

@interface QSAddAddressCell ()

@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation QSAddAddressCell

#pragma mark - **************** Private Methods
- (void)selectTypeButton:(UIButton *)button {
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            ((UIButton *)view).selected = NO;
            ((UIButton *)view).layer.borderColor = [UIColor qs_colorGray686868].CGColor;
            ((UIButton *)view).backgroundColor = [UIColor whiteColor];
            if (button == view) {
                ((UIButton *)view).selected = YES;
                ((UIButton *)view).layer.borderColor = [UIColor qs_colorBlue4D7BF3].CGColor;
                ((UIButton *)view).backgroundColor = [UIColor qs_colorBlue4D7BF3];
                self.addressItem.typeClickedBlock(self);
            }
        }
    }
}

#pragma mark - **************** Event Response
- (void)evtButtonClicked:(UIButton *)button {
    [self selectTypeButton:button];
}

- (void)ethButtonClicked:(UIButton *)button {
    [self selectTypeButton:button];
}

- (void)eosButtonClicked:(UIButton *)button {
    [self selectTypeButton:button];
}

- (void)scanButtonClicked {
    if (self.addressItem.scanClickedBlock) {
        self.addressItem.scanClickedBlock(self);
    }
}

#pragma mark - **************** Setter Getter
- (UIButton *)evtButton {
    if (!_evtButton) {
        _evtButton = [UIButton buttonWithTitle:@"EVT" titleColor:[UIColor qs_colorBlack313745] font:[UIFont qs_fontOfSize15] taget:self action:@selector(evtButtonClicked:)];
        [_evtButton setTitleColor:[UIColor qs_colorWhiteFFFFFF] forState:UIControlStateSelected];
        _evtButton.layer.cornerRadius = 3;
        _evtButton.layer.borderWidth = 1;
        _evtButton.selected = YES;
        _evtButton.layer.borderColor = [UIColor qs_colorBlue4D7BF3].CGColor;
        _evtButton.backgroundColor = [UIColor qs_colorBlue4D7BF3];
    }
    return _evtButton;
}

- (UIButton *)ethButton {
    if (!_ethButton) {
        _ethButton = [UIButton buttonWithTitle:@"ETH" titleColor:[UIColor qs_colorGray686868] font:[UIFont qs_fontOfSize15] taget:self action:@selector(ethButtonClicked:)];
        [_ethButton setTitleColor:[UIColor qs_colorWhiteFFFFFF] forState:UIControlStateSelected];
        _ethButton.layer.cornerRadius = 3;
        _ethButton.layer.borderWidth = 1;
        _ethButton.layer.borderColor = [UIColor qs_colorGray686868].CGColor;
        _ethButton.hidden = YES;
    }
    return _ethButton;
}

- (UIButton *)eosButton {
    if (!_eosButton) {
        _eosButton = [UIButton buttonWithTitle:@"EOS" titleColor:[UIColor qs_colorGray686868] font:[UIFont qs_fontOfSize15] taget:self action:@selector(eosButtonClicked:)];
        [_eosButton setTitleColor:[UIColor qs_colorWhiteFFFFFF] forState:UIControlStateSelected];
        _eosButton.layer.cornerRadius = 3;
        _eosButton.layer.borderWidth = 1;
        _eosButton.layer.borderColor = [UIColor qs_colorGray686868].CGColor;
        _eosButton.hidden = YES;
    }
    return _eosButton;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"Please input";
        [_textField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        [_textField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        _textField.textColor = [UIColor qs_colorBlack313745];
        _textField.font = [UIFont qs_fontOfSize14];
        @weakify(self);
        [_textField.rac_textSignal subscribeNext:^(id x) {
            @strongify(self);
            self.addressItem.textFieldText = x;
            if (self.addressItem.textFieldTextChangedBlock) {
                self.addressItem.textFieldTextChangedBlock(self);
            }
        }];
        [self addSubview:_textField];
    }
    return _textField;
}

- (UIButton *)scanButton {
    if (!_scanButton) {
        _scanButton = [[UIButton alloc] init];
        [_scanButton setImage:[UIImage imageNamed:@"icon_dizhiguanli_sweep"] forState:UIControlStateNormal];
        [_scanButton addTarget:self action:@selector(scanButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanButton;
}

- (NSInteger)selectedType {
    if (self.ethButton.selected) {
        return QSAddAddressSelectdTypeETH;
    } else if (self.eosButton.selected) {
        return QSAddAddressSelectdTypeEOS;
    }
    return QSAddAddressSelectdTypeEVT;
}

- (void)configureLeftSubViewsWithItem:(QSAddAddressItem *)item {
    _addressItem = item;
    
    //leftTitleLabel fixed
    [self.contentView addSubview:self.leftTitleLabel];
    self.leftTitleLabel.font = item.leftTitleFont;
    self.leftTitleLabel.textColor = item.leftTitleColor;
    self.leftTitleLabel.frame = CGRectMake(item.leftImageAndTitleSpace, item.cellHeight/2 - item.leftTitleLabelSize.height/2, item.leftTitleLabelSize.width, item.leftTitleLabelSize.height);
    self.leftTitleLabel.text = item.leftTitle;
    
}

@end
