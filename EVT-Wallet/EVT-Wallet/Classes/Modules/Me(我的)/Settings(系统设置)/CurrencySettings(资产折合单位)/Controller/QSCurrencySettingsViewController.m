//
//  QSCurrencySettingsViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCurrencySettingsViewController.h"
#import "NSBundle+QSLanguageUtils.h"

#import "QSLanguageSettingCell.h"
#import "QSSettingLanguageItem.h"

#define kSelectCurrency @"kSelectCurrency"

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
    NSString *selectedCurrency = [QSUserDefaults objectForKey:kSelectCurrency];
    
    QSSettingLanguageItem *CNYItem = [[QSSettingLanguageItem alloc] init];
    CNYItem.leftTitle = QSLocalizedString(@"qs_currency_setting_item_cny_title");
    CNYItem.leftTitleFont = [UIFont qs_fontOfSize16];
    CNYItem.cellTag = QSCurrencySettingsCNY;
    CNYItem.cellType = QSSettingItemTypeAccessnory;
    CNYItem.cellIdentifier = NSStringFromClass([QSLanguageSettingCell class]);
    CNYItem.rightSubviewMargin = kRealValue(25);
    if (selectedCurrency) {
        if ([CNYItem.leftTitle isEqualToString:selectedCurrency]) {
            CNYItem.checked = YES;
        }
    } else {
        CNYItem.checked = [NSBundle isChineseLanguage];
    }
    
    QSSettingLanguageItem *USDItem = [[QSSettingLanguageItem alloc] init];
    USDItem.leftTitle = QSLocalizedString(@"qs_currency_setting_item_usd_title");
    USDItem.leftTitleFont = [UIFont qs_fontOfSize16];
    USDItem.cellTag = QSCurrencySettingsUSD;
    USDItem.cellType = QSSettingItemTypeAccessnory;
    USDItem.cellIdentifier = NSStringFromClass([QSLanguageSettingCell class]);
    USDItem.rightSubviewMargin = kRealValue(25);
    if (selectedCurrency) {
        if ([USDItem.leftTitle isEqualToString:selectedCurrency]) {
            USDItem.checked = YES;
        }
    } else {
        USDItem.checked = ![NSBundle isChineseLanguage];
    }
    
    if ([NSBundle isChineseLanguage]) {
        return @[CNYItem,
                 USDItem];
    }
    return @[USDItem,
             CNYItem];
}

#pragma mark - **************** UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (QSSettingLanguageItem *item in self.dataArray) {
        item.checked = NO;
    }
    QSSettingLanguageItem *item = self.dataArray[indexPath.row];
    item.checked = YES;
    [self.tableView reloadData];
    [QSUserDefaults setObject:item.leftTitle forKey:kSelectCurrency];
}

@end
