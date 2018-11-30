//
//  QSNodeSettingViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSNodeSettingViewController.h"


typedef NS_ENUM(NSUInteger, QSNodeSettingType) {
    QSNodeSettingTypeEveriToken,
    QSNodeSettingTypeETH,
    QSNodeSettingTypeEOS,
};

@interface QSNodeSettingViewController ()

@end

@implementation QSNodeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_node_setting_nav_title")];
}

- (NSArray<QSSettingItem *> *)createSingleSectionDataSource {
    QSSettingItem *everiTokenItem = [[QSSettingItem alloc] init];
    everiTokenItem.leftTitle = QSLocalizedString(@"qs_node_setting_item_everitoken_title");
    everiTokenItem.leftTitleFont = [UIFont qs_fontOfSize16];
    everiTokenItem.leftTitleLabelSize = CGSizeMake(kRealValue(100), everiTokenItem.leftTitleLabelSize.height);
    everiTokenItem.cellTag = QSNodeSettingTypeEveriToken;
    everiTokenItem.cellType = QSSettingItemTypeLeftRightTitle;
    everiTokenItem.cellIdentifier = NSStringFromClass([QSSettingCell class]);
    everiTokenItem.rightTitle = @"https://www.aaa.aaa.aaaa.aaaaa..aaa.a.a";
    everiTokenItem.rightSubviewMargin = kRealValue(18);

    QSSettingItem *ETHItem = [[QSSettingItem alloc] init];
    ETHItem.leftTitle = QSLocalizedString(@"qs_node_setting_item_eth_title");
    ETHItem.leftTitleFont = [UIFont qs_fontOfSize16];
    ETHItem.leftTitleLabelSize = CGSizeMake(kRealValue(100), ETHItem.leftTitleLabelSize.height);
    ETHItem.cellTag = QSNodeSettingTypeETH;
    ETHItem.cellType = QSSettingItemTypeLeftRightTitle;
    ETHItem.cellIdentifier = NSStringFromClass([QSSettingCell class]);
    ETHItem.rightTitle = @"https://www.aaa.aaa.aaaa.aaaaa..aaa.a.a";
    ETHItem.rightSubviewMargin = kRealValue(18);
    
    QSSettingItem *USDItem = [[QSSettingItem alloc] init];
    USDItem.leftTitle = QSLocalizedString(@"qs_node_setting_item_eos_title");
    USDItem.leftTitleFont = [UIFont qs_fontOfSize16];
    USDItem.leftTitleLabelSize = CGSizeMake(kRealValue(100), USDItem.leftTitleLabelSize.height);
    USDItem.cellTag = QSNodeSettingTypeEOS;
    USDItem.cellType = QSSettingItemTypeLeftRightTitle;
    USDItem.cellIdentifier = NSStringFromClass([QSSettingCell class]);
    USDItem.rightTitle = @"https://www.aaa.aaa.aaaa.aaaaa..aaa.a.a";
    USDItem.rightSubviewMargin = kRealValue(18);
    
    return @[everiTokenItem,
             ETHItem,
             USDItem];
}

#pragma mark - **************** UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSSettingItem *item = self.dataArray[indexPath.row];
    if (item.cellTag == QSNodeSettingTypeEveriToken) {
        
    } else if (item.cellTag == QSNodeSettingTypeETH) {
        
    } else if (item.cellTag == QSNodeSettingTypeEOS) {
        
    }
}

@end
