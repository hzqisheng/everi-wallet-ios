//
//  QSCreateNFTSViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateNFTSViewController.h"
#import "QSCreateNFTSEditViewController.h"

#import "QSCreateNFTSIssueView.h"
#import "QSCreateNFTSTransferView.h"
#import "QSCreateNFTSManagerView.h"


@interface QSCreateNFTSViewController ()

@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UILabel *regionLabel;
@property (nonatomic, strong) UITextField *topTextField;

@property (nonatomic, strong) QSCreateNFTSIssueView *issueView;
@property (nonatomic, strong) QSCreateNFTSTransferView *transferView;
@property (nonatomic, strong) QSCreateNFTSManagerView *managerView;

@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation QSCreateNFTSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_pass_mypass_btn_title")];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_chuangjianyu_help"] target:self action:@selector(rightBarItemClicked)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    [self loadUI];
}

- (void)rightBarItemClicked {
    
}

- (void)loadUI {
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.top.equalTo(self.view).offset(kRealValue(15));
        make.centerX.equalTo(self.view);
        make.height.equalTo(@kRealValue(45));
    }];
    
    [self.regionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(15));
        make.centerY.equalTo(self.whiteView);
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.topTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.regionLabel.mas_right).offset(kRealValue(10));
        make.right.equalTo(self.whiteView).offset(-kRealValue(10));
        make.centerY.equalTo(self.whiteView);
        make.height.equalTo(@kRealValue(30));
    }];
    
    [self.issueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.top.equalTo(self.whiteView.mas_bottom).offset(kRealValue(10));
        make.centerX.equalTo(self.view);
        make.height.equalTo(@kRealValue(142));
    }];
    
    [self.transferView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.top.equalTo(self.issueView.mas_bottom).offset(kRealValue(10));
        make.centerX.equalTo(self.view);
        make.height.equalTo(@kRealValue(142));
    }];
    
    [self.managerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.top.equalTo(self.transferView.mas_bottom).offset(kRealValue(10));
        make.centerX.equalTo(self.view);
        make.height.equalTo(@kRealValue(142));
    }];
    
    CGFloat bottomButtonBottomMargin = kDevice_Is_iPhoneX ? kiPhoneXSafeAreaBottomMagin : kRealValue(15);
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-bottomButtonBottomMargin);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kBottomButtonWidth, kBottomButtonHeight));
    }];
}

#pragma mark - **************** Event Response
- (void)bottomButtonClicked {
    QSNFT *NFTModel = [[QSNFT alloc] init];
    NFTModel.name = self.topTextField.text;
    if (!self.topTextField.text.length) {
        return;
    }
    NFTModel.creator = QSPublicKey;
    QSNFTTransfer *issue = [[QSNFTTransfer alloc] init];
    issue.name = @"issue";
    QSNFTTransfer *manage = [[QSNFTTransfer alloc] init];
    manage.name = @"manage";
    QSNFTTransfer *transfer = [[QSNFTTransfer alloc] init];
    transfer.name = @"transfer";
    QSAuthorizers *authorizers = [[QSAuthorizers alloc] init];
    //    authorizers.ref = [NSString stringWithFormat:@"[A] %@",[QSWalletHelper sharedHelper].currentEvt.publicKey];
    if (self.issueView.manualButton.selected) {
        issue.threshold = 1;
        authorizers.ref = [NSString stringWithFormat:@"[A] %@",QSPublicKey];
        authorizers.weight = 1;
        NSArray * authArr = @[authorizers];
        issue.authorizers = [NSArray arrayWithArray:authArr];
    } else {
        if (self.issueView.onlyButton.selected) {
            issue.threshold = 1;
            authorizers.ref = [NSString stringWithFormat:@"[A] %@",QSPublicKey];
            authorizers.weight = 1;
            NSArray * authArr = @[authorizers];
            issue.authorizers = [NSArray arrayWithArray:authArr];
        } else {
            issue.threshold = 0;
            issue.authorizers = @[];
        }
    }
    if (self.transferView.manualButton.selected) {
        transfer.threshold = 1;
        authorizers.ref = [NSString stringWithFormat:@"[A] %@",QSPublicKey];
        authorizers.weight = 1;
        NSArray * authArr = @[authorizers];
        transfer.authorizers = [NSArray arrayWithArray:authArr];
    } else {
        if (self.transferView.onlyButton.selected) {
            transfer.threshold = 1;
            authorizers.ref = [NSString stringWithFormat:@"[A] %@",QSPublicKey];
            authorizers.weight = 1;
            NSArray * authArr = @[authorizers];
            transfer.authorizers = [NSArray arrayWithArray:authArr];
        } else {
            transfer.threshold = 0;
            transfer.authorizers = @[];
        }
    }
    if (self.managerView.manualButton.selected) {
        manage.threshold = 1;
        authorizers.ref = [NSString stringWithFormat:@"[A] %@",QSPublicKey];
        authorizers.weight = 1;
        NSArray * authArr = @[authorizers];
        manage.authorizers = [NSArray arrayWithArray:authArr];
    } else {
        if (self.managerView.onlyButton.selected) {
            manage.threshold = 1;
            authorizers.ref = [NSString stringWithFormat:@"[A] %@",QSPublicKey];
            authorizers.weight = 1;
            NSArray * authArr = @[authorizers];
            manage.authorizers = [NSArray arrayWithArray:authArr];
        } else {
            manage.threshold = 0;
            manage.authorizers = @[];
        }
    }
    NFTModel.issue = issue;
    NFTModel.manage = manage;
    NFTModel.transfer = transfer;
    
    
    WeakSelf(weakSelf);
    [[QSEveriApiWebViewController sharedWebView] pushTransactionNFTWithNFT:NFTModel andCompeleteBlock:^(NSInteger statusCode, QSNFT * _Nonnull ftmodel) {
        if (statusCode == kResponseSuccessCode) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)issueViewEdit {
    QSCreateNFTSEditViewController *vc = [[QSCreateNFTSEditViewController alloc] init];
    vc.createNFTSEditViewControllerSaveBlock = ^(NSString *text) {
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)transferViewEdit {
    QSCreateNFTSEditViewController *vc = [[QSCreateNFTSEditViewController alloc] init];
    vc.createNFTSEditViewControllerSaveBlock = ^(NSString *text) {
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)managerViewEdit {
    WeakSelf(weakSelf);
    QSCreateNFTSEditViewController *vc = [[QSCreateNFTSEditViewController alloc] init];
    vc.createNFTSEditViewControllerSaveBlock = ^(NSString *text) {
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - **************** Setter Getter
- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _whiteView.layer.cornerRadius = kRealValue(8);
        [self.view addSubview:_whiteView];
    }
    return _whiteView;
}

- (UILabel *)regionLabel {
    if (!_regionLabel) {
        _regionLabel = [[UILabel alloc] init];
        _regionLabel.text = QSLocalizedString(@"qs_pass_createNFTS_yu_title");
        _regionLabel.textColor = [UIColor qs_colorBlack333333];
        _regionLabel.font = [UIFont qs_boldFontOfSize16];
        [self.whiteView addSubview:_regionLabel];
    }
    return _regionLabel;
}

- (UITextField *)topTextField {
    if (!_topTextField) {
        _topTextField = [[UITextField alloc] init];
        _topTextField.placeholder = QSLocalizedString(@"qs_pass_createNFTS_yu_placeholder");
        _topTextField.textColor = [UIColor qs_colorBlack333333];
        _topTextField.font = [UIFont qs_fontOfSize14];
        [_topTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        [_topTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        _topTextField.textAlignment = NSTextAlignmentRight;
        [self.whiteView addSubview:_topTextField];
    }
    return _topTextField;
}

- (QSCreateNFTSIssueView *)issueView {
    if (!_issueView) {
        _issueView = [[QSCreateNFTSIssueView alloc] init];
        _issueView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _issueView.layer.cornerRadius = kRealValue(8);
        WeakSelf(weakSelf);
        _issueView.createNFTSIssueViewClickEditButtonBlock = ^{
            [weakSelf issueViewEdit];
        };
        [self.view addSubview:_issueView];
    }
    return _issueView;
}

- (QSCreateNFTSTransferView *)transferView {
    if (!_transferView) {
        _transferView = [[QSCreateNFTSTransferView alloc] init];
        _transferView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _transferView.layer.cornerRadius = kRealValue(8);
        WeakSelf(weakSelf);
        _transferView.createNFTSTransferViewClickEditButtonBlock = ^{
            [weakSelf transferViewEdit];
        };
        [self.view addSubview:_transferView];
    }
    return _transferView;
}

- (QSCreateNFTSManagerView *)managerView {
    if (!_managerView) {
        _managerView = [[QSCreateNFTSManagerView alloc] init];
        _managerView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _managerView.layer.cornerRadius = kRealValue(8);
        WeakSelf(weakSelf);
        _managerView.createNFTSManagerClickEditButtonBlock = ^{
            [weakSelf managerViewEdit];
        };
        [self.view addSubview:_managerView];
    }
    return _managerView;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_select_ft_btn_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(bottomButtonClicked)];
        _submitButton.backgroundColor = [UIColor qs_colorBlack313745];
        _submitButton.layer.cornerRadius = 2;
        [self.view addSubview:_submitButton];
    }
    return _submitButton;
}

@end
