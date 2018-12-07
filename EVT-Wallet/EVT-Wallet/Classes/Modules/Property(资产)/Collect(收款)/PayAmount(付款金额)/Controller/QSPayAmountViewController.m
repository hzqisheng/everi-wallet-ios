//
//  QSPayAmountViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/6.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSPayAmountViewController.h"
#import "QSPayInfoViewController.h"

#import "QSPayAmountSeletPayWayCell.h"
#import "QSPayAmountBalanceCell.h"
#import "QSPayAmountAddressCell.h"
#import "QSPayAmountInputCell.h"
#import "QSPayAmountItem.h"
#import "QSBottomButtonView.h"
#import "QSSelectCurrencyView.h"

typedef NS_ENUM(NSUInteger, QSPayAmountCellType) {
    QSPayAmountCellTypeSelect,
    QSPayAmountCellTypeBalance,
    QSPayAmountCellTypeAddress,
    QSPayAmountCellTypeAmount,
    QSPayAmountCellTypeRemark
};

@interface QSPayAmountViewController ()

@end

@implementation QSPayAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_pay_amount_nav_title")];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - kRealValue(30), kRealValue(51))];
    UILabel *titleLabel = [UILabel labelWithName:QSLocalizedString(@"qs_pay_amount_select_payway_tips") font:[UIFont qs_boldFontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    titleLabel.frame = CGRectMake(0, kRealValue(24), headerView.width, kRealValue(16));
    [headerView addSubview:titleLabel];
    self.tableView.tableHeaderView = headerView;
    
    @weakify(self);
    self.tableView.tableFooterView = [[QSBottomButtonView alloc] initWithFrame:CGRectMake(0, 0, kBottomButtonWidth, kRealValue(100))
                                                                         title:QSLocalizedString(@"qs_pay_amount_bottom_btn_title")
                                                                  clickedBlock:^
                                      {
                                          @strongify(self);
                                          QSPayInfoViewController *payInfo = [[QSPayInfoViewController alloc] init];
                                          [self.navigationController pushViewController:payInfo animated:YES];
                                      }];
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<Class> *)getRigisterMultiCellClasses {
    return @[[QSPayAmountSeletPayWayCell class],
             [QSPayAmountBalanceCell class],
             [QSPayAmountAddressCell class],
             [QSPayAmountInputCell class]];
}

- (NSArray<NSArray<QSBaseCellItem *> *> *)createMultiSectionDataSource {
    QSPayAmountItem *selectItem = [[QSPayAmountItem alloc] init];
    selectItem.cellIdentifier = NSStringFromClass([QSPayAmountSeletPayWayCell class]);
    selectItem.cellHeight = kRealValue(70);
    selectItem.cellTag = QSPayAmountCellTypeSelect;

    QSPayAmountItem *balanceItem = [[QSPayAmountItem alloc] init];
    balanceItem.cellIdentifier = NSStringFromClass([QSPayAmountBalanceCell class]);
    balanceItem.cellHeight = kRealValue(70);
    balanceItem.balance = @"800.00";
    balanceItem.cellTag = QSPayAmountCellTypeBalance;

    QSPayAmountItem *addressItem = [[QSPayAmountItem alloc] init];
    addressItem.cellIdentifier = NSStringFromClass([QSPayAmountAddressCell class]);
    addressItem.cellHeight = kRealValue(70);
    addressItem.cellTag = QSPayAmountCellTypeAddress;

    QSPayAmountItem *amountItem = [[QSPayAmountItem alloc] init];
    amountItem.cellIdentifier = NSStringFromClass([QSPayAmountInputCell class]);
    amountItem.cellHeight = kRealValue(70);
    amountItem.inputTitle = QSLocalizedString(@"qs_pay_amount_item_amount_title");
    amountItem.inputPlaceholder = QSLocalizedString(@"qs_pay_amount_item_amount_placeholder");
    amountItem.cellTag = QSPayAmountCellTypeAmount;

    QSPayAmountItem *reamrkItem = [[QSPayAmountItem alloc] init];
    reamrkItem.cellIdentifier = NSStringFromClass([QSPayAmountInputCell class]);
    reamrkItem.cellHeight = kRealValue(70);
    reamrkItem.inputTitle = QSLocalizedString(@"qs_pay_amount_item_remarks_title");
    reamrkItem.inputPlaceholder = QSLocalizedString(@"qs_pay_amount_item_remarks_placeholder");
    reamrkItem.cellTag = QSPayAmountCellTypeRemark;
    
    return @[@[selectItem,
               balanceItem],
             @[addressItem,
               amountItem],
             @[reamrkItem]];
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return kRealValue(10);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSBaseCellItem *item = [self itemInIndexPath:indexPath];
    
    if (item.cellTag == QSPayAmountCellTypeSelect) {
        
    } else if (item.cellTag == QSPayAmountCellTypeBalance) {
        
    } else if (item.cellTag == QSPayAmountCellTypeAddress) {
        
    } else if (item.cellTag == QSPayAmountCellTypeAmount) {
        
    } else if (item.cellTag == QSPayAmountCellTypeRemark) {

    }
}

@end
