//
//  QSIssueMoreSettingViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSIssueMoreSettingViewController.h"
#import "QSIssueMoreSettingTopView.h"
#import "QSIssueMoreSettingBottomView.h"
#import "QSIssuePermissionsViewController.h"
#import "QSAuthorizers.h"

@interface QSIssueMoreSettingViewController ()

@property (nonatomic, strong) QSIssueMoreSettingTopView *topView;
@property (nonatomic, strong) QSIssueMoreSettingBottomView *bottomView;

@end

@implementation QSIssueMoreSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_btn_home_issue")];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:QSLocalizedString(@"qs_issue_issue_moreSetting_rightNavi") font:[UIFont qs_fontOfSize14] titleColor:[UIColor qs_colorYellowE4B84F] target:self action:@selector(rightBarItemClicked)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
}

- (void)rightBarItemClicked {
    QSIssuePermissionsViewController *vc = [[QSIssuePermissionsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - **************** Setter Getter
- (QSIssueMoreSettingTopView *)topView {
    if (!_topView) {
        _topView = [[QSIssueMoreSettingTopView alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kScreenWidth - kRealValue(30), kRealValue(239))];
        _topView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _topView.layer.cornerRadius = kRealValue(8);
    }
    return _topView;
}

- (QSIssueMoreSettingBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[QSIssueMoreSettingBottomView alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(264), kScreenWidth - kRealValue(30), kRealValue(120))];
        _bottomView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _bottomView.layer.cornerRadius = kRealValue(8);
        WeakSelf(weakSelf);
        _bottomView.issueMoreSettingBottomViewAddMetadataBlock = ^{
            
            
            
        };
    }
    return _bottomView;
}

- (void)setFtModel:(QSFT *)ftModel {
    _ftModel = ftModel;
    NSString *sym = ftModel.sym;
    NSArray *symArray = [sym componentsSeparatedByString:@"S"];
    if (symArray.count < 2) {
        return;
    }
    self.topView.EVTLabel.text = [NSString stringWithFormat:@"EVT(%@)",symArray[1]];
    self.topView.timeLabel.text = ftModel.create_time;
    QSFTIssue *issue = ftModel.issue;
    QSFTManage *manage = ftModel.manage;
    NSString *issueAuthStr = @"";
    if (issue.threshold == 1) {
        QSAuthorizers *issueAuth = issue.authorizers[0];
        issueAuthStr = issueAuth.ref;
    } else {
        issueAuthStr = @"";
    }
    self.topView.issueThresholdLabel.text = [NSString stringWithFormat:@"%@:%ld",QSLocalizedString(@"qs_manage_createGroup_threshold"),issue.threshold];
    self.topView.managementThresholdLabel.text = [NSString stringWithFormat:@"%@:%ld",QSLocalizedString(@"qs_manage_createGroup_threshold"),manage.threshold];
    self.topView.issueLetterLabel.text = issueAuthStr;
    
}

@end
