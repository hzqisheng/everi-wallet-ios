//
//  QSScanUnrecognizedResultViewController.m
//  EVT-Wallet
//
//  Created by SJ on 2019/5/15.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSScanUnrecognizedResultViewController.h"

@interface QSScanUnrecognizedResultViewController ()

@end

@implementation QSScanUnrecognizedResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_scan_unrecognized_nav_title")];
    
    [self p_setupSubViews];
}

- (void)p_setupSubViews {
    
    //标题
    UILabel *titleLabel = [UILabel labelWithName:QSLocalizedString(@"qs_scan_unrecognized_result_title") font:[UIFont qs_fontOfSize16] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:titleLabel];
    
    //内容
    UILabel *contentLabel = [UILabel labelWithName:self.analysisQRString font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentCenter];
    contentLabel.numberOfLines = 5;
    [self.view addSubview:contentLabel];
    
    //赋值按钮
    UIButton *copyButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_scan_unrecognized_result_copy_btn_title") titleColor:[UIColor qs_colorBlack333333] font:[UIFont qs_fontOfSize15] taget:self action:@selector(copyButtonClicked)];
    [self.view addSubview:copyButton];
    
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
        make.bottom.equalTo(contentLabel.mas_top).offset(-kRealValue(15));
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
    }];
    
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
        make.top.equalTo(contentLabel.mas_bottom).offset(kRealValue(15));
        make.height.equalTo(@kRealValue(20));
    }];
}

- (void)copyButtonClicked {
    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.analysisQRString];
    [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_collect_btn_copy_success_title")];
}


@end
