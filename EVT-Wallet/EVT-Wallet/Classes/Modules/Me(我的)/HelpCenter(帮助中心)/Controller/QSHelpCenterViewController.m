//
//  QSHelpCenterViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/29.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSHelpCenterViewController.h"
#import "QSSettingCell.h"
#import "QSHelpCenterFunctionOverviewCell.h"
#import "QSSettingItem.h"
#import "QSHelpCenterOverViewItem.h"

@interface QSHelpCenterViewController ()

@end

@implementation QSHelpCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_help_center_nav_title")];
    [self setupTableView];
    [self createDataSource];
}

- (void)setupTableView {
    self.tableView.frame = CGRectMake(kRealValue(15), 0, kScreenWidth - kRealValue(30), kScreenHeight - kNavgationBarHeight);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.contentInset = UIEdgeInsetsMake(kRealValue(15), 0, 0, 0);
    [self.tableView registerClass:[QSHelpCenterFunctionOverviewCell class] forCellReuseIdentifier:NSStringFromClass([QSHelpCenterFunctionOverviewCell class])];
}

- (void)createDataSource {
    QSHelpCenterOverViewItem *overViewItem = [[QSHelpCenterOverViewItem alloc] init];
    overViewItem.leftTitle = QSLocalizedString(@"qs_help_center_item_overview_title");
    overViewItem.rightTitleFont = [UIFont qs_fontOfSize16];
    overViewItem.functionOverView = QSLocalizedString(@"qs_help_center_function_content");
    overViewItem.cellType = QSSettingItemTypeAccessnory;
    overViewItem.cellIdentifier = NSStringFromClass([QSHelpCenterFunctionOverviewCell class]);
    
    QSHelpCenterOverViewItem *downloadItem = [[QSHelpCenterOverViewItem alloc] init];
    downloadItem.leftTitle = QSLocalizedString(@"qs_help_center_item_download_title");
    downloadItem.rightTitleFont = [UIFont qs_fontOfSize16];
    downloadItem.cellType = QSSettingItemTypeAccessnory;
    downloadItem.functionOverView = QSLocalizedString(@"qs_help_center_function_content");
    downloadItem.cellIdentifier = NSStringFromClass([QSHelpCenterFunctionOverviewCell class]);

    QSHelpCenterOverViewItem *backupItem = [[QSHelpCenterOverViewItem alloc] init];
    backupItem.leftTitle = QSLocalizedString(@"qs_help_center_item_backup_title");
    backupItem.rightTitleFont = [UIFont qs_fontOfSize16];
    backupItem.cellType = QSSettingItemTypeAccessnory;
    backupItem.functionOverView = QSLocalizedString(@"qs_help_center_function_content");
    backupItem.cellIdentifier = NSStringFromClass([QSHelpCenterFunctionOverviewCell class]);

    self.dataArray = [@[overViewItem,
                        downloadItem,
                        backupItem] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSHelpCenterOverViewItem *item = self.dataArray[indexPath.row];
    QSSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:item.cellIdentifier forIndexPath:indexPath];
    [cell configureCellWithItem:item];
    [cell addSectionCornerWithTableView:tableView
                              indexPath:indexPath
                        cornerViewframe:CGRectMake(0, 0, item.cellWidth, item.cellHeight)
                           cornerRadius:8];
    cell.separatorInset = UIEdgeInsetsMake(0, item.leftSubviewMargin, 0, 0);
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSSettingItem *item = self.dataArray[indexPath.row];
    return item.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSHelpCenterOverViewItem *item = self.dataArray[indexPath.row];
    item.expand = !item.isExpand;
    if (item.isExpand) {
        item.cellHeight = item.cellExpandHeight;
    } else {
        item.cellHeight = item.cellNoExpandHeight;
    }
    [tableView reloadData];
}


@end
