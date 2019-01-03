//
//  QSEnterJsonViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/14.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSEnterJsonViewController.h"

@interface QSEnterJsonViewController ()
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) YYTextView *textView;
@property (nonatomic, strong) UIView *whiteView;

@end

@implementation QSEnterJsonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_manage_createGroup_title")];
    [self loadUI];
}

- (void)bottomButtonClicked {
    if (!self.textView.text.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_content_empty")];
        return;
    }
    if (self.enterJsonViewControllerSubmitJsonBlock) {
        self.enterJsonViewControllerSubmitJsonBlock(self.textView.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadUI {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.top.equalTo(self.view).offset(kRealValue(24));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRealValue(13));
        make.centerX.equalTo(self.view);
        make.height.equalTo(@kRealValue(150));
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.whiteView);
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.top.equalTo(self.whiteView).offset(kRealValue(17));
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteView.mas_bottom).offset(kRealValue(30));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - kRealValue(30), kRealValue(40)));
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = QSLocalizedString(@"qs_manage_createGroup_json_title");
        _titleLabel.textColor = [UIColor qs_colorBlack333333];
        _titleLabel.font = [UIFont qs_boldFontOfSize16];
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
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
        _textView.placeholderFont = [UIFont qs_fontOfSize14];
        _textView.placeholderTextColor = [UIColor qs_colorGrayBBBBBB];
        [self.whiteView addSubview:_textView];
    }
    return _textView;
}

@end
