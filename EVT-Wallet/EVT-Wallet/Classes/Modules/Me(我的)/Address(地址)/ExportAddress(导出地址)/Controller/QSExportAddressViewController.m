//
//  QSExportAddressViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/29.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSExportAddressViewController.h"

@interface QSExportAddressViewController ()

@end

@implementation QSExportAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_export_address_nav_title")];
    [self setupAddressView];
    [self setupBottomButton];
}

- (void)setupAddressView {
    UIView *exportAddressView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kScreenWidth - kRealValue(30), kRealValue(115))];
    exportAddressView.layer.cornerRadius = 8;
    exportAddressView.backgroundColor = [UIColor whiteColor];
    exportAddressView.layer.shadowOffset = CGSizeMake(0, 1);
    exportAddressView.layer.shadowColor = [UIColor qs_colorGray00267B].CGColor;
    exportAddressView.layer.shadowOpacity = 0.1f;
    //    self.shadowContainerView.layer.shadowRadius = 6;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:exportAddressView.bounds cornerRadius:6];
    exportAddressView.layer.shadowPath = path.CGPath;
    [self.view addSubview:exportAddressView];
    
    UILabel *tipsLabel = [UILabel labelWithName:QSLocalizedString(@"qs_import_address_tips_title") font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    [tipsLabel changeLineSpaceWithSpace:kRealValue(10) textAlignment:NSTextAlignmentLeft];
    tipsLabel.frame = CGRectMake(kRealValue(15), kRealValue(15), exportAddressView.width - kRealValue(30), exportAddressView.height - kRealValue(30));
    tipsLabel.numberOfLines = 3;
    tipsLabel.textAlignment = NSTextAlignmentNatural;
    [exportAddressView addSubview:tipsLabel];
}

- (void)setupBottomButton {
    UIButton *bottomButton = [self createBottomButtonWithTitle:QSLocalizedString(@"qs_export_address_paste_btn_title") target:self action:@selector(saveButtonClicked)];
    CGFloat bottomButtomY = kDevice_Is_iPhoneX ? kScreenHeight - kNavgationBarHeight - kiPhoneXSafeAreaBottomMagin - kBottomButtonHeight : kScreenHeight - kNavgationBarHeight - kRealValue(15) - kBottomButtonHeight;
    bottomButton.frame = CGRectMake(kRealValue(15), bottomButtomY, kBottomButtonWidth, kBottomButtonHeight);
    [self.view addSubview:bottomButton];
}

#pragma mark - **************** Event Response
- (void)saveButtonClicked {
    DLog(@"复制");
}

@end
