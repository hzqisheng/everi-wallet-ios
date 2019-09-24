//
//  QSAddGroupMetaDataViewController.m
//  EVT-Wallet
//
//  Created by SJ on 2019/5/10.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSAddMetaDataViewController.h"

@interface QSAddMetaDataViewController ()

@property (nonatomic, strong) UIView *whiteCornerView;
@property (nonatomic, strong) UILabel *keyLabel;
@property (nonatomic, strong) UITextField *keyTextField;
@property (nonatomic, strong) UIView *keyBottomSepLine;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UITextField *valueTextField;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation QSAddMetaDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_add_group_metadata_nav_title")];
    
    [self.view addSubview:self.whiteCornerView];
    [self.whiteCornerView addSubview:self.keyLabel];
    [self.whiteCornerView addSubview:self.keyTextField];
    [self.whiteCornerView addSubview:self.keyBottomSepLine];
    [self.whiteCornerView addSubview:self.valueLabel];
    [self.whiteCornerView addSubview:self.valueTextField];
    [self.view addSubview:self.confirmButton];

    [self.whiteCornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kRealValue(15));
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
    }];
    
    [self.keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteCornerView).offset(kRealValue(10));
        make.left.equalTo(self.whiteCornerView).offset(kRealValue(20));
        make.right.equalTo(self.whiteCornerView).offset(-kRealValue(20));
    }];
    
    [self.keyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.keyLabel.mas_bottom);
        make.left.and.right.equalTo(self.keyLabel);
        make.height.equalTo(@kRealValue(40));
    }];
    
    [self.keyBottomSepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.keyTextField.mas_bottom);
        make.left.and.right.equalTo(self.whiteCornerView);
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.keyBottomSepLine.mas_bottom).offset(kRealValue(10));
        make.left.and.right.equalTo(self.keyLabel);
    }];
    
    [self.valueTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.valueLabel.mas_bottom);
        make.height.and.left.and.right.equalTo(self.keyTextField);
        make.bottom.equalTo(self.whiteCornerView);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteCornerView.mas_bottom).offset(kRealValue(30));
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
        make.height.equalTo(@kRealValue(40));
    }];
}

#pragma mark - ***************** Event Response
- (void)confirmButtonClicked {
    [self.view endEditing:YES];
    
    if (!self.keyTextField.text.length
        || !self.valueTextField.text.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_add_group_metadata_input_title")];
        return;
    }
    
    if (self.addMetaDataBlock) {
        self.addMetaDataBlock(self.keyTextField.text, self.valueTextField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ***************** Setter Getter
- (UIView *)whiteCornerView {
    if (!_whiteCornerView) {
        _whiteCornerView = [[UIView alloc] init];
        _whiteCornerView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _whiteCornerView.layer.cornerRadius = kRealValue(8);
    }
    return _whiteCornerView;
}

- (UILabel *)keyLabel {
    if (!_keyLabel) {
        _keyLabel = [[UILabel alloc] init];
        _keyLabel.text = @"Key";
        _keyLabel.textColor = [UIColor qs_colorBlack333333];
        _keyLabel.font = [UIFont qs_fontOfSize14];
    }
    return _keyLabel;
}

- (UITextField *)keyTextField {
    if (!_keyTextField) {
        _keyTextField = [[UITextField alloc] init];
        _keyTextField.placeholder = QSLocalizedString(@"qs_add_group_metadata_input_title");
        _keyTextField.textColor = [UIColor qs_colorBlack333333];
        _keyTextField.font = [UIFont qs_fontOfSize14];
//        [_keyTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
//        [_keyTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        
        //* iOS 13关闭了权限， 不允许KVC给PlaceholderLabel属性赋值 */
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc]  initWithString:QSLocalizedString(@"qs_add_group_metadata_input_title") attributes:@{NSForegroundColorAttributeName : [UIColor qs_colorGrayBBBBBB], NSFontAttributeName : [UIFont qs_fontOfSize14]}];
        _keyTextField.attributedPlaceholder = placeholderString;
        
        _keyTextField.keyboardType = UIKeyboardTypeAlphabet;
        _keyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _keyTextField;
}

- (UIView *)keyBottomSepLine {
    if (!_keyBottomSepLine) {
        _keyBottomSepLine = [[UIView alloc] init];
        _keyBottomSepLine.backgroundColor = [UIColor qs_colorGrayDDDDDD];
    }
    return _keyBottomSepLine;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.text = QSLocalizedString(@"qs_add_group_metadata_value_title");
        _valueLabel.textColor = [UIColor qs_colorBlack333333];
        _valueLabel.font = [UIFont qs_fontOfSize14];
    }
    return _valueLabel;
}

- (UITextField *)valueTextField {
    if (!_valueTextField) {
        _valueTextField = [[UITextField alloc] init];
        _valueTextField.placeholder = QSLocalizedString(@"qs_add_group_metadata_input_title");
        _valueTextField.textColor = [UIColor qs_colorBlack333333];
        _valueTextField.font = [UIFont qs_fontOfSize14];
//        [_valueTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
//        [_valueTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        //* iOS 13关闭了权限， 不允许KVC给PlaceholderLabel属性赋值 */
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc]  initWithString:QSLocalizedString(@"qs_add_group_metadata_input_title") attributes:@{NSForegroundColorAttributeName : [UIColor qs_colorGrayBBBBBB], NSFontAttributeName : [UIFont qs_fontOfSize14]}];
        _valueTextField.attributedPlaceholder = placeholderString;
        _valueTextField.keyboardType = UIKeyboardTypeAlphabet;
        _valueTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _valueTextField;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_add_group_metadata_confrm_btn_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(confirmButtonClicked)];
        _confirmButton.backgroundColor = [UIColor qs_colorBlack313745];
        _confirmButton.layer.cornerRadius = 2;
    }
    return _confirmButton;
}

@end
