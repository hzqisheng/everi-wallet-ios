//
//  QSCreateNFTSEditViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateNFTSEditViewController.h"

@interface QSCreateNFTSEditViewController ()

@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) YYTextView *textView;
@property (nonatomic, strong) UIView *whiteView;

@end

@implementation QSCreateNFTSEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_pass_mypass_btn_title")];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_chuangjianyu_help"] target:self action:@selector(rightBarItemClicked)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    [self loadUI];
}

- (void)rightBarItemClicked {
    
}

- (void)bottomButtonClicked {
    if (!self.textView.text.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_content_empty")];
        return;
    }
    if (self.createNFTSEditViewControllerSaveBlock) {
        self.createNFTSEditViewControllerSaveBlock(self.textView.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadUI {
    CGFloat bottomButtonBottomMargin = kDevice_Is_iPhoneX ? kiPhoneXSafeAreaBottomMagin : kRealValue(15);
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-bottomButtonBottomMargin);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kBottomButtonWidth, kBottomButtonHeight));
    }];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.top.equalTo(self.view).offset(kRealValue(15));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.submitButton.mas_top).offset(-kRealValue(15));
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.whiteView);
        make.left.equalTo(self.whiteView).offset(kRealValue(22));
        make.top.equalTo(self.whiteView).offset(kRealValue(25));
    }];
}

#pragma mark - **************** Setter Getter
- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_add_address_save_btn_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(bottomButtonClicked)];
        _submitButton.backgroundColor = [UIColor qs_colorBlack313745];
        _submitButton.layer.cornerRadius = 2;
        [self.view addSubview:_submitButton];
    }
    return _submitButton;
}

- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _whiteView.layer.cornerRadius = kRealValue(8);
        [self.view addSubview:_whiteView];
    }
    return _whiteView;
}

- (YYTextView *)textView {
    if (!_textView) {
        _textView = [[YYTextView alloc] init];
        _textView.textColor = [UIColor qs_colorBlack333333];
        _textView.font = [UIFont qs_fontOfSize15];
        [self.whiteView addSubview:_textView];
    }
    return _textView;
}

@end
