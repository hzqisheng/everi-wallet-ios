//
//  QSIssuePermissionsViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSIssuePermissionsViewController.h"
#import "QSIssueSettingEditViewController.h"
#import "QSIssuePermissionsIssueView.h"
#import "QSIssuePermissionsTransferView.h"

@interface QSIssuePermissionsViewController ()

@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) QSIssuePermissionsIssueView *issueView;
@property (nonatomic, strong) QSIssuePermissionsTransferView *transferView;

@end

@implementation QSIssuePermissionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_issue_issue_moreSetting_rightNavi")];
    [self addSubButton];
    [self.view addSubview:self.issueView];
    [self.view addSubview:self.transferView];
}

#pragma mark - **************** Initials
- (void)addSubButton {
    UIButton *bottomButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_select_ft_btn_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(bottomButtonClicked)];
    bottomButton.backgroundColor = [UIColor qs_colorBlack313745];
    bottomButton.layer.cornerRadius = 2;
    bottomButton.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
    bottomButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
    [self.view addSubview:bottomButton];
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kRealValue(339));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kBottomButtonWidth, kBottomButtonHeight));
    }];
    self.submitButton = bottomButton;
}

#pragma mark - **************** Event Response
- (void)bottomButtonClicked {
    
}

- (void)transferViewEdit {
    QSIssueSettingEditViewController *vc = [[QSIssueSettingEditViewController alloc] init];
    vc.issueSettingEditViewControllerSaveBlock = ^(NSString * _Nonnull text) {};
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)issueViewEdit {
    QSIssueSettingEditViewController *vc = [[QSIssueSettingEditViewController alloc] init];
    vc.issueSettingEditViewControllerSaveBlock = ^(NSString * _Nonnull text) {};
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - **************** Setter Getter
- (QSIssuePermissionsIssueView *)issueView {
    if (!_issueView) {
        _issueView = [[QSIssuePermissionsIssueView alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kScreenWidth - kRealValue(30), kRealValue(142))];
        _issueView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _issueView.layer.cornerRadius = kRealValue(8);
        WeakSelf(weakSelf);
        _issueView.issuePermissionsIssueViewClickEditBlock = ^{
            [weakSelf issueViewEdit];
        };
    }
    return _issueView;
}

- (QSIssuePermissionsTransferView *)transferView {
    if (!_transferView) {
        _transferView = [[QSIssuePermissionsTransferView alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(167), kScreenWidth - kRealValue(30), kRealValue(142))];
        _transferView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _transferView.layer.cornerRadius = kRealValue(8);
        WeakSelf(weakSelf);
        _transferView.issuePermissionsTransferViewClickEditBlock = ^{
            [weakSelf transferViewEdit];
        };
    }
    return _transferView;
}

@end
