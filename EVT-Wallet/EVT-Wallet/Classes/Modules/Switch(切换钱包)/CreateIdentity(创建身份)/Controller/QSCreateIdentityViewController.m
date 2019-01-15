//
//  QSCreateIdentityViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/14.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateIdentityViewController.h"
#import "QSExportMnemonicViewController.h"


@interface QSCreateIdentityViewController ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *checkTextField;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIButton *EVTButton;
@property (nonatomic, strong) UIButton *ETHButton;
@property (nonatomic, strong) UIButton *EOSButton;

@property (nonatomic, strong) UIImageView *alertImageView;
@property (nonatomic, strong) UILabel *alertLabel;

@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation QSCreateIdentityViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_btn_login_newidentity")];
    [self loadUI];
}

- (void)leftBarItemClicked {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadUI {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(kRealValue(15));
        make.height.equalTo(@kRealValue(111));
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(kRealValue(15));
        make.centerX.equalTo(self.topView);
        make.top.equalTo(self.topView).offset(kRealValue(15));
        make.height.equalTo(@kRealValue(33));
    }];
    
    [self.checkTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(kRealValue(15));
        make.centerX.equalTo(self.topView);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(kRealValue(15));
        make.height.equalTo(@kRealValue(33));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.top.equalTo(self.topView.mas_bottom).offset(kRealValue(24));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRealValue(15));
        make.height.equalTo(@kRealValue(50));
    }];
    
    [self.EVTButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerView).offset(kRealValue(17));
        make.centerY.equalTo(self.centerView);
        make.size.mas_equalTo(CGSizeMake(kRealValue(57), kRealValue(22)));
    }];
    
    [self.ETHButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.EVTButton.mas_right).offset(kRealValue(17));
        make.centerY.equalTo(self.centerView);
        make.size.mas_equalTo(CGSizeMake(kRealValue(57), kRealValue(22)));
    }];
    
    [self.EOSButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ETHButton.mas_right).offset(kRealValue(17));
        make.centerY.equalTo(self.centerView);
        make.size.mas_equalTo(CGSizeMake(kRealValue(57), kRealValue(22)));
    }];
    
    [self.alertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(30));
        make.top.equalTo(self.centerView.mas_bottom).offset(kRealValue(20));
        make.centerX.equalTo(self.view);
        make.height.equalTo(@kRealValue(126));
    }];
    
    [self.alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.alertImageView);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - kRealValue(90), kRealValue(95)));
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.top.equalTo(self.alertImageView.mas_bottom).offset(kRealValue(30));
        make.centerX.equalTo(self.view);
        make.height.equalTo(@kRealValue(40));
    }];
}

#pragma mark - **************** Event Response
- (void)EVTButtonClicked {
    self.EVTButton.selected = !self.EVTButton.selected;
}

- (void)ETHButtonClicked {
    self.ETHButton.selected = !self.ETHButton.selected;
}

- (void)EOSButtonClicked {
    self.EOSButton.selected = !self.EOSButton.selected;
}

- (void)bottomButtonClicked {
    if (!self.passwordTextField.text.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_switch_createIdentity_alert")];
        return;
    }
    if (self.passwordTextField.text.length < 8) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_switch_createIdentity_pwd_count_error_alert")];
        return;
    }
    if (![self.passwordTextField.text isEqualToString:self.checkTextField.text]) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_switch_createIdentity_alert2")];
        return;
    }
    WeakSelf(weakSelf);
    [[QSEveriApiWebViewController sharedWebView] createEvtWalletWithPassword:self.passwordTextField.text andCompeleteBlock:^(NSInteger statusCode, QSCreateEvt * _Nonnull EvtModel) {
        if (statusCode == kResponseSuccessCode) {
            [[QSWalletHelper sharedHelper] loginWithEvt:EvtModel];
            QSExportMnemonicViewController *exportMnemonic = [[QSExportMnemonicViewController alloc] init];
            exportMnemonic.isFirstCreate = YES;
            [weakSelf.navigationController pushViewController:exportMnemonic animated:YES];
            [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_content_isCreate_success")];
        } else {
            [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_switch_createIdentity_login_fail")];
        }
    }];
}

#pragma mark - **************** Setter Getter
- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_add_wallet_btn_confirm_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(bottomButtonClicked)];
        _submitButton.backgroundColor = [UIColor qs_colorBlack313745];
        _submitButton.layer.cornerRadius = 2;
        [self.view addSubview:_submitButton];
    }
    return _submitButton;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _topView.layer.cornerRadius = kRealValue(8);
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.layer.borderWidth = BORDER_WIDTH_1PX;
        _passwordTextField.layer.borderColor = [UIColor qs_colorGrayBBBBBB].CGColor;
        _passwordTextField.layer.cornerRadius = kRealValue(2);
        _passwordTextField.placeholder = QSLocalizedString(@"qs_switch_createIdentity_password_placeholder");
        _passwordTextField.textColor = [UIColor qs_colorBlack333333];
        _passwordTextField.font = [UIFont qs_fontOfSize14];
        [_passwordTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        _passwordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        [_passwordTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        _passwordTextField.secureTextEntry = YES;
        [self.topView addSubview:_passwordTextField];
    }
    return _passwordTextField;
}

- (UITextField *)checkTextField {
    if (!_checkTextField) {
        _checkTextField = [[UITextField alloc] init];
        _checkTextField.layer.borderWidth = BORDER_WIDTH_1PX;
        _checkTextField.layer.borderColor = [UIColor qs_colorGrayBBBBBB].CGColor;
        _checkTextField.layer.cornerRadius = kRealValue(2);
        _checkTextField.placeholder = QSLocalizedString(@"qs_import_wallet_confirm_password_placeholder");
        _checkTextField.textColor = [UIColor qs_colorBlack333333];
        _checkTextField.font = [UIFont qs_fontOfSize14];
        [_checkTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        _checkTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _checkTextField.leftViewMode = UITextFieldViewModeAlways;
        [_checkTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        _checkTextField.secureTextEntry = YES;
        [self.topView addSubview:_checkTextField];
    }
    return _checkTextField;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = QSLocalizedString(@"qs_add_wallet_check_label_title");
        _titleLabel.textColor = [UIColor qs_colorBlack333333];
        _titleLabel.font = [UIFont qs_boldFontOfSize16];
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _centerView.layer.cornerRadius = kRealValue(8);
        [self.view addSubview:_centerView];
    }
    return _centerView;
}

- (UIButton *)EVTButton {
    if (!_EVTButton) {
        _EVTButton = [[UIButton alloc] init];
        [_EVTButton setImage:[UIImage imageNamed:@"icon_quanxianshezhi_unselected"] forState:UIControlStateNormal];
        [_EVTButton setTitle:@"EVT" forState:UIControlStateNormal];
        [_EVTButton setTitleColor:[UIColor qs_colorGrayBBBBBB] forState:UIControlStateNormal];
        [_EVTButton setImage:[UIImage imageNamed:@"icon_quanxianbianji_selected"] forState:UIControlStateSelected];
        [_EVTButton setTitleColor:[UIColor qs_colorBlack333333] forState:UIControlStateSelected];
        _EVTButton.titleLabel.font = [UIFont qs_fontOfSize15];
        [_EVTButton addTarget:self action:@selector(EVTButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.centerView addSubview:_EVTButton];
        _EVTButton.selected = YES;
    }
    return _EVTButton;
}

- (UIButton *)ETHButton {
    if (!_ETHButton) {
        _ETHButton = [[UIButton alloc] init];
        [_ETHButton setImage:[UIImage imageNamed:@"icon_quanxianshezhi_unselected"] forState:UIControlStateNormal];
        [_ETHButton setTitle:@"ETH" forState:UIControlStateNormal];
        [_ETHButton setTitleColor:[UIColor qs_colorGrayBBBBBB] forState:UIControlStateNormal];
        [_ETHButton setImage:[UIImage imageNamed:@"icon_quanxianbianji_selected"] forState:UIControlStateSelected];
        [_ETHButton setTitleColor:[UIColor qs_colorBlack333333] forState:UIControlStateSelected];
        _ETHButton.titleLabel.font = [UIFont qs_fontOfSize15];
        [_ETHButton addTarget:self action:@selector(ETHButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _ETHButton.hidden = YES;
        [self.centerView addSubview:_ETHButton];
    }
    return _ETHButton;
}

- (UIButton *)EOSButton {
    if (!_EOSButton) {
        _EOSButton = [[UIButton alloc] init];
        [_EOSButton setImage:[UIImage imageNamed:@"icon_quanxianshezhi_unselected"] forState:UIControlStateNormal];
        [_EOSButton setTitle:@"EOS" forState:UIControlStateNormal];
        [_EOSButton setTitleColor:[UIColor qs_colorGrayBBBBBB] forState:UIControlStateNormal];
        [_EOSButton setImage:[UIImage imageNamed:@"icon_quanxianbianji_selected"] forState:UIControlStateSelected];
        [_EOSButton setTitleColor:[UIColor qs_colorBlack333333] forState:UIControlStateSelected];
        _EOSButton.titleLabel.font = [UIFont qs_fontOfSize15];
        [_EOSButton addTarget:self action:@selector(EOSButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _EOSButton.hidden = YES;
        [self.centerView addSubview:_EOSButton];
    }
    return _EOSButton;
}

- (UIImageView *)alertImageView {
    if (!_alertImageView) {
        _alertImageView = [[UIImageView alloc] init];
        [_alertImageView setImage:[UIImage imageNamed:@"img_chuangjianshenfen"]];
        [self.view addSubview:_alertImageView];
    }
    return _alertImageView;
}

- (UILabel *)alertLabel {
    if (!_alertLabel) {
        _alertLabel = [[UILabel alloc] init];
        _alertLabel.text = QSLocalizedString(@"qs_import_wallet_item_metion_total_title");
        _alertLabel.textColor = [UIColor qs_colorBlack313745];
        _alertLabel.font = [UIFont qs_fontOfSize13];
        _alertLabel.numberOfLines = 0;
        [self.view addSubview:_alertLabel];
    }
    return _alertLabel;
}

@end
