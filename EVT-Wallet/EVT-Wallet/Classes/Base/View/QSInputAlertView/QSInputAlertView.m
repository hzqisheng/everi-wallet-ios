//
//  QSInputAlertView.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/3/1.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSInputAlertView.h"

@interface QSInputAlertView ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *privateTextField;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, copy) QSInputAlertViewConfirmBlock confirmBlock;
@property (nonatomic, copy) QSInputAlertViewCancelBlock cancelBlock;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *title;

@end

@implementation QSInputAlertView

+ (void)showInputAlertViewWithTitle:(NSString *)title placeholder:(NSString *)placeholder confirmBlock:(QSInputAlertViewConfirmBlock)confirmBlock cancelBlock:(QSInputAlertViewCancelBlock)cancelBlock {
    QSInputAlertView *alertView = [[QSInputAlertView alloc] initWithFrame:kScreenBounds];
    alertView.title = title;
    alertView.placeholder = placeholder;
    alertView.confirmBlock = confirmBlock;
    alertView.cancelBlock = cancelBlock;
    [alertView showWithAnimation];
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
    [self.privateTextField resignFirstResponder];
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
    if (!self.privateTextField.text.length) {
        [QSAppKeyWindow showAutoHideHudWithText:self.privateTextField.placeholder];
        return;
    }
    if (self.confirmBlock) {
        self.confirmBlock(self.privateTextField.text);
        [self dismissWithAnimation];
    }
}

- (void)cancelButtonClicked {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [QSAppKeyWindow hideHud];
    [self dismissWithAnimation];
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
        _privateTextField.textColor = [UIColor qs_colorBlack333333];
        _privateTextField.font = [UIFont qs_fontOfSize14];
//        [_privateTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
//        [_privateTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
//* iOS 13关闭了权限， 不允许KVC给PlaceholderLabel属性赋值 */
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc]  initWithString:QSLocalizedString(@"qs_wallet_detail_change_name_alert_placehoder") attributes:@{NSForegroundColorAttributeName : [UIColor qs_colorGrayBBBBBB], NSFontAttributeName : [UIFont qs_fontOfSize14]}];
        _privateTextField.attributedPlaceholder = placeholderString;
        _privateTextField.layer.borderColor = [UIColor qs_colorGray686868].CGColor;
        _privateTextField.layer.borderWidth = BORDER_WIDTH_1PX;
        _privateTextField.layer.cornerRadius = kRealValue(3);
        _privateTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _privateTextField.leftViewMode = UITextFieldViewModeAlways;
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
        [_cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.privateTextField.placeholder = placeholder;
}


@end
