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

@end

static NSString *reuseIdentifier = @"QSMyWalletCell";
static NSString *sectionReuseIdentifier = @"QSMyWalletSection";

@implementation QSMyWalletViewController

#pragma mark - **************** Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_wallet_nav_title")];
    [self setupTableView];
}

#pragma mark - **************** Initials
- (void)setupTableView {
    [self.tableView registerClass:[QSMyWalletCell class] forCellReuseIdentifier:reuseIdentifier];
    [self.tableView registerClass:[QSMyWalletSectionHeaderView class] forHeaderFooterViewReuseIdentifier:sectionReuseIdentifier];
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
    DLog(@"paste");
}

- (void)walletCellDidClickedMoreButton:(QSMyWalletCell *)cell {
    DLog(@"more");
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSMyWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    WeakSelf(weakSelf);
    cell.pasteButtonClickedBlock = ^(QSMyWalletCell * _Nonnull cell) {
        [weakSelf walletCellDidClickedPasteButton:cell];
    };
    
    cell.moreButtonClickedBlock = ^(QSMyWalletCell * _Nonnull cell) {
        [weakSelf walletCellDidClickedMoreButton:cell];
    };
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
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
    QSWalletDetailViewController *detail = [[QSWalletDetailViewController alloc] init];
    [detail setupNavgationBarTitle:@"EVT-Wallet"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
