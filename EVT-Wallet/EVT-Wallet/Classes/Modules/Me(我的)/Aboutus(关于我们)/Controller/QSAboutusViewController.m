//
//  QSAboutusViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSAboutusViewController.h"
#import "QSAboutusIconCell.h"

typedef NS_ENUM(NSUInteger, QSAboutusItemType) {
    QSAboutusItemTypeAppIcon,
    QSAboutusItemTypeCurrentVersion,
    QSAboutusItemTypeCheckVersion,
};

@interface QSAboutusViewController ()

@end

@implementation QSAboutusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_aboutus_nav_title")];
}

- (NSArray<Class> *)getRigisterMultiCellClasses {
    return @[[QSSettingCell class],
             [QSAboutusIconCell class]];
}

- (NSArray<QSSettingItem *> *)createSingleSectionDataSource {
    QSSettingItem *aboutusItem = [[QSSettingItem alloc] init];
    aboutusItem.cellTag = QSAboutusItemTypeAppIcon;
    aboutusItem.cellIdentifier = NSStringFromClass([QSAboutusIconCell class]);
    aboutusItem.cellHeight = kRealValue(158);
    
    QSSettingItem *currentVersionItem = [[QSSettingItem alloc] init];
    currentVersionItem.leftTitle = QSLocalizedString(@"qs_aboutus_item_current_version_title");
    currentVersionItem.leftTitleFont = [UIFont qs_fontOfSize15];
    currentVersionItem.cellTag = QSAboutusItemTypeCurrentVersion;
    currentVersionItem.cellType = QSSettingItemTypeLeftRightTitle;
    currentVersionItem.cellIdentifier = NSStringFromClass([QSSettingCell class]);
    currentVersionItem.rightTitle = kCurrentVersion;
    currentVersionItem.cellHeight = kRealValue(43);

    QSSettingItem *checkVersionItem = [[QSSettingItem alloc] init];
    checkVersionItem.leftTitle = QSLocalizedString(@"qs_aboutus_item_check_version_title");
    checkVersionItem.leftTitleFont = [UIFont qs_fontOfSize16];
    checkVersionItem.cellTag = QSAboutusItemTypeCheckVersion;
    checkVersionItem.cellType = QSSettingItemTypeAccessnory;
    checkVersionItem.cellIdentifier = NSStringFromClass([QSSettingCell class]);
    checkVersionItem.cellHeight = kRealValue(43);
    checkVersionItem.rightSubviewMargin = kRealValue(10);

    return @[aboutusItem,
             currentVersionItem,
             checkVersionItem];
}

#pragma mark - **************** tableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    QSSettingItem *item = [self itemInIndexPath:indexPath];
    if (item.cellTag == QSAboutusItemTypeAppIcon) {
        cell.separatorInset = UIEdgeInsetsMake(0, item.cellWidth, 0, 0);
    } else {
        cell.separatorInset = UIEdgeInsetsMake(0, item.leftSubviewMargin, 0, 0);
    }
    return cell;
}

#pragma mark - **************** tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSSettingItem *item = [self itemInIndexPath:indexPath];
    if (item.cellTag == QSAboutusItemTypeCheckVersion) {
        DLog(@"checkVersion");
    }
}

@end
