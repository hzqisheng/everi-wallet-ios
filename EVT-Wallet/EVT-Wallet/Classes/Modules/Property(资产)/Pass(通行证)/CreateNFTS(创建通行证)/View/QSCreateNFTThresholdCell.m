//
//  QSCreateNFTThresholdCell.m
//  EVT-Wallet
//
//  Created by SJ on 2019/5/13.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateNFTThresholdCell.h"
#import "QSCreateNFTThresholdItem.h"

@interface QSCreateNFTThresholdCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *thresholdLabel;
@property (nonatomic, strong) UIButton *thresholdSubtractButton;
@property (nonatomic, strong) UIButton *thresholdAddButton;
@property (nonatomic, strong) UITextField *thresholdCountTextField;

@end

@implementation QSCreateNFTThresholdCell

- (void)configureSubViews {
    [self.contentView addSubview:self.thresholdLabel];
    [self.contentView addSubview:self.thresholdSubtractButton];
    [self.contentView addSubview:self.thresholdAddButton];
    [self.contentView addSubview:self.thresholdCountTextField];

    [self.thresholdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kRealValue(15));
        make.width.lessThanOrEqualTo(@kRealValue(100));
    }];
    
    [self.thresholdAddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-kRealValue(15));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.thresholdCountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.thresholdAddButton.mas_left);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(kRealValue(38), kRealValue(24)));
    }];
    
    [self.thresholdSubtractButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.thresholdCountTextField.mas_left);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
}

- (void)configureCellWithItem:(id<QSBaseCellItemDataProtocol>)item {
    self.item = item;
    
    if (![item isKindOfClass:[QSCreateNFTThresholdItem class]]) {
        return;
    }
    
    QSCreateNFTThresholdItem *thresholdItem = (QSCreateNFTThresholdItem *)self.item;

    self.thresholdCountTextField.text = [NSString stringWithFormat:@"%ld", (long)thresholdItem.threshold];
}

#pragma mark - ***************** Event Response
- (void)thresholdSubtractAction {
    DLog(@"减少");
    if (self.thresholdCountTextField.text.integerValue <= 1) {
        return;
    }
    
    self.thresholdCountTextField.text = [NSString stringWithFormat:@"%ld", (long)self.thresholdCountTextField.text.integerValue - 1];
    QSCreateNFTThresholdItem *thresholdItem = (QSCreateNFTThresholdItem *)self.item;
    thresholdItem.threshold = self.thresholdCountTextField.text.integerValue;
    
    if (thresholdItem.thresholdDidChangeBlock) {
        thresholdItem.thresholdDidChangeBlock(self.thresholdCountTextField.text.integerValue);
    }
}

- (void)thresholdAddAction {
    DLog(@"增加");
    self.thresholdCountTextField.text = [NSString stringWithFormat:@"%ld", self.thresholdCountTextField.text.integerValue + 1];
    QSCreateNFTThresholdItem *thresholdItem = (QSCreateNFTThresholdItem *)self.item;
    thresholdItem.threshold = self.thresholdCountTextField.text.integerValue;
    
    if (thresholdItem.thresholdDidChangeBlock) {
        thresholdItem.thresholdDidChangeBlock(self.thresholdCountTextField.text.integerValue);
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    QSCreateNFTThresholdItem *thresholdItem = (QSCreateNFTThresholdItem *)self.item;
    thresholdItem.threshold = textField.text.integerValue;
    
    if (thresholdItem.thresholdDidChangeBlock) {
        thresholdItem.thresholdDidChangeBlock(self.thresholdCountTextField.text.integerValue);
    }
}

#pragma mark - ***************** UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (!textField.text.length) {
        textField.text = @"1";
    }
    return YES;
}

#pragma mark - ***************** Setter Getter
- (UILabel *)thresholdLabel {
    if (!_thresholdLabel) {
        _thresholdLabel = [[UILabel alloc] init];
        _thresholdLabel.text = QSLocalizedString(@"qs_pass_createNFTS_threshold_title");
        _thresholdLabel.textColor = [UIColor qs_colorBlack313745];
        _thresholdLabel.font = [UIFont qs_fontOfSize14];
    }
    return _thresholdLabel;
}

- (UIButton *)thresholdSubtractButton {
    if (!_thresholdSubtractButton) {
        _thresholdSubtractButton = [[UIButton alloc] init];
        [_thresholdSubtractButton setImage:[UIImage imageNamed:@"icon_wodeyu_minus"] forState:UIControlStateNormal];
        [_thresholdSubtractButton addTarget:self action:@selector(thresholdSubtractAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _thresholdSubtractButton;
}

- (UIButton *)thresholdAddButton {
    if (!_thresholdAddButton) {
        _thresholdAddButton = [[UIButton alloc] init];
        [_thresholdAddButton setImage:[UIImage imageNamed:@"icon_wodeyu_plus"] forState:UIControlStateNormal];
        [_thresholdAddButton addTarget:self action:@selector(thresholdAddAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _thresholdAddButton;
}

- (UITextField *)thresholdCountTextField {
    if (!_thresholdCountTextField) {
        _thresholdCountTextField = [[UITextField alloc] init];
        _thresholdCountTextField.textColor = [UIColor qs_colorBlack313745];
        _thresholdCountTextField.font = [UIFont qs_fontOfSize14];
        [_thresholdCountTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        [_thresholdCountTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        _thresholdCountTextField.textAlignment = NSTextAlignmentCenter;
        _thresholdCountTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_thresholdCountTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _thresholdCountTextField.delegate = self;
    }
    return _thresholdCountTextField;
}

@end
