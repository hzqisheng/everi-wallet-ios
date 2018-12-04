//
//  QSAddWalletViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/4.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSAddWalletViewController.h"

@interface QSAddWalletViewController ()

@end

@implementation QSAddWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_add_wallet_nav_title")];
    [self p_setupSubViews];
}

- (void)p_setupSubViews {
    //choose
    UILabel *chooseLabel = [UILabel labelWithName:QSLocalizedString(@"qs_add_wallet_check_label_title") font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    chooseLabel.frame = CGRectMake(kRealValue(17), kRealValue(20), kRealValue(150), kRealValue(15));
    [self.view addSubview:chooseLabel];
    
    //choose
    NSArray *titleArray = @[@"EVT",@"ETH",@"EOS"];
    for (int i = 0; i < 3; i++) {
        CGFloat buttonW = kRealValue(50);
        CGFloat buttonH = kRealValue(20);
        UIButton *button = [UIButton buttonWithTitle:titleArray[i] titleColor:[UIColor qs_colorGray686868] font:[UIFont qs_fontOfSize13] taget:self action:@selector(buttonClicked:)];
        [button setImage:[UIImage imageNamed:@"icon_evtwallet_unselected"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"icon_evtwallet_selected"] forState:UIControlStateSelected];
        button.frame = CGRectMake(kRealValue(15) + i*(buttonW + kRealValue(5)), chooseLabel.maxY + kRealValue(15), buttonW, buttonH);
        [self.view addSubview:button];
    }
    
    //metion
    //mentionBackgroundImageView
    UIImageView *mentionBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(30), chooseLabel.maxY + kRealValue(60), kScreenWidth - kRealValue(60), kRealValue(86))];
    mentionBackgroundImageView.image = [UIImage imageNamed:@"img_daoruqianbao"];
    [self.view addSubview:mentionBackgroundImageView];
    
    //tipsLabel
    NSString *totalText = QSLocalizedString(@"qs_add_wallet_item_metion_total_title");
    NSString *highlightText = QSLocalizedString(@"qs_add_wallet_item_metion_highlight_title");
    YYLabel *mentionsLabel = [YYLabel new];
    mentionsLabel.numberOfLines = 0;
    mentionsLabel.frame = CGRectMake(kRealValue(15),  kRealValue(15), mentionBackgroundImageView.width - kRealValue(30), kRealValue(55));
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:totalText ];
    [attr yy_setFont:[UIFont qs_fontOfSize13] range:NSMakeRange(0, attr.length)];
    [attr yy_setColor:[UIColor qs_colorGray686868] range:NSMakeRange(0, attr.length)];
    [attr yy_setColor:[UIColor qs_colorBlue4D7BF3] range:[totalText rangeOfString:highlightText]];
    mentionsLabel.attributedText = attr;
    [mentionsLabel sizeToFit];
    mentionBackgroundImageView.height = mentionsLabel.height + kRealValue(30);
    [mentionBackgroundImageView addSubview:mentionsLabel];
    
    //createButton
    UIButton *confirmButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_add_wallet_btn_confirm_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(comfirmButtonClicked)];
    confirmButton.frame = CGRectMake(kScreenWidth/2 - kBottomButtonWidth/2, mentionBackgroundImageView.maxY + kRealValue(30), kBottomButtonWidth, kBottomButtonHeight);
    confirmButton.backgroundColor = [UIColor qs_colorBlack313745];
    confirmButton.layer.cornerRadius = 4;
    [self.view addSubview:confirmButton];
}

#pragma mark - **************** Event Response
- (void)buttonClicked:(UIButton *)button {
    button.selected = !button.selected;
}

- (void)comfirmButtonClicked {
    
}

@end
