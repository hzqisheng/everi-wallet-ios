//
//  QSOpenFinerprintViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/9.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSOpenFinerprintViewController.h"
#import "QSPrivatekeyAlertView.h"

@interface QSOpenFinerprintViewController ()

@end

@implementation QSOpenFinerprintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_wallet_touchid_nav_title")];
    
    UIView *roundBackroundView = [[UIView alloc] init];
    roundBackroundView.backgroundColor = [UIColor whiteColor];
    roundBackroundView.layer.cornerRadius = 8;
    [self.view addSubview:roundBackroundView];
    [roundBackroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kRealValue(15));
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
        make.height.equalTo(@kRealValue(159));
    }];
    
    UIImageView *touchIDImageView = [[UIImageView alloc] init];
    touchIDImageView.image = [UIImage imageNamed:@"icon_zhiwenjiesuo"];
    [roundBackroundView addSubview:touchIDImageView];
    [touchIDImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(roundBackroundView).offset(kRealValue(31));
        make.centerX.equalTo(roundBackroundView);
        make.width.and.height.equalTo(@kRealValue(60));
    }];
    
    UILabel *contentLabel = [UILabel labelWithName:QSLocalizedString(@"qs_wallet_touchid_tips") font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentCenter];
    [roundBackroundView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(touchIDImageView.mas_bottom).offset(kRealValue(23));
        make.left.and.right.equalTo(roundBackroundView);
    }];
    
    UIButton *openButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_wallet_touchid_btn_title") titleColor:[UIColor whiteColor] font:[UIFont qs_fontOfSize15] taget:self action:@selector(openTouchID)];
    openButton.backgroundColor = [UIColor qs_colorBlue4D7BF3];
    openButton.layer.cornerRadius = 4;
    [self.view addSubview:openButton];
    [openButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(roundBackroundView.mas_bottom).offset(kRealValue(30));
        make.left.and.right.equalTo(roundBackroundView);
        make.height.equalTo(@kRealValue(40));
    }];
}

- (void)openTouchID {
    [QSPrivatekeyAlertView showPrivatekeyAlertViewAndSubmitBlock:^{
        if (self.openFinerprintSuccessBlock) {
            self.openFinerprintSuccessBlock();
        }
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
