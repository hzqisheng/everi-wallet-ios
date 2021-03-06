//
//  QSModifyPasswordViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/3.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSModifyPasswordViewController.h"
#import "QSImportWalletByMnemonicCodeViewController.h"
#import "QSImportWalletIndexViewController.h"

@interface QSModifyPasswordViewController ()

@property (nonatomic, strong) UIView *inputCornerView;
@property (nonatomic, strong) UITextField *currentPwdTextfield;
@property (nonatomic, strong) UITextField *freshPwdTextfield;
@property (nonatomic, strong) UITextField *comfirmPwdTextfield;
@property (nonatomic, strong) YYLabel *tipsLabel;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, copy) NSString *privateKey;

@end

@implementation QSModifyPasswordViewController

- (instancetype)initWithWalletPrivateKey:(NSString *)privateKey {
    if (self = [super init]) {
        _privateKey = privateKey;
    }
    return self;
}

- (instancetype)init {
    return [self initWithWalletPrivateKey:[[QSWalletHelper sharedHelper] getCurrentIdentityWallet].privateKey];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_modify_pwd_nav_title")];
    [self p_setupSubViews];
}

- (void)p_setupSubViews {
    //inputCornerView
    UIView *inputCornerView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kScreenWidth - kRealValue(30), kRealValue(159))];
    inputCornerView.backgroundColor = [UIColor whiteColor];
    inputCornerView.layer.cornerRadius = 8;
    [self.view addSubview:inputCornerView];
    _inputCornerView = inputCornerView;
    
    _currentPwdTextfield = [self createInputTextField];
    _currentPwdTextfield.frame = CGRectMake(kRealValue(15), kRealValue(15), inputCornerView.width - kRealValue(30), kRealValue(33));
    _currentPwdTextfield.placeholder = QSLocalizedString(@"qs_modify_pwd_item_current_pwd_placeholder");
    [_inputCornerView addSubview:_currentPwdTextfield];
    
    _freshPwdTextfield = [self createInputTextField];
    _freshPwdTextfield.frame = CGRectMake(_currentPwdTextfield.x, _currentPwdTextfield.maxY + kRealValue(15), _currentPwdTextfield.width, _currentPwdTextfield.height);
    _freshPwdTextfield.placeholder = QSLocalizedString(@"qs_modify_pwd_item_new_pwd_placeholder");
    [_inputCornerView addSubview:_freshPwdTextfield];
    
    _comfirmPwdTextfield = [self createInputTextField];
    _comfirmPwdTextfield.frame = CGRectMake(_currentPwdTextfield.x, _freshPwdTextfield.maxY + kRealValue(15), _currentPwdTextfield.width, _currentPwdTextfield.height);
    _comfirmPwdTextfield.placeholder = QSLocalizedString(@"qs_modify_pwd_item_confirm_pwd_placeholder");
    [_inputCornerView addSubview:_comfirmPwdTextfield];
    
    //tipsLabel
    NSString *totalText = QSLocalizedString(@"qs_modify_pwd_item_tips_total_title");
    NSString *highlightText = QSLocalizedString(@"qs_modify_pwd_item_tips_highlight_title");
    _tipsLabel = [YYLabel new];
    _tipsLabel.numberOfLines = 0;
    _tipsLabel.frame = CGRectMake(_inputCornerView.x, _inputCornerView.maxY + kRealValue(15), _inputCornerView.width, [UIFont qs_fontOfSize13].lineHeight * 2);
    WeakSelf(weakSelf);
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:totalText ];
    [attr yy_setFont:[UIFont qs_fontOfSize13] range:NSMakeRange(0, attr.length)];
    [attr yy_setColor:[UIColor qs_colorGray686868] range:NSMakeRange(0, attr.length)];
    [attr yy_setTextHighlightRange:[totalText rangeOfString:highlightText]
                             color:[UIColor qs_colorBlue4D7BF3]
                   backgroundColor:[UIColor clearColor]
                         tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect)
     {
         [weakSelf importNow];
     }];
    _tipsLabel.attributedText = attr;
    [_tipsLabel sizeToFit];
    [self.view addSubview:_tipsLabel];
    
    //modify Button
    _confirmButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_modify_pwd_btn_confirm_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(comfirmButtonClicked)];
    _confirmButton.frame = CGRectMake(kScreenWidth/2 - kBottomButtonWidth/2, _tipsLabel.maxY + kRealValue(15), kBottomButtonWidth, kBottomButtonHeight);
    _confirmButton.backgroundColor = [UIColor qs_colorBlack313745];
    _confirmButton.layer.cornerRadius = 4;
    [self.view addSubview:_confirmButton];
}

#pragma mark - **************** Event Response
- (void)importNow {
    //当前身份下的钱包 立即导入只有私钥,导入的钱包 立即导入有助记词和私钥
    if ([self.privateKey isEqualToString:[[QSWalletHelper sharedHelper] getCurrentIdentityWallet].privateKey]) {
        QSImportWalletByMnemonicCodeViewController *importWallet = [[QSImportWalletByMnemonicCodeViewController alloc] init];
        [self.navigationController pushViewController:importWallet animated:YES];
        return;
    }
    
    QSImportWalletIndexViewController *importWallet = [[QSImportWalletIndexViewController alloc] init];
    [self.navigationController pushViewController:importWallet animated:YES];
}

- (void)comfirmButtonClicked {
    if (!self.currentPwdTextfield.text.length || !self.freshPwdTextfield.text.length || !self.comfirmPwdTextfield.text.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_switch_createIdentity_alert")];
        return;
    }
    if (![self.freshPwdTextfield.text isEqualToString:self.comfirmPwdTextfield.text]) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_switch_createIdentity_alert2")];
        return;
    }
    
    if (![self.currentPwdTextfield.text isEqualToString:[[QSWalletHelper sharedHelper] getWalletByPrivateKey:self.privateKey].password]) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_content_password")];
        return;
    }
    
    if (![[QSWalletHelper sharedHelper] changePassword:self.freshPwdTextfield.text byPrivateKey:self.privateKey]) {
        return;
    }
    [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_content_password_change")];
    [self.navigationController popToViewControllerWithLevel:2 animated:YES];
}

#pragma mark - **************** Private Methods
- (UITextField *)createInputTextField {
    UITextField *textField = [[UITextField alloc] init];
//    [textField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
//    [textField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
    
    //* iOS 13关闭了权限， 不允许KVC给PlaceholderLabel属性赋值 */
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc]  initWithString:@"" attributes:@{NSForegroundColorAttributeName : [UIColor qs_colorGrayBBBBBB], NSFontAttributeName : [UIFont qs_fontOfSize14]}];
    textField.attributedPlaceholder = placeholderString;

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

@end
