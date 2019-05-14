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

@property (nonatomic, copy) NSString *jinduMoney;
@property (nonatomic, copy) NSString *payeeString;
@property (nonatomic, strong) QSFungibleSymbol *Model;

@end

@implementation QSEveriPayCollectAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_collect_amount_nav_title")];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - kRealValue(30), kRealValue(51))];
    UILabel *titleLabel = [UILabel labelWithName:QSLocalizedString(@"qs_collect_amount_select_payway_tips") font:[UIFont qs_boldFontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    titleLabel.frame = CGRectMake(0, kRealValue(15), headerView.width, kRealValue(16));
    [headerView addSubview:titleLabel];
//    self.tableView.tableHeaderView = headerView;
    
    @weakify(self);
    self.tableView.tableFooterView = [[QSBottomButtonView alloc] initWithFrame:CGRectMake(0, 0, kBottomButtonWidth, kRealValue(100))
                                                                title:QSLocalizedString(@"qs_collect_amount_bottom_btn_title")
                                                                  clickedBlock:^
                                      {
                                          @strongify(self);
                                          [self shoukuanStepTwoWithPayeeStr];
                                      }];
    
    [self ConfirmReceipt];
}

#pragma mark - **************** Private Methods
- (void)ConfirmReceipt {
    WeakSelf(weakSelf);
    [[QSEveriApiWebViewController sharedWebView] getFungibleSymbolDetailWithSymId:self.sybId andCompeleteBlock:^(NSInteger statusCode, QSFungibleSymbol * _Nonnull fungibleSymbol) {
        if (statusCode == kResponseSuccessCode) {
            weakSelf.Model = fungibleSymbol;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            QSEveriPayCollectCurrencyItem *payItem = (QSEveriPayCollectCurrencyItem *)[weakSelf itemInIndexPath:indexPath];
            payItem.FTModel = fungibleSymbol;
            [weakSelf.tableView reloadData];
        }
    }];
}

- (NSString *)handleMoney:(NSString *)money byPrecision:(NSString *)precision {
    NSString *floatString = [NSString stringWithFormat:@"%f",money.floatValue];
    NSRange range = [floatString rangeOfString:@"."];
    NSInteger subStringIndex = range.length + range.location + precision.integerValue;
    NSString *result = [floatString substringToIndex:subStringIndex];
    return result;
}

- (void)shoukuanStepTwoWithPayeeStr {
    if (!self.jinduMoney.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_collect_amount_item_amount_placeholder")];
        return;
    }
    if (!self.payeeString.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_shoukuan_failure2")];
        return;
    }
    WeakSelf(weakSelf);
    [[QSEveriApiWebViewController sharedWebView] pushTransactionWithActionEveriLink:self.link andAsset:self.payeeString andaddress:QSPublicKey andCompeleteBlock:^(NSInteger statusCode) {
        if (statusCode == kResponseSuccessCode) {
            QSEveriPayCollectSuccessViewController *success = [[QSEveriPayCollectSuccessViewController alloc] init];
            success.money = weakSelf.jinduMoney;
            success.Model = weakSelf.Model;
            [weakSelf.navigationController pushViewController:success animated:YES];
        }
    }];
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<NSArray<id<QSBaseCellItemDataProtocol>> *> *)createMultiSectionDataSource {
    QSEveriPayCollectCurrencyItem *currencyItem = [[QSEveriPayCollectCurrencyItem alloc] init];
    currencyItem.cellIdentifier = NSStringFromClass([QSEveriPayCollectCurrencyCell class]);
    currencyItem.cellHeight = kRealValue(70);
    currencyItem.currceny = self.sybId;
    
    WeakSelf(weakSelf);
    QSPayAmountItem *collectAmountItem = [[QSPayAmountItem alloc] init];
    collectAmountItem.cellIdentifier = NSStringFromClass([QSPayAmountInputCell class]);
    collectAmountItem.cellHeight = kRealValue(70);
    collectAmountItem.inputTitle = QSLocalizedString(@"qs_collect_amount_item_amount_title");
    collectAmountItem.inputPlaceholder = QSLocalizedString(@"qs_collect_amount_item_amount_placeholder");
    collectAmountItem.keyType = UIKeyboardTypeDecimalPad;
    collectAmountItem.payAmountItemTextBlock = ^(NSString * _Nonnull text) {
        NSArray *NewArray = [self.Model.sym componentsSeparatedByString:@","];
        if (NewArray.count < 2) {
            return ;
        }
        NSString *jinduStr = NewArray[0];
        NSString *resultMoneyStr = [self handleMoney:text byPrecision:jinduStr];
        NSString *symId = NewArray[1];
        NSString *payeeStr = [NSString stringWithFormat:@" %@",symId];
        weakSelf.payeeString = [NSString stringWithFormat:@"%@%@",resultMoneyStr,payeeStr];
        weakSelf.jinduMoney = resultMoneyStr;
    };
    
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
