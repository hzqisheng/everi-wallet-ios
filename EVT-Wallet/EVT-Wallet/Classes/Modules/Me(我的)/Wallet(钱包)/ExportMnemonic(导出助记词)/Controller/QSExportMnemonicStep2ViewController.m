//
//  QSExportMnemonicStep2ViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/3.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSExportMnemonicStep2ViewController.h"
#import "QSExportMnemonicStep3ViewController.h"

@interface QSExportMnemonicStep2ViewController ()


@end

@implementation QSExportMnemonicStep2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_export_mnemonic_code_nav_title")];
    [self p_setupSubViews];
}

- (void)p_setupSubViews {
    //tips
    UILabel *tipsLabel = [UILabel labelWithName:QSLocalizedString(@"qs_export_mnemonic_code_item_tips_title") font:[UIFont qs_fontOfSize18] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentLeft];
    tipsLabel.numberOfLines = 0;
    tipsLabel.frame = CGRectMake(kRealValue(30), kRealValue(25), kScreenWidth - kRealValue(60), kRealValue(45));
    [self.view addSubview:tipsLabel];
    [tipsLabel sizeToFit];
    
    //tipsDetail
    UILabel *tipsDetailLabel = [UILabel labelWithName:QSLocalizedString(@"qs_export_mnemonic_code_item_tips_detail_title") font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    tipsDetailLabel.numberOfLines = 0;
    tipsDetailLabel.frame = CGRectMake(kRealValue(30), tipsLabel.maxY + kRealValue(25), kScreenWidth - kRealValue(60), kRealValue(45));
    [self.view addSubview:tipsDetailLabel];
    [tipsDetailLabel sizeToFit];
    
    //mnemonicCode
    UIView *mnemonicCodeBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(15), tipsDetailLabel.maxY + kRealValue(25), kScreenWidth - kRealValue(30), kRealValue(87))];
    mnemonicCodeBackgroundView.backgroundColor = [UIColor whiteColor];
    mnemonicCodeBackgroundView.layer.cornerRadius = 8;
    [self.view addSubview:mnemonicCodeBackgroundView];
    mnemonicCodeBackgroundView.layer.cornerRadius = 8;
    mnemonicCodeBackgroundView.backgroundColor = [UIColor whiteColor];
    mnemonicCodeBackgroundView.layer.shadowOffset = CGSizeMake(0, 1);
    mnemonicCodeBackgroundView.layer.shadowColor = [UIColor qs_colorGray00267B].CGColor;
    mnemonicCodeBackgroundView.layer.shadowOpacity = 0.1f;
    
    UILabel *mnemonicCodeLabel = [UILabel labelWithName:[QSWalletHelper sharedHelper].currentEvt.mnemoinc font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    mnemonicCodeLabel.numberOfLines = 0;
    mnemonicCodeLabel.frame = CGRectMake(kRealValue(15), kRealValue(15), mnemonicCodeBackgroundView.width - kRealValue(30), kRealValue(45));
    [mnemonicCodeBackgroundView addSubview:mnemonicCodeLabel];
    [mnemonicCodeLabel sizeToFit];
    mnemonicCodeBackgroundView.height = mnemonicCodeLabel.height + kRealValue(30);
    
    //    self.shadowContainerView.layer.shadowRadius = 6;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:mnemonicCodeBackgroundView.bounds cornerRadius:8];
    mnemonicCodeBackgroundView.layer.shadowPath = path.CGPath;
    
    //nextButton
    UIButton *nextButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_issue_issue_confirm_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(nextButtonClicked)];
//    UIButton *nextButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_export_mnemonic_code_btn_next_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(nextButtonClicked)];
    nextButton.frame = CGRectMake(kScreenWidth/2 - kBottomButtonWidth/2, mnemonicCodeBackgroundView.maxY + kRealValue(30), kBottomButtonWidth, kBottomButtonHeight);
    nextButton.backgroundColor = [UIColor qs_colorBlack313745];
    nextButton.layer.cornerRadius = 2;
    [self.view addSubview:nextButton];
}

#pragma mark - **************** Event Response
- (void)nextButtonClicked {
    if (self.isFirstCreate) {
        [[QSWalletHelper sharedHelper] turnToHomeViewController];
    } else {
        [self.navigationController popToViewControllerWithLevel:2 animated:YES];
    }
    //跳转第三步
//    QSExportMnemonicStep3ViewController *step3 = [[QSExportMnemonicStep3ViewController alloc] init];
//    [self.navigationController pushViewController:step3 animated:YES];
}

@end
