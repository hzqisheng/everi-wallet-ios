//
//  QSSystemSettingsViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSSystemSettingsViewController.h"
#import "QSLanguageSettingViewController.h"
#import "QSCurrencySettingsViewController.h"
#import "QSNodeSettingViewController.h"
#import "QSMaxPaymentViewController.h"

#import "QSSettingCell.h"
#import "QSSettingItem.h"

typedef NS_ENUM(NSUInteger, QSSystemSettingsType) {
    QSSystemSettingsTypeLanguage,
    QSSystemSettingsTypeUnit,
    QSSystemSettingsTypeNode,
    QSSystemSettingsTypeMaxFee,
    QSSystemSettingsTypeMaxPayAmount
};

@interface QSSystemSettingsViewController ()

@end

@implementation QSSystemSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_sytem_setting_nav_title")];
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (Class)getRigisterCellClass {
    return [QSSettingCell class];
}

- (NSArray<QSSettingItem *> *)createSingleSectionDataSource {
    QSSettingItem *languageItem = [[QSSettingItem alloc] init];
    languageItem.leftTitle = QSLocalizedString(@"qs_sytem_setting_item_languages_title");
    languageItem.leftTitleFont = [UIFont qs_fontOfSize16];
    languageItem.cellTag = QSSystemSettingsTypeLanguage;
    languageItem.cellType = QSSettingItemTypeAccessnory;
    
    QSSettingItem *unitItem = [[QSSettingItem alloc] init];
    unitItem.leftTitle = QSLocalizedString(@"qs_sytem_setting_item_currency_title");
    unitItem.leftTitleFont = [UIFont qs_fontOfSize16];
    unitItem.cellTag = QSSystemSettingsTypeUnit;
    unitItem.cellType = QSSettingItemTypeAccessnory;

    QSSettingItem *nodeItem = [[QSSettingItem alloc] init];
    nodeItem.leftTitle = QSLocalizedString(@"qs_sytem_setting_item_node_title");
    nodeItem.leftTitleFont = [UIFont qs_fontOfSize16];
    nodeItem.cellTag = QSSystemSettingsTypeNode;
    nodeItem.cellType = QSSettingItemTypeAccessnory;

    QSSettingItem *feeItem = [[QSSettingItem alloc] init];
    feeItem.leftTitle = QSLocalizedString(@"qs_sytem_setting_item_fee_title");
    feeItem.leftTitleFont = [UIFont qs_fontOfSize16];
    feeItem.rightTitle = @"100000 EVT/PEVT";
    feeItem.cellTag = QSSystemSettingsTypeMaxFee;
    feeItem.cellType = QSSettingItemTypeLeftRightTitle;

    QSSettingItem *payAmountItem = [[QSSettingItem alloc] init];
    payAmountItem.leftTitle = QSLocalizedString(@"qs_sytem_setting_item_payment_title");
    payAmountItem.leftTitleFont = [UIFont qs_fontOfSize16];
    payAmountItem.rightTitle = @"100000";
    payAmountItem.cellTag = QSSystemSettingsTypeMaxPayAmount;
    payAmountItem.cellType = QSSettingItemTypeLeftRightTitle;
    
    return @[languageItem,
             nodeItem];
}

#pragma mark - **************** UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSBaseCellItem *item = [self itemInIndexPath:indexPath];
    if (item.cellTag == QSSystemSettingsTypeLanguage) {
        QSLanguageSettingViewController *language = [[QSLanguageSettingViewController alloc] init];
        [self.navigationController pushViewController:language animated:YES];
    } else if (item.cellTag == QSSystemSettingsTypeUnit) {
        QSCurrencySettingsViewController *currency = [[QSCurrencySettingsViewController alloc] init];
        [self.navigationController pushViewController:currency animated:YES];
    } else if (item.cellTag == QSSystemSettingsTypeNode) {
        QSNodeSettingViewController *node = [[QSNodeSettingViewController alloc] init];
        [self.navigationController pushViewController:node animated:YES];
    } else if (item.cellTag == QSSystemSettingsTypeMaxFee) {
        
    } else if (item.cellTag == QSSystemSettingsTypeMaxPayAmount) {
        QSMaxPaymentViewController *maxPayment = [[QSMaxPaymentViewController alloc] init];
        [self.navigationController pushViewController:maxPayment animated:YES];
    }
}

@end
