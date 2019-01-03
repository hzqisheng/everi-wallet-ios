
//
//  QSCreateIdentityHomeViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/15.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateIdentityHomeViewController.h"
#import "QSCreateIdentityViewController.h"
#import "QSRestoreIdentityViewController.h"

@interface QSCreateIdentityHomeViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UIButton *createButton;
@property (nonatomic, strong) UIButton *recoverButton;

@end

@implementation QSCreateIdentityHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
}

- (void)loadUI {
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@kRealValue(195));
    }];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.backgroundImageView);
        make.size.mas_equalTo(CGSizeMake(kRealValue(198), kRealValue(53)));
    }];
    
    [self.createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.backgroundImageView.mas_bottom).offset(kRealValue(50));
        make.height.equalTo(@kRealValue(40));
    }];
    
    [self.recoverButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.createButton.mas_bottom).offset(kRealValue(26));
        make.height.equalTo(@kRealValue(40));
    }];
}

#pragma mark - **************** Event Response
- (void)createButtonClicked {
    QSCreateIdentityViewController *createIdVC = [[QSCreateIdentityViewController alloc] init];
    [self.navigationController pushViewController:createIdVC animated:YES];
}

- (void)recoverButtonClicked {
    QSRestoreIdentityViewController *restoreVC = [[QSRestoreIdentityViewController alloc] init];
    [self.navigationController pushViewController:restoreVC animated:YES];
}

#pragma mark - **************** Setter Getter
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.image = [UIImage imageNamed:@"img_wode"];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:_backgroundImageView];
    }
    return _backgroundImageView;
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = [UIImage imageNamed:@"icon_guanli_logo"];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:_logoImageView];
    }
    return _logoImageView;
}

- (UIButton *)createButton {
    if (!_createButton) {
        _createButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_btn_login_newidentity") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(createButtonClicked)];
        _createButton.backgroundColor = [UIColor qs_colorBlack313745];
        _createButton.layer.cornerRadius = 2;
        [self.view addSubview:_createButton];
    }
    return _createButton;
}

- (UIButton *)recoverButton {
    if (!_recoverButton) {
        _recoverButton = [[UIButton alloc] init];
        _recoverButton.layer.borderWidth = BORDER_WIDTH_1PX;
        _recoverButton.layer.borderColor = [UIColor qs_colorBlack313745].CGColor;
        _recoverButton.layer.cornerRadius = kRealValue(2);
        [_recoverButton setTitleColor:[UIColor qs_colorBlack313745] forState:UIControlStateNormal];
        [_recoverButton setTitle:QSLocalizedString(@"qs_switch_createIdentity_recover") forState:UIControlStateNormal];
        _recoverButton.titleLabel.font = [UIFont qs_fontOfSize15];
        [_recoverButton addTarget:self action:@selector(recoverButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_recoverButton];
    }
    return _recoverButton;
}

@end
