//
//  QSPayAmountViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/6.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSPayAmountViewController.h"
#import "QSPayInfoViewController.h"
#import "QSScanningViewController.h"
#import "QSIssueSelectAddressViewController.h"

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

@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *note;

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
                                          if (!self.money.length) {
                                              [QSAppWindow showAutoHideHudWithText:QSLocalizedString(@"qs_pay_amount_item_amount_placeholder")];
                                              return;
                                          }
                                          
                                          QSPayInfoViewController *payInfo = [[QSPayInfoViewController alloc] init];
                                          payInfo.FTModel = self.FTModel;
                                          payInfo.money = self.money;
                                          payInfo.note = self.note;
                                          payInfo.shoukuanAddress = self.address;
                                          [self.navigationController pushViewController:payInfo animated:YES];
                                      }];
}

#pragma mark - **************** Private Methods
- (void)getFTList {
    WeakSelf(weakSelf);
    [[QSEveriApiWebViewController sharedWebView] getEVTFungibleBalanceListWithPublicKey:QSPublicKey andCompeleteBlock:^(NSInteger statusCode, NSArray * _Nonnull ftList) {
        if (statusCode == kResponseSuccessCode) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            QSPayAmountItem *payItem = (QSPayAmountItem *)[weakSelf itemInIndexPath:indexPath];
            if (ftList.count == 0) {
                return ;
            }
            QSFT *model = ftList[0];
            payItem.FTModel = model;
            NSIndexPath *balanceIndex = [NSIndexPath indexPathForRow:1 inSection:0];
            QSPayAmountItem *BalanceItem = (QSPayAmountItem *)[weakSelf itemInIndexPath:balanceIndex];
            NSArray *assetList = [model.asset componentsSeparatedByString:@" "];
            if (assetList.count == 2) {
                BalanceItem.balance = assetList[0];
            }
            weakSelf.FTModel = model;
            [weakSelf.tableView reloadData];
        }
    }];
}

- (void)showSelectCurrencyViewWithArray:(NSArray *)array {
    WeakSelf(weakSelf);
    NSInteger isCreate = 0;
    for (UIView *v in QSAppKeyWindow.subviews){
        if ([v isKindOfClass:[QSSelectCurrencyView class]]) {
            isCreate = 1;
        }
    }
    if (isCreate == 1) {
        return;
    }
    [QSSelectCurrencyView showSelectCurrencyViewWithFTList:array andSelectFTBlock:^(QSFT * _Nonnull FTModel) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        QSPayAmountItem *selectedItem = (QSPayAmountItem *)[weakSelf itemInIndexPath:index];
        selectedItem.FTModel = FTModel;
        weakSelf.FTModel = FTModel;
        NSIndexPath *balanceIndex = [NSIndexPath indexPathForRow:1 inSection:0];
        QSPayAmountItem *BalanceItem = (QSPayAmountItem *)[weakSelf itemInIndexPath:balanceIndex];
        NSArray *assetList = [FTModel.asset componentsSeparatedByString:@" "];
        if (assetList.count == 2) {
            BalanceItem.balance = assetList[0];
        }
        [weakSelf.tableView reloadData];
    }];
}

- (void)turnToScanVC {
    WeakSelf(weakSelf);
    QSScanningViewController *scanVC = [[QSScanningViewController alloc] init];
    scanVC.scanningViewControllerScanAddressBlock = ^(NSString *address) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        QSPayAmountItem *addressItem = (QSPayAmountItem *)[weakSelf itemInIndexPath:indexPath];
        addressItem.address = address;
        weakSelf.address = address;
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:scanVC animated:YES];
}

- (void)turnToSelectAddressVC {
    WeakSelf(weakSelf);
    QSIssueSelectAddressViewController *selectVC = [[QSIssueSelectAddressViewController alloc] init];
    selectVC.issueSelectAddressViewControllerChooseAddressBlock = ^(NSString * _Nonnull address) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        QSPayAmountItem *addressItem = (QSPayAmountItem *)[weakSelf itemInIndexPath:indexPath];
        addressItem.address = address;
        weakSelf.address = address;
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:selectVC animated:YES];
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
    selectItem.FTModel = self.FTModel;

    QSPayAmountItem *balanceItem = [[QSPayAmountItem alloc] init];
    balanceItem.cellIdentifier = NSStringFromClass([QSPayAmountBalanceCell class]);
    balanceItem.cellHeight = kRealValue(70);
    balanceItem.cellTag = QSPayAmountCellTypeBalance;
    if (self.FTModel.creator.length) {
        NSArray *assetList = [self.FTModel.asset componentsSeparatedByString:@" "];
        if (assetList.count == 2) {
            balanceItem.balance = assetList[0];
        }
    } else {
        [self getFTList];
    }

    QSPayAmountItem *addressItem = [[QSPayAmountItem alloc] init];
    addressItem.cellIdentifier = NSStringFromClass([QSPayAmountAddressCell class]);
    addressItem.cellHeight = kRealValue(70);
    addressItem.cellTag = QSPayAmountCellTypeAddress;
    addressItem.address = self.address;
    WeakSelf(weakSelf);
    addressItem.payAmountItemSelectAddressBlock = ^{
        [weakSelf turnToSelectAddressVC];
    };
    addressItem.payAmountItemSweepBlock = ^{
        [weakSelf turnToScanVC];
    };

    QSPayAmountItem *amountItem = [[QSPayAmountItem alloc] init];
    amountItem.cellIdentifier = NSStringFromClass([QSPayAmountInputCell class]);
    amountItem.cellHeight = kRealValue(70);
    amountItem.inputTitle = QSLocalizedString(@"qs_pay_amount_item_amount_title");
    amountItem.inputPlaceholder = QSLocalizedString(@"qs_pay_amount_item_amount_placeholder");
    amountItem.cellTag = QSPayAmountCellTypeAmount;
    amountItem.keyType = UIKeyboardTypeDecimalPad;
    amountItem.payAmountItemTextBlock = ^(NSString * _Nonnull text) {
        weakSelf.money = text;
    };

    QSPayAmountItem *reamrkItem = [[QSPayAmountItem alloc] init];
    reamrkItem.cellIdentifier = NSStringFromClass([QSPayAmountInputCell class]);
    reamrkItem.cellHeight = kRealValue(70);
    reamrkItem.inputTitle = QSLocalizedString(@"qs_pay_amount_item_remarks_title");
    reamrkItem.inputPlaceholder = QSLocalizedString(@"qs_pay_amount_item_remarks_placeholder");
    reamrkItem.cellTag = QSPayAmountCellTypeRemark;
    reamrkItem.payAmountItemTextBlock = ^(NSString * _Nonnull text) {
        weakSelf.note = text;
    };
    
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
        WeakSelf(weakSelf);
        [[QSEveriApiWebViewController sharedWebView] getEVTFungibleBalanceListWithPublicKey:QSPublicKey andCompeleteBlock:^(NSInteger statusCode, NSArray * _Nonnull ftList) {
            if (statusCode == kResponseSuccessCode) {
                [weakSelf showSelectCurrencyViewWithArray:ftList];
            }
        }];
    } else if (item.cellTag == QSPayAmountCellTypeBalance) {
        
    } else if (item.cellTag == QSPayAmountCellTypeAddress) {
        
    } else if (item.cellTag == QSPayAmountCellTypeAmount) {
        
    } else if (item.cellTag == QSPayAmountCellTypeRemark) {

    }
}

- (void)setAddress:(NSString *)address {
    _address = address;
}

@end
