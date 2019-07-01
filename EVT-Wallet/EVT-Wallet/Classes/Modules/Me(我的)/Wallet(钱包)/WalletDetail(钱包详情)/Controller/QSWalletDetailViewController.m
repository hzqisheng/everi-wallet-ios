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
#import "QSModifyPasswordViewController.h"
#import "QSImportWalletIndexViewController.h"

#import "QSSettingCell.h"
#import "QSSettingItem.h"
#import "QSWalletDetailCell.h"
#import "QSWalletFingerprintCell.h"

#import "QSWalletContentItem.h"
#import "QSWallectFingerprintItem.h"
#import "QSInputAlertView.h"

typedef NS_ENUM(NSUInteger, QSWalletDetailType) {
    QSWalletDetailTypeContent,
    QSWalletDetailTypeExport,
    QSWalletDetailTypeSigh,
    QSWalletDetailTypeFingerprint,
    QSWalletDetailTypeChangePwd,
    QSWalletDetailTypeRetrievePwd
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
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<NSArray<id<QSBaseCellItemDataProtocol>> *> *)createMultiSectionDataSource {
    if (self.dataArray.count) {
        [self.dataArray removeAllObjects];
    }
    
    QSWalletContentItem *contentItem = [[QSWalletContentItem alloc] init];
    contentItem.leftTitle = self.evtModel.evtShowName;
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

    //是导入的钱包 拥有修改密码 和找回密码的功能
    QSSettingItem *changePwdItem = [[QSSettingItem alloc] init];
    changePwdItem.leftTitle = QSLocalizedString(@"qs_edit_wallet_item_modify_pwd_title");
    changePwdItem.leftTitleFont = [UIFont qs_fontOfSize16];
    changePwdItem.cellTag = QSWalletDetailTypeChangePwd;
    changePwdItem.cellType = QSSettingItemTypeAccessnory;
    changePwdItem.cellSeapratorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    changePwdItem.cellIdentifier = NSStringFromClass([QSSettingCell class]);
    
    QSSettingItem *retrievePwdItem = [[QSSettingItem alloc] init];
    retrievePwdItem.leftTitle = QSLocalizedString(@"qs_edit_wallet_item_retrieve_pwd_title");
    retrievePwdItem.leftTitleFont = [UIFont qs_fontOfSize16];
    retrievePwdItem.cellTag = QSWalletDetailTypeRetrievePwd;
    retrievePwdItem.cellType = QSSettingItemTypeAccessnory;
    retrievePwdItem.cellSeapratorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    retrievePwdItem.cellIdentifier = NSStringFromClass([QSSettingCell class]);
    
    if (![self.evtModel.privateKey isEqualToString:[[QSWalletHelper sharedHelper] getCurrentIdentityWallet].privateKey]) {
        [self.dataArray addObject:@[changePwdItem,retrievePwdItem,exportItem]];
    } else {
        [self.dataArray addObject:@[exportItem]];
    }
    
    if ([QSTouchIDHelper sharedHelper].isSupportAuthenticationWithBiometrics) {
        QSWallectFingerprintItem *fingerprintItem = [[QSWallectFingerprintItem alloc] init];
        fingerprintItem.cellTag = QSWalletDetailTypeFingerprint;
        fingerprintItem.cellSeapratorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        fingerprintItem.cellIdentifier = NSStringFromClass([QSWalletFingerprintCell class]);
        fingerprintItem.openFingerprint = self.evtModel.isOpenFingerprint;
        __weak __typeof(&*fingerprintItem) weakFingerprintItem = fingerprintItem;
        fingerprintItem.switchValueChangedBlock = ^(BOOL isOn) {
            if (isOn) {
                DLog(@"开启指纹/面容");
                QSOpenFinerprintViewController *openVC = [[QSOpenFinerprintViewController alloc] init];
                openVC.walletPrivateKey = self.evtModel.privateKey;
                openVC.openFinerprintSuccessBlock = ^{
                    [[QSWalletHelper sharedHelper] updateWalletOpenTouchID:YES byPrivateKey:self.evtModel.privateKey];
                    
                    weakFingerprintItem.openFingerprint = YES;
                    [self.tableView reloadData];
                };
                [self.navigationController pushViewController:openVC animated:YES];
            } else {
                NSString *title = QSLocalizedString(@"qs_wallet_detail_stop_fingerprint_title");
                if ([QSTouchIDHelper sharedHelper].biometryType == QSLABiometryTypeFaceID) {
                    title = QSLocalizedString(@"qs_wallet_detail_stop_faceid_title");
                }
                
                [UIViewController showAlertViewWithTitle:title message:nil confirmTitle:QSLocalizedString(@"qs_wallet_detail_stop_fingerprint_confirm") cancelTitle:QSLocalizedString(@"qs_wallet_detail_stop_fingerprint_cancel") confirmAction:^{
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
    id<QSBaseCellItemDataProtocol> item = [self itemInIndexPath:indexPath];
    if (item.cellTag == QSWalletDetailTypeContent) {
        [QSInputAlertView showInputAlertViewWithTitle:QSLocalizedString(@"qs_wallet_detail_change_name_alert_title") placeholder:QSLocalizedString(@"qs_wallet_detail_change_name_alert_placehoder") confirmBlock:^(NSString * _Nonnull text) {
            self.evtModel.evtName = text;
            [[QSWalletHelper sharedHelper] updateWallet:self.evtModel];
            [self reloadTableViewData];
        } cancelBlock:nil];
        
    } else if (item.cellTag == QSWalletDetailTypeExport) {
        WeakSelf(weakSelf);
        [QSPasswordHelper verificationPasswordByPrivateKey:self.evtModel.privateKey
                                           andSuccessBlock:^{
                                               QSExportPrivateKeyViewController *privateKeyVC = [[QSExportPrivateKeyViewController alloc] init];
                                               privateKeyVC.EVTModel = self.evtModel;
                                               [weakSelf.navigationController pushViewController:privateKeyVC animated:YES];
                                           }];
        
    } else if (item.cellTag == QSWalletDetailTypeSigh) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_content_NO")];
        
    } else if (item.cellTag == QSWalletDetailTypeChangePwd) {
        QSModifyPasswordViewController *modifyPwd = [[QSModifyPasswordViewController alloc] initWithWalletPrivateKey:self.evtModel.privateKey];
        [self.navigationController pushViewController:modifyPwd animated:YES];
        
    } else if (item.cellTag == QSWalletDetailTypeRetrievePwd) {
        QSImportWalletIndexViewController *importWallet = [[QSImportWalletIndexViewController alloc] initWithType:QSImportWalletTypeEVT];
        [self.navigationController pushViewController:importWallet animated:YES];
    }
}


@end
