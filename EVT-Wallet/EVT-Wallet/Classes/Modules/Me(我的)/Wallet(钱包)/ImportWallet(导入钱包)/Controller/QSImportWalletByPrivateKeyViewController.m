//
//  QSImportWalletByPrivateKeyViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSImportWalletByPrivateKeyViewController.h"

@interface QSImportWalletByPrivateKeyViewController ()

@property (nonatomic, strong) UIView *inputCornerView;
@property (nonatomic, strong) YYTextView *privateKeyTextView;
@property (nonatomic, strong) UITextField *freshPwdTextfield;
@property (nonatomic, strong) UITextField *comfirmPwdTextfield;
@property (nonatomic, strong) UIImageView *mentionBackgroundImageView;
@property (nonatomic, strong) YYLabel *mentionsLabel;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation QSImportWalletByPrivateKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    _privateKeyTextView = [self createTextView];
    _privateKeyTextView.frame = CGRectMake(kRealValue(15), kRealValue(15), inputCornerView.width - kRealValue(30), kRealValue(54));
    _privateKeyTextView.placeholderText = QSLocalizedString(@"qs_import_wallet_private_key_placeholder");
    //* iOS 13关闭了权限， 不允许KVC给PlaceholderLabel属性赋值 */
    NSMutableAttributedString *prevateTFplaceholderString = [[NSMutableAttributedString alloc]  initWithString:QSLocalizedString(@"qs_import_wallet_private_key_placeholder") attributes:@{NSForegroundColorAttributeName : [UIColor qs_colorGrayBBBBBB], NSFontAttributeName : [UIFont qs_fontOfSize14]}];
    _privateKeyTextView.placeholderAttributedText = prevateTFplaceholderString;
    [_inputCornerView addSubview:_privateKeyTextView];
    
    _freshPwdTextfield = [self createInputTextField];
    _freshPwdTextfield.frame = CGRectMake(_privateKeyTextView.x, _privateKeyTextView.maxY + kRealValue(15), _privateKeyTextView.width, kRealValue(33));
    _freshPwdTextfield.placeholder = QSLocalizedString(@"qs_import_wallet_password_placeholder");
    //* iOS 13关闭了权限， 不允许KVC给PlaceholderLabel属性赋值 */
       NSMutableAttributedString *freshTFplaceholderString = [[NSMutableAttributedString alloc]  initWithString:QSLocalizedString(@"qs_import_wallet_password_placeholder") attributes:@{NSForegroundColorAttributeName : [UIColor qs_colorGrayBBBBBB], NSFontAttributeName : [UIFont qs_fontOfSize14]}];
       _freshPwdTextfield.attributedPlaceholder = freshTFplaceholderString;
    
    [_inputCornerView addSubview:_freshPwdTextfield];
    
    _comfirmPwdTextfield = [self createInputTextField];
    _comfirmPwdTextfield.frame = CGRectMake(_privateKeyTextView.x, _freshPwdTextfield.maxY + kRealValue(15), _privateKeyTextView.width, _freshPwdTextfield.height);
    _comfirmPwdTextfield.placeholder = QSLocalizedString(@"qs_import_wallet_confirm_password_placeholder");
    
    //* iOS 13关闭了权限， 不允许KVC给PlaceholderLabel属性赋值 */
    NSMutableAttributedString *comfirmTFplaceholderString = [[NSMutableAttributedString alloc]  initWithString:QSLocalizedString(@"qs_import_wallet_confirm_password_placeholder") attributes:@{NSForegroundColorAttributeName : [UIColor qs_colorGrayBBBBBB], NSFontAttributeName : [UIFont qs_fontOfSize14]}];
    _comfirmPwdTextfield.attributedPlaceholder = comfirmTFplaceholderString;
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
    if (!self.privateKeyTextView.text.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_import_wallet_no_private_key")];
        return;
    }
    if (self.freshPwdTextfield.text.length < 8) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_import_wallet_nil_pwd_toast")];
        return;
    }
    if (![self.freshPwdTextfield.text
         isEqualToString:self.comfirmPwdTextfield.text]) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_import_wallet_no_same_pwd_toast")];
        return;
    }
    
    [[QSEveriApiWebViewController sharedWebView] checkValidPrivateKey:self.privateKeyTextView.text andCompeleteBlock:^(NSInteger statusCode, BOOL isValid) {
        if (statusCode == kResponseSuccessCode) {
            if (isValid) {
                [[QSEveriApiWebViewController sharedWebView] privateToPublicWithPrivateKey:self.privateKeyTextView.text andCompeleteBlock:^(NSInteger statusCode, NSString * _Nonnull publicKey) {
                    if (statusCode == kResponseSuccessCode) {
                        QSCreateEvt *newEvt = [[QSCreateEvt alloc] init];
                        newEvt.privateKey = self.privateKeyTextView.text;
                        newEvt.publicKey = publicKey;
                        newEvt.password = self.freshPwdTextfield.text;
                        newEvt.type = @"EVT";
                        [[QSWalletHelper sharedHelper] addWallet:newEvt];
                        [self.navigationController popToViewControllerWithLevel:2 animated:YES];
                    }
                }];
            } else {
                [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_import_wallet_invalid_private_key_alert")];
            }
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.privateKeyTextView resignFirstResponder];
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
