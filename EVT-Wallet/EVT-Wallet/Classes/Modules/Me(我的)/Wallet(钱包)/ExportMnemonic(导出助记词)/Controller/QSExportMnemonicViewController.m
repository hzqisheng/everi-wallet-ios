//
//  QSExportMnemonicViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/3.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSExportMnemonicViewController.h"
#import "QSExportMnemonicStep2ViewController.h"

@interface QSExportMnemonicViewController ()

@property (nonatomic, strong) UIImageView *mentionBackgroundImageView;
@property (nonatomic, strong) YYLabel *mentionsLabel;
@property (nonatomic, strong) UIButton *backupButton;

@end

@implementation QSExportMnemonicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_export_mnemonic_code_nav_title")];
    [self p_setupSubViews];
}

- (void)p_setupSubViews {
    //mentionBackgroundImageView
    _mentionBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(30), kRealValue(15), kScreenWidth - kRealValue(60), kRealValue(86))];
    _mentionBackgroundImageView.image = [UIImage imageNamed:@"img_daoruqianbao"];
    [self.view addSubview:_mentionBackgroundImageView];
    
    //tipsLabel
    NSString *totalText = QSLocalizedString(@"qs_export_mnemonic_code_item_metion_total_title");
    NSString *highlightText = QSLocalizedString(@"qs_export_mnemonic_code_metion_highlight_title");
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
    
    //backup Button
    _backupButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_export_mnemonic_code_btn_backup_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(backupButtonClicked)];
    _backupButton.frame = CGRectMake(kScreenWidth/2 - kBottomButtonWidth/2, _mentionBackgroundImageView.maxY + kRealValue(30), kBottomButtonWidth, kBottomButtonHeight);
    _backupButton.backgroundColor = [UIColor qs_colorBlack313745];
    _backupButton.layer.cornerRadius = 2;
    [self.view addSubview:_backupButton];
}

#pragma mark - **************** Event Response
- (void)backupButtonClicked {
    QSExportMnemonicStep2ViewController *step2 = [[QSExportMnemonicStep2ViewController alloc] init];
    step2.isFirstCreate = self.isFirstCreate;
    [self.navigationController pushViewController:step2 animated:YES];
}

@end
