//
//  QSImportWalletViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/3.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSImportWalletByMnemonicCodeViewController.h"

@interface QSImportWalletByMnemonicCodeViewController ()

@property (nonatomic, strong) UIView *inputCornerView;
@property (nonatomic, strong) YYTextView *mnemonicCodeTextView;
@property (nonatomic, strong) UITextField *freshPwdTextfield;
@property (nonatomic, strong) UITextField *comfirmPwdTextfield;
@property (nonatomic, strong) UIImageView *mentionBackgroundImageView;
@property (nonatomic, strong) YYLabel *mentionsLabel;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation QSImportWalletByMnemonicCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_import_wallet_nav_title")];
    [self p_setupSubViews];
}

- (void)p_setupSubViews {
    //inputCornerView
    UIView *inputCornerView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kScreenWidth - kRealValue(30), kRealValue(180))];
    inputCornerView.backgroundColor = [UIColor whiteColor];
    inputCornerView.layer.cornerRadius = 8;
    [self.view addSubview:inputCornerView];
    _inputCornerView = inputCornerView;
    
    _mnemonicCodeTextView = [self createTextView];
    _mnemonicCodeTextView.frame = CGRectMake(kRealValue(15), kRealValue(15), inputCornerView.width - kRealValue(30), kRealValue(54));
    _mnemonicCodeTextView.placeholderText = QSLocalizedString(@"qs_import_wallet_item_mnemonic_title");
    [_inputCornerView addSubview:_mnemonicCodeTextView];
    
    _freshPwdTextfield = [self createInputTextField];
    _freshPwdTextfield.frame = CGRectMake(_mnemonicCodeTextView.x, _mnemonicCodeTextView.maxY + kRealValue(15), _mnemonicCodeTextView.width, kRealValue(33));
    _freshPwdTextfield.placeholder = QSLocalizedString(@"qs_import_wallet_item_password_title");
    [_inputCornerView addSubview:_freshPwdTextfield];
    
    _comfirmPwdTextfield = [self createInputTextField];
    _comfirmPwdTextfield.frame = CGRectMake(_mnemonicCodeTextView.x, _freshPwdTextfield.maxY + kRealValue(15), _mnemonicCodeTextView.width, _freshPwdTextfield.height);
    _comfirmPwdTextfield.placeholder = QSLocalizedString(@"qs_import_wallet_item_confirm_password_title");
    [_inputCornerView addSubview:_comfirmPwdTextfield];
    
    //mentionBackgroundImageView
    _mentionBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(30), _inputCornerView.maxY + kRealValue(20), kScreenWidth - kRealValue(60), kRealValue(86))];
    _mentionBackgroundImageView.image = [UIImage imageNamed:@"img_daoruqianbao"];
    [self.view addSubview:_mentionBackgroundImageView];
    
    //tipsLabel
    NSString *totalText = QSLocalizedString(@"qs_import_wallet_item_metion_total_title");
    NSString *highlightText = QSLocalizedString(@"qs_import_wallet_item_metion_highlight_title");
    _mentionsLabel = [YYLabel new];
    _mentionsLabel.numberOfLines = 0;
    _mentionsLabel.frame = CGRectMake(kRealValue(15),  kRealValue(15), _mentionBackgroundImageView.width - kRealValue(30), kRealValue(55));

    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:totalText ];
    [attr yy_setFont:[UIFont qs_fontOfSize13] range:NSMakeRange(0, attr.length)];
    [attr yy_setColor:[UIColor qs_colorGray686868] range:NSMakeRange(0, attr.length)];
    [attr yy_setColor:[UIColor qs_colorBlue4D7BF3] range:[totalText rangeOfString:highlightText]];
    _mentionsLabel.attributedText = attr;
    [_mentionsLabel sizeToFit];
    _mentionBackgroundImageView.height = _mentionsLabel.height + kRealValue(30);
    [self.mentionBackgroundImageView addSubview:_mentionsLabel];

    //modify Button
    _confirmButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_import_wallet_btn_confirm_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(comfirmButtonClicked)];
    _confirmButton.frame = CGRectMake(kScreenWidth/2 - kBottomButtonWidth/2, _mentionBackgroundImageView.maxY + kRealValue(30), kBottomButtonWidth, kBottomButtonHeight);
    _confirmButton.backgroundColor = [UIColor qs_colorBlack313745];
    _confirmButton.layer.cornerRadius = 4;
    [self.view addSubview:_confirmButton];
}

#pragma mark - **************** Event Response
- (void)comfirmButtonClicked {
    
}

#pragma mark - **************** Private Methods
- (UITextField *)createInputTextField {
    UITextField *textField = [[UITextField alloc] init];
    [textField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
    textField.textColor = [UIColor qs_colorBlack313745];
    textField.font = [UIFont qs_fontOfSize14];
    textField.layer.borderWidth = BORDER_WIDTH_1PX;
    textField.layer.borderColor = [UIColor qs_colorGrayBBBBBB].CGColor;
    textField.secureTextEntry = YES;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, kRealValue(33))];
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
    textView.layer.borderWidth = BORDER_WIDTH_1PX;
    textView.layer.borderColor = [UIColor qs_colorGrayBBBBBB].CGColor;
    textView.contentInset = UIEdgeInsetsMake(5, 10, 5, -10);
    return textView;
}

@end
