//
//  QSImportWalletByKeyStoreCodeViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSImportWalletByKeyStoreCodeViewController.h"

@interface QSImportWalletByKeyStoreCodeViewController ()

@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) YYTextView *keyStoreTextView;
@property (nonatomic, strong) UITextField *passwordTextfield;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation QSImportWalletByKeyStoreCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupSubViews];
}

- (void)p_setupSubViews {
    //tips
    self.tipsLabel = [UILabel labelWithName:QSLocalizedString(@"qs_import_wallet_key_store_tips_title") font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kRealValue(25));
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
    }];
    
    //textView
    self.keyStoreTextView = [self createTextView];
    self.keyStoreTextView.placeholderText = QSLocalizedString(@"qs_import_wallet_key_store_content_placeholder");
    [self.view addSubview:self.keyStoreTextView];
    [self.keyStoreTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.tipsLabel);
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(kRealValue(14));
        make.height.equalTo(@kRealValue(180));
    }];
    //* iOS 13关闭了权限， 不允许KVC给PlaceholderLabel属性赋值 */
       NSMutableAttributedString *keyStoreTFplaceholderString = [[NSMutableAttributedString alloc]  initWithString:QSLocalizedString(@"qs_import_wallet_key_store_content_placeholder") attributes:@{NSForegroundColorAttributeName : [UIColor qs_colorGrayBBBBBB], NSFontAttributeName : [UIFont qs_fontOfSize14]}];
       self.keyStoreTextView.placeholderAttributedText = keyStoreTFplaceholderString;
    
    
    //textfield
    self.passwordTextfield = [self createInputTextField];
    self.passwordTextfield.placeholder = QSLocalizedString(@"qs_import_wallet_key_store_pwd_placeholder");
    [self.view addSubview:self.passwordTextfield];
    [self.passwordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.tipsLabel);
        make.top.equalTo(self.keyStoreTextView.mas_bottom).offset(kRealValue(10));
        make.height.equalTo(@kRealValue(45));
    }];
    //* iOS 13关闭了权限， 不允许KVC给PlaceholderLabel属性赋值 */
    NSMutableAttributedString *passwordTFplaceholderString = [[NSMutableAttributedString alloc]  initWithString:QSLocalizedString(@"qs_import_wallet_key_store_pwd_placeholder") attributes:@{NSForegroundColorAttributeName : [UIColor qs_colorGrayBBBBBB], NSFontAttributeName : [UIFont qs_fontOfSize14]}];
    self.passwordTextfield.attributedPlaceholder = passwordTFplaceholderString;
    
    //comfirmButton
    _confirmButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_import_wallet_btn_confirm_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(comfirmButtonClicked)];
    _confirmButton.backgroundColor = [UIColor qs_colorBlack313745];
    _confirmButton.layer.cornerRadius = 4;
    [self.view addSubview:_confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.tipsLabel);
        make.top.equalTo(self.passwordTextfield.mas_bottom).offset(kRealValue(30));
        make.height.equalTo(@kRealValue(40));
    }];

}

#pragma mark - **************** Private Methods
- (UITextField *)createInputTextField {
    UITextField *textField = [[UITextField alloc] init];
//    [textField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
//    [textField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];

    textField.textColor = [UIColor qs_colorBlack313745];
    textField.font = [UIFont qs_fontOfSize14];
    textField.backgroundColor = [UIColor whiteColor];
    textField.layer.cornerRadius = 8;
    textField.secureTextEntry = YES;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, kRealValue(33))];
    textField.leftView = view;
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

- (YYTextView *)createTextView {
    YYTextView *textView = [[YYTextView alloc] init];
    textView.placeholderTextColor = [UIColor qs_colorGrayBBBBBB];
    textView.placeholderFont = [UIFont qs_fontOfSize14];
    textView.textColor = [UIColor qs_colorBlack313745];
    textView.font = [UIFont qs_fontOfSize14];
    textView.layer.cornerRadius = 8;
    textView.layer.borderColor = [UIColor qs_colorGrayBBBBBB].CGColor;
    textView.contentInset = UIEdgeInsetsMake(15, 20, 15, -20);
    textView.backgroundColor = [UIColor whiteColor];
    return textView;
}

#pragma mark - **************** Event Response
- (void)comfirmButtonClicked {
    
}

@end
