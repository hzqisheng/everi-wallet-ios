//
//  QSImportWalletViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/3.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSImportWalletByMnemonicCodeViewController.h"
#import "QSMyWalletViewController.h"

@interface QSImportWalletByMnemonicCodeViewController ()

@property (nonatomic, strong) UIView *inputCornerView;
@property (nonatomic, strong) YYTextView *mnemonicCodeTextView;
@property (nonatomic, strong) UITextField *freshPwdTextfield;
@property (nonatomic, strong) UITextField *comfirmPwdTextfield;
@property (nonatomic, strong) UIImageView *mentionBackgroundImageView;
@property (nonatomic, strong) YYLabel *mentionsLabel;
@property (nonatomic, strong) UIButton *confirmButton;
/* 适配不同型号键盘大小 */
@property (nonatomic, assign)CGSize kbSize;
@end

@implementation QSImportWalletByMnemonicCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_import_wallet_nav_title")];
    [self p_setupSubViews];
    [self registerForKeyboardNotifications];
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
    //* iOS 13关闭了权限， 不允许KVC给PlaceholderLabel属性赋值 */
    NSMutableAttributedString *mnemonCodeTFplaceholderString = [[NSMutableAttributedString alloc]  initWithString:QSLocalizedString(@"qs_import_wallet_item_mnemonic_title") attributes:@{NSForegroundColorAttributeName : [UIColor qs_colorGrayBBBBBB], NSFontAttributeName : [UIFont qs_fontOfSize14]}];
    _mnemonicCodeTextView.placeholderAttributedText = mnemonCodeTFplaceholderString;
    [_inputCornerView addSubview:_mnemonicCodeTextView];
    
    _freshPwdTextfield = [self createInputTextField];
    _freshPwdTextfield.frame = CGRectMake(_mnemonicCodeTextView.x, _mnemonicCodeTextView.maxY + kRealValue(15), _mnemonicCodeTextView.width, kRealValue(33));
    _freshPwdTextfield.placeholder = QSLocalizedString(@"qs_import_wallet_item_password_title");
    //* iOS 13关闭了权限， 不允许KVC给PlaceholderLabel属性赋值 */
       NSMutableAttributedString *freshPwdTFplaceholderString = [[NSMutableAttributedString alloc]  initWithString:QSLocalizedString(@"qs_import_wallet_item_password_title") attributes:@{NSForegroundColorAttributeName : [UIColor qs_colorGrayBBBBBB], NSFontAttributeName : [UIFont qs_fontOfSize14]}];
       _freshPwdTextfield.attributedPlaceholder = freshPwdTFplaceholderString;
    [_inputCornerView addSubview:_freshPwdTextfield];
    
    _comfirmPwdTextfield = [self createInputTextField];
    _comfirmPwdTextfield.frame = CGRectMake(_mnemonicCodeTextView.x, _freshPwdTextfield.maxY + kRealValue(15), _mnemonicCodeTextView.width, _freshPwdTextfield.height);
    _comfirmPwdTextfield.placeholder = QSLocalizedString(@"qs_import_wallet_item_confirm_password_title");
    //* iOS 13关闭了权限， 不允许KVC给PlaceholderLabel属性赋值 */
    NSMutableAttributedString *comfirmPwdTFplaceholderString = [[NSMutableAttributedString alloc]  initWithString:QSLocalizedString(@"qs_import_wallet_item_confirm_password_title") attributes:@{NSForegroundColorAttributeName : [UIColor qs_colorGrayBBBBBB], NSFontAttributeName : [UIFont qs_fontOfSize14]}];
    _comfirmPwdTextfield.attributedPlaceholder = comfirmPwdTFplaceholderString;
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
    if (!self.mnemonicCodeTextView.text.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_import_wallet_error_tips")];
        return;
    }
    if (self.freshPwdTextfield.text.length < 8) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_import_wallet_error_pwd_count_tips")];
        return;
    }
    if (![self.comfirmPwdTextfield.text isEqualToString:self.freshPwdTextfield.text]) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_import_wallet_error_pwd_tips")];
        return;
    }
    
    [[QSEveriApiWebViewController sharedWebView] checkValidateMnemonic:self.mnemonicCodeTextView.text andCompeleteBlock:^(NSInteger statusCode, BOOL isValidate) {
        if (statusCode == kResponseSuccessCode) {
            if (isValidate) {
                [[QSEveriApiWebViewController sharedWebView] importEVTWalletWithMnemoinc:self.mnemonicCodeTextView.text
                                                                                password:self.freshPwdTextfield.text
                                                                       andCompeleteBlock:^(NSInteger statusCode, QSCreateEvt * _Nonnull EvtModel)
                 {
                     if (statusCode == kResponseSuccessCode) {
                         [[QSWalletHelper sharedHelper] addWallet:EvtModel];
                         [self.navigationController popToViewControllerWithLevel:2 animated:YES];
                     } else {
                         [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_import_wallet_nav_title_failure")];
                     }
                 }];
            } else {
                [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_import_wallet_invalid_mnemonic_alert")];
            }
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.mnemonicCodeTextView resignFirstResponder];
    [self.freshPwdTextfield resignFirstResponder];
    [self.comfirmPwdTextfield resignFirstResponder];

}

#pragma mark - 防止键盘弹出视图大部分偏移
- (void)registerForKeyboardNotifications{
    
    //使用NSNotificationCenter 键盘出现时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
/* 键盘启用 */
- (void)keyboardWillShow:(NSNotification *)notify
{
    //获取键盘弹出前的Rect
     NSValue*keyBoardBeginBounds=[[notify userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect=[keyBoardBeginBounds CGRectValue];
    
    //获取键盘弹出后的Rect
    NSValue*keyBoardEndBounds=[[notify userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    
    //获取键盘位置变化前后纵坐标Y的变化值
    CGFloat deltaY=endRect.origin.y-beginRect.origin.y;
    if (_freshPwdTextfield.isFirstResponder) {
        [UIView animateWithDuration:0.0001f animations:^{
            self.view.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }else if (_comfirmPwdTextfield.isFirstResponder) {
        [UIView animateWithDuration:0.0001f animations:^{
            self.view.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }else{
    [UIView animateWithDuration:0.0001f animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    }
}

/* 键盘消失 */
- (void)keyboardWillHide:(NSNotification *)notify {
    
    //视图下沉恢复原状
    [UIView animateWithDuration:0.00000000001 animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    
    [_comfirmPwdTextfield resignFirstResponder];
    [_freshPwdTextfield resignFirstResponder];

}

#pragma mark - **************** Private Methods
- (UITextField *)createInputTextField {
    UITextField *textField = [[UITextField alloc] init];
//    [textField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
//    [textField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
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

//-(void)viewWillDisappear:(BOOL)animated {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
@end
