//
//  QSSelectFTViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/10.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSSelectFTViewController.h"
#import "QSBottomButtonView.h"
#import "QSSelectFTCell.h"
#import "QSCreateFTViewController.h"
#import "QSIssueViewController.h"
#import "QSIssueMoreSettingViewController.h"

@interface QSSelectFTViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

static NSString * const kSelectFTCell = @"selectFTCell";

@implementation QSSelectFTViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_select_ft_nav_titlte")];
    
    UIButton *bottomButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_select_ft_btn_titlte") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(bottomButtonClicked)];
    [bottomButton setImage:[UIImage imageNamed:@"icon_xuanzedaibi_plus"] forState:UIControlStateNormal];
    bottomButton.backgroundColor = [UIColor qs_colorBlack313745];
    bottomButton.layer.cornerRadius = 2;
    bottomButton.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
    bottomButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
    [self.view addSubview:bottomButton];
    CGFloat bottomButtonBottomMargin = kDevice_Is_iPhoneX ? kiPhoneXSafeAreaBottomMagin : kRealValue(15);
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-bottomButtonBottomMargin);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kBottomButtonWidth, kBottomButtonHeight));
    }];
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView.frame = CGRectMake(kRealValue(15), kRealValue(15), kRealValue(345), kScreenHeight - kNavgationBarHeight - kBottomButtonHeight - kiPhoneXSafeAreaBottomMagin - kRealValue(35));
     self.tableView.backgroundColor = [UIColor clearColor];
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[QSSelectFTCell class] forCellReuseIdentifier:kSelectFTCell];
    [self addRefreshHeader];
}

- (void)tableViewShouldUpdateDataByPageIndex:(NSInteger)pageIndex {
    WeakSelf(weakSelf);
    [[QSEveriApiWebViewController sharedWebView] getEVTFungiblesListWithPublicKey:[QSWalletHelper sharedHelper].currentEvt.publicKey andCompeleteBlock:^(NSInteger statusCode, NSArray * _Nonnull ftList) {
        if (statusCode == kResponseSuccessCode) {
            if (weakSelf.dataArray.count) {
                [weakSelf.dataArray removeAllObjects];
            }
            weakSelf.dataArray = [NSMutableArray arrayWithArray:ftList];
            [weakSelf.tableView reloadData];
        }
    }];
    [self endRefreshing];
}

#pragma mark - **************** Event Response
- (void)bottomButtonClicked {
    QSCreateFTViewController *vc = [[QSCreateFTViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - **************** TableView Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSSelectFTCell *cell = [tableView dequeueReusableCellWithIdentifier:kSelectFTCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WeakSelf(weakSelf);
    cell.selectFTCellDidClickMoreButtonBlock = ^(QSSelectFTCell * _Nonnull cell) {
        QSIssueMoreSettingViewController *vc = [[QSIssueMoreSettingViewController alloc] init];
        vc.ftModel = cell.ftModel;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    cell.ftModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRealValue(100);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSIssueViewController *vc = [[QSIssueViewController alloc] init];
    vc.ftmodel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - **************** Setter Getter



@end
