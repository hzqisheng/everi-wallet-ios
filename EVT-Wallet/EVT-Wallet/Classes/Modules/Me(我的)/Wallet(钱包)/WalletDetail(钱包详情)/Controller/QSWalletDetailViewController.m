//
//  QSWalletDetailViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/4.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSWalletDetailViewController.h"
#import "QSExportPrivateKeyViewController.h"

#import "QSSettingCell.h"
#import "QSSettingItem.h"
#import "QSWalletDetailCell.h"
#import "QSWalletContentItem.h"

typedef NS_ENUM(NSUInteger, QSWalletDetailType) {
    QSWalletDetailTypeContent,
    QSWalletDetailTypeExport,
    QSWalletDetailTypeSigh,
};

@interface QSWalletDetailViewController ()

@end

@implementation QSWalletDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSArray<Class> *)getRigisterMultiCellClasses {
    return @[[QSSettingCell class],
             [QSWalletDetailCell class]];
}

- (NSArray<NSArray<QSBaseCellItem *> *> *)createMultiSectionDataSource {
    QSWalletContentItem *contentItem = [[QSWalletContentItem alloc] init];
    contentItem.leftTitle = @"EVT-wallet";
    contentItem.leftTitleFont = [UIFont qs_fontOfSize15];
    contentItem.content = @"EOS5fKvaUBt7gBagCUBt7gBagCUBt7gBagCUBt7gBagCUBt7gBagC";
    contentItem.cellTag = QSWalletDetailTypeContent;
    contentItem.cellType = QSSettingItemTypeAccessnory;
    contentItem.cellSeapratorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    contentItem.cellIdentifier = NSStringFromClass([QSWalletDetailCell class]);
    contentItem.cellHeight = kRealValue(85);
    
    QSSettingItem *exportItem = [[QSSettingItem alloc] init];
    exportItem.leftTitle = QSLocalizedString(@"qs_wallet_detail_item_export_title");
    exportItem.leftTitleFont = [UIFont qs_fontOfSize16];
    exportItem.cellTag = QSWalletDetailTypeExport;
    exportItem.cellType = QSSettingItemTypeAccessnory;
    exportItem.cellSeapratorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    exportItem.cellIdentifier = NSStringFromClass([QSSettingCell class]);

    QSSettingItem *signItem = [[QSSettingItem alloc] init];
    signItem.leftTitle = QSLocalizedString(@"qs_wallet_detail_item_sign_title");
    signItem.leftTitleFont = [UIFont qs_fontOfSize16];
    signItem.cellTag = QSWalletDetailTypeSigh;
    signItem.cellType = QSSettingItemTypeAccessnory;
    signItem.cellSeapratorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    signItem.cellIdentifier = NSStringFromClass([QSSettingCell class]);
    
    return @[@[contentItem],
             @[exportItem,
               signItem]];
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return kRealValue(10);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSBaseCellItem *item = [self itemInIndexPath:indexPath];
    if (item.cellTag == QSWalletDetailTypeContent) {
        
    } else if (item.cellTag == QSWalletDetailTypeExport) {
        QSExportPrivateKeyViewController *privateKey = [[QSExportPrivateKeyViewController alloc] init];
        [self.navigationController pushViewController:privateKey animated:YES];
    }else if (item.cellTag == QSWalletDetailTypeSigh) {
        
    }
}


@end
