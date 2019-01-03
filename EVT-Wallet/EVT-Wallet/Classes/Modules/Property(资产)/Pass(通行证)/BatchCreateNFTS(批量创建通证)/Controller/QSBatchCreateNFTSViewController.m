//
//  QSBatchCreateNFTSViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/13.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBatchCreateNFTSViewController.h"
#import "QSScanningViewController.h"
#import "QSBatchCreateNFTSTopView.h"
#import "QSBatchCreateNFTSCenterView.h"
#import "QSBatchCreateNFTsBottomView.h"

@interface QSBatchCreateNFTSViewController ()

@property (nonatomic, strong) QSBatchCreateNFTSTopView *topView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) QSBatchCreateNFTSCenterView *centerView;
@property (nonatomic, strong) QSBatchCreateNFTsBottomView *bottomView;
@property (nonatomic, strong) UIButton *issueButton;

@end

@implementation QSBatchCreateNFTSViewController

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
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.top.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
        make.height.equalTo(@kRealValue(150));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.top.equalTo(self.topView.mas_bottom).offset(kRealValue(26));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
        make.height.equalTo(@kRealValue(101));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.top.equalTo(self.centerView.mas_bottom).offset(kRealValue(8));
        make.right.equalTo(self.view).offset(-kRealValue(15));
        make.height.equalTo(@kRealValue(101));
    }];
    
    [self.issueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.bottomView.mas_bottom).offset(kRealValue(29));
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - kRealValue(30), kRealValue(40)));
    }];
}

#pragma mark - **************** Event Response
- (void)bottomButtonClicked {
    NSArray *nameArr = [self.topView.textView.text componentsSeparatedByString:@"\n"];
    NSMutableArray *nameArray = [NSMutableArray arrayWithArray:nameArr];
    for (int i = 0; i < nameArr.count; i++) {
        NSString *name = nameArr[i];
        if (!name.length) {
            [nameArray removeObject:name];
        }
    }
    WeakSelf(weakSelf);
    [[QSEveriApiWebViewController sharedWebView] pushTransactionNFTWithDomain:self.NFTModel.name andNameArr:nameArray andOwner:self.bottomView.addressLabel.text AndCompeleteBlock:^(NSInteger statusCode) {
        if (statusCode == kResponseSuccessCode) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)scanBtnClick {
    WeakSelf(weakSelf);
    QSScanningViewController *scanVC = [[QSScanningViewController alloc] init];
    scanVC.scanningViewControllerScanAddressBlock = ^(NSString *address) {
        weakSelf.bottomView.addressLabel.text = address;
    };
    [self.navigationController pushViewController:scanVC animated:YES];
}

- (void)createBtnClicked {
    if (!self.centerView.nameTextField.text.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_createNFT_nil")];
        return;
    }
    NSString *nameStr = @"";
    for (int i = 0; i < [self.centerView.countLabel.text integerValue]; i++) {
        if (i == 0) {
            nameStr = [nameStr stringByAppendingString:[NSString stringWithFormat:@"%@%d",self.centerView.nameTextField.text,i + 1]];
        } else {
            nameStr = [nameStr stringByAppendingString:[NSString stringWithFormat:@"\n%@%d",self.centerView.nameTextField.text,i + 1]];
        }
    }
    self.topView.textView.text = nameStr;
    self.topView.countLabel.text = [NSString stringWithFormat:@"%@:%ld",QSLocalizedString(@"qs_pass_createNFTS_batch_count"),[self.centerView.countLabel.text integerValue]];
}

#pragma mark - **************** Setter Getter
- (QSBatchCreateNFTSTopView *)topView {
    if (!_topView) {
        _topView = [[QSBatchCreateNFTSTopView alloc] init];
        _topView.layer.cornerRadius = kRealValue(8);
        _topView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = QSLocalizedString(@"qs_pass_createNFTS_batch_topView_label");
        _titleLabel.font = [UIFont qs_boldFontOfSize16];
        _titleLabel.textColor = [UIColor qs_colorBlack333333];
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (QSBatchCreateNFTSCenterView *)centerView {
    if (!_centerView) {
        _centerView = [[QSBatchCreateNFTSCenterView alloc] init];
        _centerView.layer.cornerRadius = kRealValue(8);
        _centerView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        WeakSelf(weakSelf);
        _centerView.batchCreateNFTSCenterViewCreateBtnClickedBlock = ^{
            [weakSelf createBtnClicked];
        };
        [self.view addSubview:_centerView];
    }
    return _centerView;
}

- (QSBatchCreateNFTsBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[QSBatchCreateNFTsBottomView alloc] init];
        _bottomView.layer.cornerRadius = kRealValue(8);
        _bottomView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        WeakSelf(weakSelf);
        _bottomView.batchCreateNFTsBottomViewScanBtnClickedBlock = ^{
            [weakSelf scanBtnClick];
        };
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

- (UIButton *)issueButton {
    if (!_issueButton) {
        _issueButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_btn_home_issue") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(bottomButtonClicked)];
        _issueButton.backgroundColor = [UIColor qs_colorBlack313745];
        _issueButton.layer.cornerRadius = 2;
        [self.view addSubview:_issueButton];
    }
    return _issueButton;
}

@end
