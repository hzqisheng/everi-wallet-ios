//
//  QSEveriPayAmountViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSEveriPayCollectAmountViewController.h"
#import "QSEveriPayCollectSuccessViewController.h"

#import "QSEveriPayCollectCurrencyCell.h"
#import "QSPayAmountInputCell.h"
#import "QSPayAmountItem.h"
#import "QSEveriPayCollectCurrencyItem.h"
#import "QSBottomButtonView.h"

@interface QSEveriPayCollectAmountViewController ()

@end

@implementation QSEveriPayCollectAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_collect_amount_nav_title")];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - kRealValue(30), kRealValue(51))];
    UILabel *titleLabel = [UILabel labelWithName:QSLocalizedString(@"qs_collect_amount_select_payway_tips") font:[UIFont qs_boldFontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    titleLabel.frame = CGRectMake(0, kRealValue(15), headerView.width, kRealValue(16));
    [headerView addSubview:titleLabel];
    self.tableView.tableHeaderView = headerView;
    
    @weakify(self);
    self.tableView.tableFooterView = [[QSBottomButtonView alloc] initWithFrame:CGRectMake(0, 0, kBottomButtonWidth, kRealValue(100))
                                                                         title:QSLocalizedString(@"qs_collect_amount_bottom_btn_title")
                                                                  clickedBlock:^
                                      {
                                          @strongify(self);
                                          QSEveriPayCollectSuccessViewController *success = [[QSEveriPayCollectSuccessViewController alloc] init];
                                          [self.navigationController pushViewController:success animated:YES];
                                      }];
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<Class> *)getRigisterMultiCellClasses {
    return @[[QSEveriPayCollectCurrencyCell class],
             [QSPayAmountInputCell class]];
}

- (NSArray<NSArray<QSBaseCellItem *> *> *)createMultiSectionDataSource {
    QSEveriPayCollectCurrencyItem *currencyItem = [[QSEveriPayCollectCurrencyItem alloc] init];
    currencyItem.cellIdentifier = NSStringFromClass([QSEveriPayCollectCurrencyCell class]);
    currencyItem.cellHeight = kRealValue(70);
    
    QSPayAmountItem *collectAmountItem = [[QSPayAmountItem alloc] init];
    collectAmountItem.cellIdentifier = NSStringFromClass([QSPayAmountInputCell class]);
    collectAmountItem.cellHeight = kRealValue(70);
    collectAmountItem.inputTitle = QSLocalizedString(@"qs_collect_amount_item_amount_title");
    collectAmountItem.inputPlaceholder = QSLocalizedString(@"qs_collect_amount_item_amount_placeholder");
    
    return @[@[currencyItem],
             @[collectAmountItem]];
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return kRealValue(8);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

@end
