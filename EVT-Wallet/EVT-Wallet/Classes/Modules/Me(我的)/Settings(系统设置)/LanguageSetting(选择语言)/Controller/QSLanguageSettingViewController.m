//
//  QSLanguageSettingViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSLanguageSettingViewController.h"
#import "QSMainViewController.h"

#import "QSLanguageSettingCell.h"
#import "QSSettingLanguageItem.h"

typedef NS_ENUM(NSUInteger, QSLanguageSettingType) {
    QSLanguageSettingTypeEnglish,
    QSLanguageSettingTypeChinese,
};

@implementation QSLanguageSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_sytem_setting_nav_title")];
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<id<QSBaseCellItemDataProtocol>> *)createSingleSectionDataSource {
    QSSettingLanguageItem *englishItem = [[QSSettingLanguageItem alloc] init];
    englishItem.leftTitle = QSLocalizedString(@"qs_language_setting_item_english_title");
    englishItem.leftTitleFont = [UIFont qs_fontOfSize16];
    englishItem.cellTag = QSLanguageSettingTypeEnglish;
    englishItem.cellType = QSSettingItemTypeAccessnory;
    englishItem.cellIdentifier = NSStringFromClass([QSLanguageSettingCell class]);
    englishItem.rightSubviewMargin = kRealValue(25);
    englishItem.checked = ![NSBundle isChineseLanguage];
    
    QSSettingLanguageItem *chineseItem = [[QSSettingLanguageItem alloc] init];
    chineseItem.leftTitle = QSLocalizedString(@"qs_language_setting_item_chinses_title");
    chineseItem.leftTitleFont = [UIFont qs_fontOfSize16];
    chineseItem.cellTag = QSLanguageSettingTypeChinese;
    chineseItem.cellType = QSSettingItemTypeAccessnory;
    chineseItem.cellIdentifier = NSStringFromClass([QSLanguageSettingCell class]);
    chineseItem.rightSubviewMargin = kRealValue(25);
    chineseItem.checked = [NSBundle isChineseLanguage];
    
    return @[englishItem,
             chineseItem];
}

#pragma mark - **************** UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSSettingLanguageItem *item = (QSSettingLanguageItem *)[self itemInIndexPath:indexPath];
    if (item.cellTag == QSLanguageSettingTypeEnglish) {
        if (![NSBundle isChineseLanguage]) {
            return;
        }
        [QSAppKeyWindow showIndeterminateHudWithText:QSLocalizedString(@"qs_language_setting_change_toast")];
        [QSLanguageConfigHelper setSystemLanguageEnglish];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [QSAppKeyWindow hideHud];
            QSMainViewController *mainTab = [[QSMainViewController alloc] init];
            QSAppKeyWindow.rootViewController = mainTab;
            CATransition * transition = [[CATransition alloc] init];
            transition.type = @"reveal";
            transition.duration = 0.3;
            [QSAppKeyWindow.layer addAnimation:transition forKey:nil];
            [QSAppWindow insertSubview:[QSEveriApiWebViewController sharedWebView].view atIndex:0];
        });
    } else if (item.cellTag == QSLanguageSettingTypeChinese) {
        if ([NSBundle isChineseLanguage]) {
            return;
        }
        [QSAppKeyWindow showIndeterminateHudWithText:QSLocalizedString(@"qs_language_setting_change_toast")];
        [QSLanguageConfigHelper setSystemLanguageChinese];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [QSAppKeyWindow hideHud];
            QSMainViewController *mainTab = [[QSMainViewController alloc] init];
            QSAppKeyWindow.rootViewController = mainTab;
            CATransition * transition = [[CATransition alloc] init];
            transition.type = @"reveal";
            transition.duration = 0.3;
            [QSAppKeyWindow.layer addAnimation:transition forKey:nil];
            [QSAppWindow insertSubview:[QSEveriApiWebViewController sharedWebView].view atIndex:0];
        });
    }
}

@end
