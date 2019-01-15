//
//  QSHomeMyFTsPropertyViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/26.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSHomeMyFTsViewController.h"
#import "QSTransactionRecordViewController.h"
#import "QSEveriPayCodeViewController.h"
#import "QSHomeMyFTsCell.h"
#import "QSPrivatekeyAlertView.h"

@interface QSHomeMyFTsViewController ()

@property (nonatomic, strong) UIView *noDataView;

@end

static NSString *reuseIdentifier = @"QSHomeMyFTsCell";

@implementation QSHomeMyFTsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHomeHeaderViewHeight + kRealValue(6))];
    headerView.backgroundColor = [UIColor qs_colorWhiteF5F7FB];
    self.tableView.tableHeaderView = headerView;
    [self.tableView registerClass:[QSHomeMyFTsCell class] forCellReuseIdentifier:reuseIdentifier];
    [self addRefreshHeader];
    [self startRefreshing];
}

- (void)tableViewShouldUpdateDataByPageIndex:(NSInteger)pageIndex {
    [[QSEveriApiWebViewController sharedWebView] getEVTFungibleBalanceListWithPublicKey:QSPublicKey andCompeleteBlock:^(NSInteger statusCode, NSArray * _Nonnull ftList) {
        if (statusCode == kResponseSuccessCode) {
            self.tableView.tableFooterView = ftList.count ? nil : self.noDataView;
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:ftList];
            [self.tableView reloadData];
        }
        [self endRefreshing];
    }];
}

#pragma mark - **************** Event Response
- (void)everipayButtonActionWithCell:(QSHomeMyFTsCell *)cell {
    WeakSelf(weakSelf);
    [QSPasswordHelper verificationPasswordByPrivateKey:QSPrivateKey andSuccessBlock:^{
        QSEveriPayCodeViewController *payVC = [[QSEveriPayCodeViewController alloc] init];
        payVC.selectFTModel = cell.FTModel;
        payVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:payVC animated:YES];
    }];
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSHomeMyFTsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.FTModel = self.dataArray[indexPath.row];
    WeakSelf(weakSelf);
    cell.everiPayClickedBlock = ^(QSHomeMyFTsCell * _Nonnull cell) {
        [weakSelf everipayButtonActionWithCell:cell];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRealValue(65);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSTransactionRecordViewController *record = [[QSTransactionRecordViewController alloc] init];
    record.FTModel = self.dataArray[indexPath.row];
    record.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:record animated:YES];
}

#pragma mark - **************** Setter Getter
- (UIView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(50))];
        UILabel *noDataLabel = [UILabel labelWithName:QSLocalizedString(@"qs_home_no_ft_titlte") font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentCenter];
        noDataLabel.frame = _noDataView.bounds;
        [_noDataView addSubview:noDataLabel];
    }
    return _noDataView;
}

@end
