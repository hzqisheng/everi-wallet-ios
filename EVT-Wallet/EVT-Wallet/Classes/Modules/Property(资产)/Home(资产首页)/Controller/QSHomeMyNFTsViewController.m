//
//  QSHomeMyNFTsViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/26.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSHomeMyNFTsViewController.h"
#import "QSEveriPassDetailViewController.h"
#import "QSEveriPassCodeViewController.h"

#import "QSMyNFTsCell.h"

@interface QSHomeMyNFTsViewController ()

@property (nonatomic, strong) UIView *noDataView;

@end

static NSString *reuseIdentifier = @"QSHomeMyFTsCell";

@implementation QSHomeMyNFTsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHomeHeaderViewHeight + kRealValue(6))];
    headerView.backgroundColor = [UIColor qs_colorWhiteF5F7FB];
    self.tableView.tableHeaderView = headerView;
    [self.tableView registerClass:[QSMyNFTsCell class] forCellReuseIdentifier:reuseIdentifier];
    [self addRefreshHeader];
    [self startRefreshing];
}

- (void)tableViewShouldUpdateDataByPageIndex:(NSInteger)pageIndex {
    [[QSEveriApiWebViewController sharedWebView] getOwnedTokensWithPublicKeys:QSPublicKey andCompeleteBlock:^(NSInteger statusCode, NSArray<QSOwnedToken *> * _Nonnull ownedTokens) {
        if (statusCode == kResponseSuccessCode) {
            self.tableView.tableFooterView = ownedTokens.count ? nil : self.noDataView;
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:ownedTokens];
            [self.tableView reloadData];
        }
        [self endRefreshing];
    }];
}

- (void)everiPayClicked:(QSMyNFTsCell *)cell {
    [QSPasswordHelper verificationPasswordByPrivateKey:QSPrivateKey andSuccessBlock:^{
        QSEveriPassCodeViewController *everiPass = [[QSEveriPassCodeViewController alloc] init];
        everiPass.everiPassModel = cell.ownedToken;
        everiPass.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:everiPass animated:YES];
    }];
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSMyNFTsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.ownedToken = self.dataArray[indexPath.row];
    @weakify(self);
    cell.everiPayClickedBlock = ^(QSMyNFTsCell * _Nonnull cell) {
        @strongify(self);
        [self everiPayClicked:cell];
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
    QSOwnedToken *ownedToken = self.dataArray[indexPath.row];
    
    QSEveriPassDetailViewController *detail = [[QSEveriPassDetailViewController alloc] init];
    detail.domain = ownedToken.domain;
    detail.name = ownedToken.name;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - **************** Setter Getter
- (UIView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(50))];
        UILabel *noDataLabel = [UILabel labelWithName:QSLocalizedString(@"qs_home_no_nft_titlte") font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentCenter];
        noDataLabel.frame = _noDataView.bounds;
        [_noDataView addSubview:noDataLabel];
    }
    return _noDataView;
}

@end
