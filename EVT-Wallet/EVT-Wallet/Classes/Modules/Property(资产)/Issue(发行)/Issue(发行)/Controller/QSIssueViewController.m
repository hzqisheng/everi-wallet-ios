//
//  QSIssueViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSIssueViewController.h"
#import "QSIssueSelectAddressViewController.h"
#import "QSScanningViewController.h"
#import "QSIssueWhiteView.h"

@interface QSIssueViewController ()

@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) QSIssueWhiteView *whiteView;

@end

@implementation QSIssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_btn_home_issue")];
    [self addSubButton];
    [self.view addSubview:self.whiteView];
}

#pragma mark - **************** Initials
- (void)addSubButton {
    UIButton *bottomButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_btn_home_issue") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(bottomButtonClicked)];
    bottomButton.backgroundColor = [UIColor qs_colorBlack313745];
    bottomButton.layer.cornerRadius = 2;
    [self.view addSubview:bottomButton];
    CGFloat bottomButtonBottomMargin = kDevice_Is_iPhoneX ? kiPhoneXSafeAreaBottomMagin : kRealValue(15);
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-bottomButtonBottomMargin);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kBottomButtonWidth, kBottomButtonHeight));
    }];
    self.submitButton = bottomButton;
}

#pragma mark - **************** Private Methods
- (void)bottomButtonClicked {
    WeakSelf(weakSelf);
    [[QSEveriApiWebViewController sharedWebView] isValidAddressWithAddress:self.whiteView.addressTextField.text andCompeleteBlock:^(NSInteger statusCode, NSString * _Nonnull isCorrect) {
        if (statusCode == kResponseSuccessCode) {
            if ([isCorrect isEqualToString:@"0"]) {
                [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_add_address_save_address_failure")];
                return ;
            } else {
                [weakSelf issueAction];
            }
        }
    }];
}

- (void)issueAction {
    if (!self.whiteView.circulationGrayTextField.text) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_issue_issue_circulation_placeholder")];
        return;
    }
    
    WeakSelf(weakSelf);
    NSString *sym = self.ftmodel.sym;
    NSArray *symArray = [sym componentsSeparatedByString:@","];
    if (symArray.count < 2) {
        return;
    }
    NSString *count = symArray[0];
    NSString *number = symArray[1];
    NSString *faxingliang = [NSString stringWithFormat:@"%@.",self.whiteView.circulationGrayTextField.text];
    for (int i = 0; i < [count integerValue]; i++) {
        faxingliang = [faxingliang stringByAppendingString:@"0"];
    }
    [[QSEveriApiWebViewController sharedWebView] pushTransactionIssueWithCirculation:[NSString stringWithFormat:@"%@ %@",faxingliang,number] andAddress:self.whiteView.addressTextField.text andNote:self.whiteView.remarkTextField.text andCompeleteBlock:^(NSInteger statusCode) {
        if (statusCode == kResponseSuccessCode) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_issue_success")];
        }
    }];
}

- (void)goToScanningVC {
    QSScanningViewController *vc = [[QSScanningViewController alloc] init];
    WeakSelf(weakSelf);
    vc.parseEvtLinkAndPopBlock = ^(NSString *publicKey) {
        weakSelf.whiteView.addressTextField.text = publicKey;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - **************** Setter Getter
- (QSIssueWhiteView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[QSIssueWhiteView alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kScreenWidth - kRealValue(30), kRealValue(212))];
        _whiteView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _whiteView.layer.cornerRadius = kRealValue(8);
        WeakSelf(weakSelf);
        _whiteView.issueWhiteViewDidClickChooseAddressButtonBlock = ^{
            QSIssueSelectAddressViewController *vc = [[QSIssueSelectAddressViewController alloc] init];
            vc.issueSelectAddressViewControllerChooseAddressBlock = ^(NSString * _Nonnull address) {
                weakSelf.whiteView.addressTextField.text = address;
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        _whiteView.issueWhiteViewDidClickSweepButtonBlock = ^{
            [weakSelf goToScanningVC];
        };
    }
    return _whiteView;
}

- (void)setFtmodel:(QSFT *)ftmodel {
    _ftmodel = ftmodel;
}

@end
