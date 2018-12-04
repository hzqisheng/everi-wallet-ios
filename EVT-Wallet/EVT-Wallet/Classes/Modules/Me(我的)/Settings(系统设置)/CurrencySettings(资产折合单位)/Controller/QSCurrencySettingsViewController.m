//
//  QSCurrencySettingsViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCurrencySettingsViewController.h"

#import "QSLanguageSettingCell.h"
#import "QSSettingLanguageItem.h"

typedef NS_ENUM(NSUInteger, QSCurrencySettingsType) {
    QSCurrencySettingsCNY,
    QSCurrencySettingsUSD,
};

@interface QSCurrencySettingsViewController ()

@end

@implementation QSCurrencySettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_currency_setting_nav_title")];
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (Class)getRigisterCellClass {
    return [QSLanguageSettingCell class];
}

- (NSArray<QSSettingItem *> *)createSingleSectionDataSource {
    QSSettingLanguageItem *CNYItem = [[QSSettingLanguageItem alloc] init];
    CNYItem.leftTitle = QSLocalizedString(@"qs_currency_setting_item_cny_title");
    CNYItem.leftTitleFont = [UIFont qs_fontOfSize16];
    CNYItem.cellTag = QSCurrencySettingsCNY;
    CNYItem.cellType = QSSettingItemTypeAccessnory;
    CNYItem.cellIdentifier = NSStringFromClass([QSLanguageSettingCell class]);
    CNYItem.rightSubviewMargin = kRealValue(25);
    CNYItem.checked = YES;
    
    QSSettingLanguageItem *USDItem = [[QSSettingLanguageItem alloc] init];
    USDItem.leftTitle = QSLocalizedString(@"qs_currency_setting_item_usd_title");
    USDItem.leftTitleFont = [UIFont qs_fontOfSize16];
    USDItem.cellTag = QSCurrencySettingsUSD;
    USDItem.cellType = QSSettingItemTypeAccessnory;
    USDItem.cellIdentifier = NSStringFromClass([QSLanguageSettingCell class]);
    USDItem.rightSubviewMargin = kRealValue(25);
    USDItem.checked = NO;
    
    return @[CNYItem,
             USDItem];
}

#pragma mark - **************** UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSBaseCellItem *item = self.dataArray[indexPath.row];
    if (item.cellTag == QSCurrencySettingsCNY) {
       
    } else if (item.cellTag == QSCurrencySettingsUSD) {
        
    }
}

@end
