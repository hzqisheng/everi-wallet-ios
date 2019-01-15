//
//  QSSelectWalletTypeViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/4.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSSelectWalletTypeViewController.h"
#import "QSImportWalletIndexViewController.h"

@interface QSSelectWalletTypeViewController ()

@end

@implementation QSSelectWalletTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_Choose_wallet_nav_title")];
    [self p_setupSubViews];
}

- (void)p_setupSubViews {
    //choose
    UILabel *chooseLabel = [UILabel labelWithName:QSLocalizedString(@"qs_Choose_wallet_tips_title") font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    chooseLabel.frame = CGRectMake(kRealValue(15), kRealValue(25), kScreenWidth - kRealValue(30), [UIFont qs_fontOfSize15].lineHeight);
    [self.view addSubview:chooseLabel];
    
    //walletType
    CGFloat walletTypeButtonW = kScreenWidth - kRealValue(30);
    CGFloat walletTypeButtonH = kRealValue(45);
    CGFloat firstWalletTypeButtonTopLeftSpace = kRealValue(15);
    CGFloat walletTypeButtonSpace = kRealValue(10);
    NSArray *titleList = @[QSLocalizedString(@"qs_Choose_wallet_evt_title"), QSLocalizedString(@"qs_Choose_wallet_eth_title"), QSLocalizedString(@"qs_Choose_wallet_eos_title")];
    for (int i = 0; i < 1; i++) {
        UIButton *button = [UIButton buttonWithTitle:titleList[i] titleColor:[UIColor qs_colorWhiteFFFFFF] font:[UIFont qs_fontOfSize15] taget:self action:@selector(typeButtonClicked:)];
        button.frame = CGRectMake(firstWalletTypeButtonTopLeftSpace, chooseLabel.maxY + firstWalletTypeButtonTopLeftSpace + i * (walletTypeButtonH + walletTypeButtonSpace), walletTypeButtonW, walletTypeButtonH);
        button.tag = i;
        button.backgroundColor = [UIColor qs_colorBlue4D7BF3];
        button.layer.cornerRadius = 8;
        [self.view addSubview:button];
    }
}

#pragma mark - **************** Event Response
- (void)typeButtonClicked:(UIButton *)button {
    if (button.tag == 0) {
        //EVT
        QSImportWalletIndexViewController *importEVT = [[QSImportWalletIndexViewController alloc] initWithType:QSImportWalletTypeEVT];
        [self.navigationController pushViewController:importEVT animated:YES];
    } else if (button.tag == 1) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_content_NO")];
        return;
        //ETH
        QSImportWalletIndexViewController *importETH = [[QSImportWalletIndexViewController alloc] initWithType:QSImportWalletTypeETH];
        [self.navigationController pushViewController:importETH animated:YES];
    } else if (button.tag == 2) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_content_NO")];
        return;
        //EOS
        QSImportWalletIndexViewController *importEOS = [[QSImportWalletIndexViewController alloc] initWithType:QSImportWalletTypeEOS];
        [self.navigationController pushViewController:importEOS animated:YES];
    }
}

@end
