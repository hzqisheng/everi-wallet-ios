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
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.contentInset = UIEdgeInsetsMake(kRealValue(15), 0, 0, 0);
    [self.tableView registerClass:[QSHelpCenterFunctionOverviewCell class] forCellReuseIdentifier:NSStringFromClass([QSHelpCenterFunctionOverviewCell class])];
}

- (void)createDataSource {
    NSArray *titleArray = @[@"qs_help_center_item_overview_title",
                            @"qs_help_center_item_create_title",
                            @"qs_help_center_item_backup_title",
                            @"qs_help_center_item_import_title",
                            @"qs_help_center_item_transfer_title",
                            @"qs_help_center_item_domain_title",
                            @"qs_help_center_item_ft_title",
                            @"qs_help_center_item_nft_title",
                            @"qs_help_center_item_issue_ft_title",
                            @"qs_help_center_item_issue_nft_title",
                            @"qs_help_center_item_how_to_use_everipay_title",
                            @"qs_help_center_item_how_to_use_everipass_title",
                            @"qs_help_center_item_change_language_title"];
    NSArray *contentArray = @[@"qs_help_center_item_overview_content",
                              @"qs_help_center_item_create_content",
                              @"qs_help_center_item_backup_content",
                              @"qs_help_center_item_import_content",
                              @"qs_help_center_item_transfer_content",
                              @"qs_help_center_item_domain_content",
                              @"qs_help_center_item_ft_content",
                              @"qs_help_center_item_nft_content",
                              @"qs_help_center_item_issue_ft_content",
                              @"qs_help_center_item_issue_nft_content",
                              @"qs_help_center_item_how_to_use_everipay_content",
                              @"qs_help_center_item_how_to_use_everipass_content",
                              @"qs_help_center_item_change_language_content"];
    
    for (int i = 0; i < titleArray.count; i++) {
        QSHelpCenterOverViewItem *helpItem = [[QSHelpCenterOverViewItem alloc] init];
        helpItem.leftTitle = QSLocalizedString(titleArray[i]);
        helpItem.rightTitleFont = [UIFont qs_fontOfSize16];
        helpItem.functionOverView = QSLocalizedString(contentArray[i]);
        helpItem.cellType = QSSettingItemTypeAccessnory;
        helpItem.cellIdentifier = NSStringFromClass([QSHelpCenterFunctionOverviewCell class]);
        [self.dataArray addObject:helpItem];
    }
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
    
    for (QSHelpCenterOverViewItem *helpItem in self.dataArray) {
        if (helpItem == item) {
            helpItem.expand = !helpItem.isExpand;
            if (helpItem.isExpand) {
                helpItem.cellHeight = helpItem.cellExpandHeight;
            } else {
                helpItem.cellHeight = helpItem.cellNoExpandHeight;
            }
        } else {
            helpItem.expand = NO;
            helpItem.cellHeight = helpItem.cellNoExpandHeight;
        }
    }
    [tableView reloadData];
}


@end
