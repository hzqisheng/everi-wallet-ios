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

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<id<QSBaseCellItemDataProtocol>> *)createSingleSectionDataSource {
    QSSettingItem *aboutusItem = [[QSSettingItem alloc] init];
    aboutusItem.cellTag = QSAboutusItemTypeAppIcon;
    aboutusItem.cellIdentifier = NSStringFromClass([QSAboutusIconCell class]);
    aboutusItem.cellHeight = kRealValue(158);
    aboutusItem.cellSeapratorInset = UIEdgeInsetsMake(0, aboutusItem.cellWidth, 0, 0);
    
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

#pragma mark - **************** tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id<QSBaseCellItemDataProtocol> item = [self itemInIndexPath:indexPath];
    if (item.cellTag == QSAboutusItemTypeCheckVersion) {
        [self checkVersionIsShowLatestToast:YES];
    }
}

@end
