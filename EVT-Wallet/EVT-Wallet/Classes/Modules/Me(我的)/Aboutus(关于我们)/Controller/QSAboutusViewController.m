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
- (NSArray<Class> *)getRigisterMultiCellClasses {
    return @[[QSSettingCell class],
             [QSAboutusIconCell class]];
}

- (NSArray<QSSettingItem *> *)createSingleSectionDataSource {
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
    QSBaseCellItem *item = [self itemInIndexPath:indexPath];
    if (item.cellTag == QSAboutusItemTypeCheckVersion) {
        [[QSEveriApiWebViewController sharedWebView] getAPPVersionAndCompeleteBlock:^(NSInteger statusCode, NSString * _Nonnull version, BOOL isForceUpdate) {
            if (statusCode != kResponseSuccessCode) {
                return;
            }
            if ([version isEqualToString:kCurrentVersion]) {
                [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_lastet_version_toast")];
                return;
            }
            NSString *title;
            NSString *confirmTitle;
            NSString *cancelTitle;
            if ([NSBundle isChineseLanguage]) {
                title = [NSString stringWithFormat:@"系统检测到当前的最新版本为%@，是否下载更新",version];
                confirmTitle = @"前往下载";
                cancelTitle = @"取消";
            } else {
                title = [NSString stringWithFormat:@"The latest version is %@ and whether to download the update or not？",version];
                confirmTitle = @"update";
                cancelTitle = @"cancel";
            }
            if (isForceUpdate) {
                [UIViewController showAlertViewWithTitle:title message:nil confirmTitle:confirmTitle confirmAction:^{
                    QSOpenURL(kShareUrlString);
                }];
            } else {
                [UIViewController showAlertViewWithTitle:title message:nil confirmTitle:confirmTitle cancelTitle:cancelTitle confirmAction:^{
                    QSOpenURL(kShareUrlString);
                } cancelAction:nil];
            }
        }];
    }
}

@end
