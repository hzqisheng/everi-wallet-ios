//
//  QSPrivatekeyAlertView.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/16.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSPrivatekeyAlertView.h"

@interface QSPrivatekeyAlertView ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *privateTextField;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation QSPrivatekeyAlertView

+ (void)showPrivatekeyAlertViewAndSubmitBlock:(void (^)(void))block {
    QSPrivatekeyAlertView *view = [[QSPrivatekeyAlertView alloc] initWithFrame:kScreenBounds];
    view.privatekeyAlertViewSubmitBlock = block;
    [view showWithAnimation];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.5f];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissWithAnimation)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(kRealValue(176));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(kScreenHeight/2 - kRealValue(120));
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - kRealValue(110), kRealValue(154)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.whiteView);
        make.top.equalTo(self.whiteView).offset(kRealValue(25));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.privateTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRealValue(20));
        make.right.equalTo(self.whiteView).offset(-kRealValue(20));
        make.height.equalTo(@kRealValue(33));
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.privateTextField.mas_bottom).offset(kRealValue(20));
        make.right.equalTo(self.whiteView);
        make.size.mas_equalTo(CGSizeMake(kRealValue(133), kRealValue(40)));
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.privateTextField.mas_bottom).offset(kRealValue(20));
        make.left.equalTo(self.whiteView);
        make.size.mas_equalTo(CGSizeMake(kRealValue(133), kRealValue(40)));
    }];
}

#pragma mark - **************** Private Methods
- (void)showWithAnimation {
    [QSAppKeyWindow addSubview:self];
    self.alpha = 0;
    self.whiteView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [self.privateTextField becomeFirstResponder];
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        self.whiteView.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    } completion:nil];
}

- (void)dismissWithAnimation {
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        self.whiteView.transform = CGAffineTransformMakeScale(0.2,0.2);
        self.whiteView.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - **************** Private Methods
- (void)submitButtonClicked {
    if (![self.privateTextField.text isEqualToString:[QSWalletHelper sharedHelper].currentEvt.password]) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_content_password")];
        return;
    }
    if (self.privatekeyAlertViewSubmitBlock) {
        self.privatekeyAlertViewSubmitBlock();
        [self dismissWithAnimation];
    }
}

- (void)moveToTop {
    
}

- (void)moveToScreenCenter {
    
}

#pragma mark - **************** UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.whiteView]) {
        return NO;
    }
    return YES;
}

#pragma mark - **************** Setter Getter
- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _whiteView.layer.cornerRadius = kRealValue(8);
        _whiteView.layer.masksToBounds = YES;
        [self addSubview:_whiteView];
    }
    return _whiteView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = QSLocalizedString(@"qs_issue_password_placeholder");
        _titleLabel.textColor = [UIColor qs_colorBlack333333];
        _titleLabel.font = [UIFont qs_fontOfSize16];
        [self.whiteView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UITextField *)privateTextField {
    if (!_privateTextField) {
        _privateTextField = [[UITextField alloc] init];
        _privateTextField.placeholder = QSLocalizedString(@"qs_issue_password_placeholder");
        _privateTextField.textColor = [UIColor qs_colorBlack333333];
        _privateTextField.font = [UIFont qs_fontOfSize14];
        [_privateTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        [_privateTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        _privateTextField.layer.borderColor = [UIColor qs_colorGray686868].CGColor;
        _privateTextField.layer.borderWidth = BORDER_WIDTH_1PX;
        _privateTextField.layer.cornerRadius = kRealValue(3);
        _privateTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _privateTextField.leftViewMode = UITextFieldViewModeAlways;
        _privateTextField.secureTextEntry = YES;
        [_privateTextField addTarget:self action:@selector(moveToTop) forControlEvents:UIControlEventEditingDidBegin];
        [_privateTextField addTarget:self action:@selector(moveToScreenCenter) forControlEvents:UIControlEventEditingDidEnd];
        [self.whiteView addSubview:_privateTextField];
    }
    return _privateTextField;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [[UIButton alloc] init];
        [_submitButton setTitle:QSLocalizedString(@"qs_manage_createGroup_confirm") forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor qs_colorBlue4D7BF3] forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont qs_fontOfSize15];
        _submitButton.layer.borderColor = [UIColor qs_colorGrayBBBBBB].CGColor;
        _submitButton.layer.borderWidth = BORDER_WIDTH_1PX;
        [_submitButton addTarget:self action:@selector(submitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:_submitButton];
    }
    return _submitButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setTitle:QSLocalizedString(@"qs_cancel") forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor qs_colorGray686868] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont qs_fontOfSize15];
        _cancelButton.layer.borderColor = [UIColor qs_colorGrayBBBBBB].CGColor;
        _cancelButton.layer.borderWidth = BORDER_WIDTH_1PX;
        [_cancelButton addTarget:self action:@selector(dismissWithAnimation) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:_cancelButton];
    }
    return _cancelButton;
}

@end
