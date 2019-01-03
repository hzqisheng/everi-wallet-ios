//
//  QSEditWalletsViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/3.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSEditWalletsViewController.h"
#import "QSModifyPasswordViewController.h"
#import "QSImportWalletByMnemonicCodeViewController.h"
#import "QSExportMnemonicViewController.h"
#import "QSAddWalletViewController.h"

#import "QSSettingCell.h"
#import "QSSettingItem.h"

typedef NS_ENUM(NSUInteger, QSEditWalletsType) {
    QSEditWalletsTypeModifyPwd,
    QSEditWalletsTypeRetrievePwd,
    QSEditWalletsTypeExport,
    QSEditWalletsTypeAdd,
};

@interface QSEditWalletsViewController ()

@property (nonatomic, strong) UIButton *logoutButton;

@end

@implementation QSEditWalletsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_edit_wallet_nav_title")];
    [self setupLogoutButton];
}

- (void)setupLogoutButton {
    [self.view addSubview:self.logoutButton];
    CGFloat buttonY = kDevice_Is_iPhoneX ? kScreenHeight - kBottomButtonHeight - kiPhoneXSafeAreaBottomMagin : kScreenHeight - kBottomButtonHeight - kRealValue(15);
    self.logoutButton.frame = CGRectMake(kScreenWidth/2 - kBottomButtonWidth/2, buttonY ,  kBottomButtonWidth, kBottomButtonHeight);
}

#pragma mark - **************** Evenr Response
- (void)logoutButtonClicked {
    
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (Class)getRigisterCellClass {
    return [QSSettingCell class];
}

- (NSArray<NSArray<QSBaseCellItem *> *> *)createMultiSectionDataSource {
    QSSettingItem *modifyPwdItem = [[QSSettingItem alloc] init];
    modifyPwdItem.leftTitle = QSLocalizedString(@"qs_edit_wallet_item_modify_pwd_title");
    modifyPwdItem.leftTitleFont = [UIFont qs_fontOfSize16];
    modifyPwdItem.cellTag = QSEditWalletsTypeModifyPwd;
    modifyPwdItem.cellType = QSSettingItemTypeAccessnory;
    modifyPwdItem.cellSeapratorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    QSSettingItem *retrieveItem = [[QSSettingItem alloc] init];
    retrieveItem.leftTitle = QSLocalizedString(@"qs_edit_wallet_item_retrieve_pwd_title");
    retrieveItem.leftTitleFont = [UIFont qs_fontOfSize16];
    retrieveItem.cellTag = QSEditWalletsTypeRetrievePwd;
    retrieveItem.cellType = QSSettingItemTypeAccessnory;
    retrieveItem.cellSeapratorInset = UIEdgeInsetsMake(0, 0, 0, 0);

    QSSettingItem *exportItem = [[QSSettingItem alloc] init];
    exportItem.leftTitle = QSLocalizedString(@"qs_edit_wallet_item_export_mnemonic_code_title");
    exportItem.leftTitleFont = [UIFont qs_fontOfSize16];
    exportItem.cellTag = QSEditWalletsTypeExport;
    exportItem.cellType = QSSettingItemTypeAccessnory;
    exportItem.cellSeapratorInset = UIEdgeInsetsMake(0, 0, 0, 0);

    QSSettingItem *addItem = [[QSSettingItem alloc] init];
    addItem.leftTitle = QSLocalizedString(@"qs_edit_wallet_item_add_wallet_title");
    addItem.leftTitleFont = [UIFont qs_fontOfSize16];
    addItem.cellTag = QSEditWalletsTypeAdd;
    addItem.cellType = QSSettingItemTypeAccessnory;
    addItem.cellSeapratorInset = UIEdgeInsetsMake(0, 0, 0, 0);

    return @[@[modifyPwdItem,
               retrieveItem,
               exportItem]];
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return kRealValue(10);
    }
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSBaseCellItem *item = [self itemInIndexPath:indexPath];
    if (item.cellTag == QSEditWalletsTypeModifyPwd) {
        QSModifyPasswordViewController *modify = [[QSModifyPasswordViewController alloc] init];
        [self.navigationController pushViewController:modify animated:YES];
    } else if (item.cellTag == QSEditWalletsTypeRetrievePwd) {
        QSImportWalletByMnemonicCodeViewController *importWallet = [[QSImportWalletByMnemonicCodeViewController alloc] init];
        [self.navigationController pushViewController:importWallet animated:YES];
    } else if (item.cellTag == QSEditWalletsTypeExport) {
        QSExportMnemonicViewController *exportMnemonic = [[QSExportMnemonicViewController alloc] init];
        [self.navigationController pushViewController:exportMnemonic animated:YES];
    } else if (item.cellTag == QSEditWalletsTypeAdd) {
        QSAddWalletViewController *addWallet = [[QSAddWalletViewController alloc] init];
        [self.navigationController pushViewController:addWallet animated:YES];
    }
}

#pragma mark - **************** Setter Getter
- (UIButton *)logoutButton {
    if (!_logoutButton) {
        UIButton *logoutButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_me_btn_logout") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(logoutButtonClicked)];
        logoutButton.backgroundColor = [UIColor qs_colorBlack313745];
        logoutButton.layer.cornerRadius = 2;
        _logoutButton = logoutButton;
    }
    return _logoutButton;
}

@end
