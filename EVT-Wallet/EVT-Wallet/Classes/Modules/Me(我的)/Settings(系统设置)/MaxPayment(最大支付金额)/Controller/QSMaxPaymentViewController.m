//
//  QSMaxPaymentViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSMaxPaymentViewController.h"

typedef NS_ENUM(NSUInteger, QSMaxPaymentType) {
    QSMaxPaymentTypeEVT,
    QSMaxPaymentTypeETH,
    QSMaxPaymentTypeEOS,
};

@interface QSMaxPaymentViewController ()

@end

@implementation QSMaxPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_sytem_setting_nav_title")];
}

- (NSArray<QSSettingItem *> *)createSingleSectionDataSource {
    QSSettingItem *EVTItem = [[QSSettingItem alloc] init];
    EVTItem.leftTitle = @"EVT";
    EVTItem.leftTitleFont = [UIFont qs_fontOfSize16];
    EVTItem.leftTitleLabelSize = CGSizeMake(kRealValue(50), EVTItem.leftTitleLabelSize.height);
    EVTItem.cellTag = QSMaxPaymentTypeEVT;
    EVTItem.cellType = QSSettingItemTypeLeftRightTitle;
    EVTItem.cellIdentifier = NSStringFromClass([QSSettingCell class]);
    EVTItem.rightTitle = @"https://www.aaa.aaa.aaaa.aaaaa..aaa.a.a";
    
    QSSettingItem *ETHItem = [[QSSettingItem alloc] init];
    ETHItem.leftTitle = @"ETH";
    ETHItem.leftTitleFont = [UIFont qs_fontOfSize16];
    ETHItem.leftTitleLabelSize = CGSizeMake(kRealValue(50), ETHItem.leftTitleLabelSize.height);
    ETHItem.cellTag = QSMaxPaymentTypeETH;
    ETHItem.cellType = QSSettingItemTypeLeftRightTitle;
    ETHItem.cellIdentifier = NSStringFromClass([QSSettingCell class]);
    ETHItem.rightTitle = @"https://www.aaa.aaa.aaaa.aaaaa..aaa.a.a";
    
    QSSettingItem *EODItem = [[QSSettingItem alloc] init];
    EODItem.leftTitle = @"EOS";
    EODItem.leftTitleFont = [UIFont qs_fontOfSize16];
    EODItem.leftTitleLabelSize = CGSizeMake(kRealValue(50), EODItem.leftTitleLabelSize.height);
    EODItem.cellTag = QSMaxPaymentTypeEOS;
    EODItem.cellType = QSSettingItemTypeLeftRightTitle;
    EODItem.cellIdentifier = NSStringFromClass([QSSettingCell class]);
    EODItem.rightTitle = @"https://www.aaa.aaa.aaaa.aaaaa..aaa.a.a";

    return @[EVTItem, ETHItem, EODItem];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSSettingItem *item = [self itemInIndexPath:indexPath];
    DLog(@"%ld",(long)item.cellTag);
    if (item.cellTag == QSMaxPaymentTypeEVT) {
        
    } else if (item.cellTag == QSMaxPaymentTypeETH) {
        
    } else if (item.cellTag == QSMaxPaymentTypeEOS) {
        
    }
}

@end
