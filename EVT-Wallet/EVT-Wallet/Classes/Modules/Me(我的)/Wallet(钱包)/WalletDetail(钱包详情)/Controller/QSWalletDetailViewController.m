//
//  QSWalletDetailViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/4.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSWalletDetailViewController.h"
#import "QSExportPrivateKeyViewController.h"
#import "QSOpenFinerprintViewController.h"

#import "QSSettingCell.h"
#import "QSSettingItem.h"
#import "QSWalletDetailCell.h"
#import "QSWalletFingerprintCell.h"

#import "QSWalletContentItem.h"
#import "QSWallectFingerprintItem.h"
#import "QSLogoutAlertView.h"

typedef NS_ENUM(NSUInteger, QSWalletDetailType) {
    QSWalletDetailTypeContent,
    QSWalletDetailTypeExport,
    QSWalletDetailTypeSigh,
    QSWalletDetailTypeFingerprint
};

@interface QSWalletDetailViewController ()

@end

@implementation QSWalletDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.evtModel.publicKey.length) {
        self.evtModel = [QSWalletHelper sharedHelper].currentEvt;
    }
    [self createDataSource];
}

- (void)createDataSource {
    QSWalletContentItem *contentItem = [[QSWalletContentItem alloc] init];
    contentItem.leftTitle = @"EVT-wallet";
    contentItem.leftTitleFont = [UIFont qs_fontOfSize15];
    contentItem.content = self.evtModel.publicKey;
    contentItem.cellTag = QSWalletDetailTypeContent;
    contentItem.cellType = QSSettingItemTypeAccessnory;
    contentItem.cellSeapratorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    contentItem.cellIdentifier = NSStringFromClass([QSWalletDetailCell class]);
    contentItem.cellHeight = kRealValue(85);
    [self.dataArray addObject:@[contentItem]];
    
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
    [self.dataArray addObject:@[exportItem,signItem]];

    if ([QSTouchIDHelper sharedHelper].isSupportTouchID) {
        QSWallectFingerprintItem *fingerprintItem = [[QSWallectFingerprintItem alloc] init];
        fingerprintItem.cellTag = QSWalletDetailTypeFingerprint;
        fingerprintItem.cellSeapratorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        fingerprintItem.cellIdentifier = NSStringFromClass([QSWalletFingerprintCell class]);
        fingerprintItem.openFingerprint = self.evtModel.isOpenFingerprint;
        __weak __typeof(&*fingerprintItem) weakFingerprintItem = fingerprintItem;
        fingerprintItem.switchValueChangedBlock = ^(BOOL isOn) {
            if (isOn) {
                DLog(@"开启指纹");
                QSOpenFinerprintViewController *openVC = [[QSOpenFinerprintViewController alloc] init];
                openVC.openFinerprintSuccessBlock = ^{
                    [[QSWalletHelper sharedHelper] updateWalletOpenTouchID:YES byPrivateKey:self.evtModel.privateKey];
                    
                    weakFingerprintItem.openFingerprint = YES;
                    [self.tableView reloadData];
                };
                [self.navigationController pushViewController:openVC animated:YES];
            } else {
                [UIViewController showAlertViewWithTitle:QSLocalizedString(@"qs_wallet_detail_stop_fingerprint_title") message:nil confirmTitle:QSLocalizedString(@"qs_wallet_detail_stop_fingerprint_confirm") cancelTitle:QSLocalizedString(@"qs_wallet_detail_stop_fingerprint_cancel") confirmAction:^{
                    [[QSWalletHelper sharedHelper] updateWalletOpenTouchID:NO byPrivateKey:self.evtModel.privateKey];
                    weakFingerprintItem.openFingerprint = NO;
                    [self.tableView reloadData];
                } cancelAction:^{
                    [self.tableView reloadData];
                }];
            }
        };
        [self.dataArray addObject:@[fingerprintItem]];
    }
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<Class> *)getRigisterMultiCellClasses {
    return @[[QSSettingCell class],
             [QSWalletDetailCell class],
             [QSWalletFingerprintCell class]];
}

- (NSArray<NSArray<QSBaseCellItem *> *> *)createMultiSectionDataSource {
    return self.dataArray;
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
        WeakSelf(weakSelf);
        [QSPasswordHelper verificationPasswordByPrivateKey:QSPrivateKey
                                           andSuccessBlock:^{
                                               QSExportPrivateKeyViewController *privateKeyVC = [[QSExportPrivateKeyViewController alloc] init];
                                               privateKeyVC.EVTModel = self.evtModel;
                                               [weakSelf.navigationController pushViewController:privateKeyVC animated:YES];
                                           }];
    } else if (item.cellTag == QSWalletDetailTypeSigh) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_content_NO")];
    }
}


@end
