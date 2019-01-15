//
//  QSMyWalletViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/27.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSMyWalletViewController.h"
#import "QSEditWalletsViewController.h"
#import "QSWalletDetailViewController.h"
#import "QSSelectWalletTypeViewController.h"
#import "QSMyWalletCell.h"
#import "QSMyWalletSectionHeaderView.h"

@interface QSMyWalletViewController ()

@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end

static NSString *reuseIdentifier = @"QSMyWalletCell";
static NSString *sectionReuseIdentifier = @"QSMyWalletSection";

@implementation QSMyWalletViewController

#pragma mark - **************** Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_wallet_nav_title")];
    [self setupTableView];
}

#pragma mark - **************** Initials
- (void)setupTableView {
    [self addRefreshHeader];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[QSMyWalletCell class] forCellReuseIdentifier:reuseIdentifier];
    [self.tableView registerClass:[QSMyWalletSectionHeaderView class] forHeaderFooterViewReuseIdentifier:sectionReuseIdentifier];
}

- (void)tableViewShouldUpdateDataByPageIndex:(NSInteger)pageIndex {
    if (self.dataArray.count) {
        [self.dataArray removeAllObjects];
    }
    self.dataArray = [NSMutableArray arrayWithArray:[[QSWalletHelper sharedHelper] getWalletArray]];
    [self.tableView reloadData];
    [self endRefreshing];
}

#pragma mark - **************** Event Response
- (void)walletSectionHeaderDidClickedInSection:(NSInteger)section {
    DLog(@"%ld",(long)section);
    if (section == 0) {
        QSEditWalletsViewController *editWallet = [[QSEditWalletsViewController alloc] init];
        [self.navigationController pushViewController:editWallet animated:YES];
    } else if (section == 1) {
        QSSelectWalletTypeViewController *selectType = [[QSSelectWalletTypeViewController alloc] init];
        [self.navigationController pushViewController:selectType animated:YES];
    }
}

- (void)walletCellDidClickedPasteButton:(QSMyWalletCell *)cell {
    QSCreateEvt *wallet = cell.wallet;
    if (wallet.publicKey.length) {
        UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:wallet.publicKey];
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_collect_btn_copy_success_title")];
    }
}

- (void)walletCellDidClickedMoreButton:(QSMyWalletCell *)cell andSection:(NSInteger)section {
    QSWalletDetailViewController *detail = [[QSWalletDetailViewController alloc] init];
    detail.evtModel = cell.wallet;
    [detail setupNavgationBarTitle:@"EVT-Wallet"];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSMyWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (indexPath.row == self.currentIndexPath.row && indexPath.section == self.currentIndexPath.section) {
        [cell.walletBackgroundView setImage:[UIImage imageNamed:@"img_qianbao_card"]];
    } else {
        [cell.walletBackgroundView setImage:[UIImage imageNamed:@"img_qianbao_card1"]];
    }
    WeakSelf(weakSelf);
    cell.pasteButtonClickedBlock = ^(QSMyWalletCell * _Nonnull cell) {
        [weakSelf walletCellDidClickedPasteButton:cell];
    };
    
    cell.moreButtonClickedBlock = ^(QSMyWalletCell * _Nonnull cell) {
        [weakSelf walletCellDidClickedMoreButton:cell andSection:indexPath.section];
    };
    if (indexPath.section == 0) {
        cell.wallet = self.dataArray[0];
    } else {
        NSMutableArray *section1Array = [NSMutableArray arrayWithArray:self.dataArray];
        [section1Array removeObjectAtIndex:0];
        cell.wallet = section1Array[indexPath.row];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.dataArray.count - 1;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kRealValue(46);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    QSMyWalletSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionReuseIdentifier];
    headerView.section = section;
    WeakSelf(weakSelf);
    headerView.walletSectionHeaderClickedBlock = ^(NSInteger section) {
        [weakSelf walletSectionHeaderDidClickedInSection:section];
    };
    if (section == 0) {
        headerView.titleLabel.text = QSLocalizedString(@"qs_wallet_current_title");
    } else if (section == 1) {
        headerView.titleLabel.text = QSLocalizedString(@"qs_wallet_imported_title");;
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return kRealValue(10);
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRealValue(106);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentIndexPath.row == indexPath.row && self.currentIndexPath.section == indexPath.section) {
        return;
    }
    self.currentIndexPath = indexPath;
    if (indexPath.section == 0) {
        QSCreateEvt *FirstEVt = self.dataArray[0];
        [[QSWalletHelper sharedHelper] switchWallet:FirstEVt andIndexPath:indexPath];
    } else if (indexPath.section == 1) {
        NSMutableArray *section1Array = [NSMutableArray arrayWithArray:self.dataArray];
        [section1Array removeObjectAtIndex:0];
        [[QSWalletHelper sharedHelper] switchWallet:section1Array[indexPath.row] andIndexPath:indexPath];
    }
    [self.tableView reloadData];
    [[QSWalletHelper sharedHelper] turnToHomeViewController];
}

- (NSIndexPath *)currentIndexPath {
    if (!_currentIndexPath) {
        _currentIndexPath = [[QSWalletHelper sharedHelper] getCurrentIndexPath];
    }
    return _currentIndexPath;
}

@end
