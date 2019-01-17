//
//  QSPayInfoViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/6.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSPayInfoViewController.h"
#import "QSTransactionSuccessViewController.h"

#import "QSPayInfoCell.h"
#import "QSPayInfoItem.h"
#import "QSBottomButtonView.h"
#import "QSPayInfoHeaderView.h"

#define kHeaderViewHeight            kRealValue(223) + kStatusBarHeight
#define kTableViewTopEdgeInset       kRealValue(188) + kStatusBarHeight

@interface QSPayInfoViewController ()

@property (nonatomic, strong) UIView *navigationBar;
@property (nonatomic, strong) QSPayInfoHeaderView *headerView;

@end

@implementation QSPayInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    NSArray *totlyList = [self.FTModel.sym componentsSeparatedByString:@","];
    if (totlyList.count >= 2) {
        //精度
        NSString *jinduStr = totlyList[0];
        NSString *countStr = [self handleMoney:self.money byPrecision:jinduStr];

        WeakSelf(weakSelf);
        [[QSEveriApiWebViewController sharedWebView] getEstimatedChargeForTransactionWithAddress:[QSWalletHelper sharedHelper].currentEvt.publicKey andBeneficiary:self.shoukuanAddress andCount:[NSString stringWithFormat:@"%@ %@",countStr,totlyList[1]] andMemo:self.note AndCompeleteBlock:^(NSInteger statusCode, NSString * _Nonnull address) {
            if (statusCode == kResponseSuccessCode) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
                QSPayInfoItem *payItem = (QSPayInfoItem *)[self itemInIndexPath:indexPath];
                payItem.content = address;
                [weakSelf.tableView reloadData];
            }
        }];
    }
    //nav
    [self.view addSubview:self.navigationBar];
    
    //headerview
    self.headerView = [[QSPayInfoHeaderView alloc] init];
    self.FTModel.amount = self.money;
    self.headerView.FTModel = self.FTModel;
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, kHeaderViewHeight);
    [self.view insertSubview:self.headerView atIndex:0];
    
    //tableView
    self.tableView.height = kScreenHeight;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(kTableViewTopEdgeInset, 0, 0, 0);
    @weakify(self);
    self.tableView.tableFooterView = [[QSBottomButtonView alloc] initWithFrame:CGRectMake(0, 0, kBottomButtonWidth, kRealValue(100))
                                                                         title:QSLocalizedString(@"qs_pay_info_btn_confirm_title")
                                                                  clickedBlock:^
                                      {
                                          @strongify(self);
                                          [self turnToTransactionSuccessVC];
                                      }];

}

- (void)turnToTransactionSuccessVC {
    NSArray *totlyList = [self.FTModel.sym componentsSeparatedByString:@","];
    if (totlyList.count >= 2) {
        NSString *jinduStr = totlyList[0];
        NSString *countStr = [self handleMoney:self.money byPrecision:jinduStr];
        WeakSelf(weakSelf);
        [QSAppKeyWindow showIndeterminateHudWithText:QSLocalizedString(@"qs_language_setting_change_toast")];
        [[QSEveriApiWebViewController sharedWebView] pushTransactionFukuanWithAddress:[QSWalletHelper sharedHelper].currentEvt.publicKey andBeneficiary:self.shoukuanAddress andCount:[NSString stringWithFormat:@"%@ %@",countStr,totlyList[1]] andMemo:self.note AndCompeleteBlock:^(NSInteger statusCode, NSString * _Nonnull address) {
            if (statusCode == kResponseSuccessCode) {
                QSTransactionSuccessViewController *success = [[QSTransactionSuccessViewController alloc] init];
                success.FTModel = weakSelf.FTModel;
                success.count = countStr;
                [weakSelf.navigationController pushViewController:success animated:YES];
                [QSAppKeyWindow hideHud];
            }
        }];
    }
}

- (NSString *)handleMoney:(NSString *)money byPrecision:(NSString *)precision {
    NSString *floatString = [NSString stringWithFormat:@"%f",money.floatValue];
    NSRange range = [floatString rangeOfString:@"."];
    NSInteger subStringIndex = range.length + range.location + precision.integerValue;
    NSString *result = [floatString substringToIndex:subStringIndex];
    return result;
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (Class)getRigisterCellClass {
    return [QSPayInfoCell class];
}

- (NSArray<NSArray<QSBaseCellItem *> *> *)createMultiSectionDataSource {
    QSPayInfoItem *payItem = [[QSPayInfoItem alloc] init];
    payItem.cellIdentifier = NSStringFromClass([QSPayInfoCell class]);
    payItem.title = QSLocalizedString(@"qs_pay_info_item_payer_title");
    payItem.content = [QSWalletHelper sharedHelper].currentEvt.publicKey;
    payItem.cellHeight = kRealValue(100);
    
    QSPayInfoItem *receiveItem = [[QSPayInfoItem alloc] init];
    receiveItem.cellIdentifier = NSStringFromClass([QSPayInfoCell class]);
    receiveItem.title = QSLocalizedString(@"qs_pay_info_item_beneficiary_title");
    receiveItem.content = self.shoukuanAddress;
    receiveItem.cellHeight = kRealValue(100);

    QSPayInfoItem *remarkItem = [[QSPayInfoItem alloc] init];
    remarkItem.cellIdentifier = NSStringFromClass([QSPayInfoCell class]);
    remarkItem.title = QSLocalizedString(@"qs_pay_info_item_remark_title");
    remarkItem.content = self.note;
    remarkItem.cellHeight = kRealValue(80);
    
    QSPayInfoItem *feeItem = [[QSPayInfoItem alloc] init];
    feeItem.cellIdentifier = NSStringFromClass([QSPayInfoCell class]);
    feeItem.title = QSLocalizedString(@"qs_pay_info_item_fee_title");
    feeItem.cellHeight = kRealValue(80);
    
    return @[@[payItem],
             @[receiveItem],
             @[remarkItem],
             @[feeItem]];
}

#pragma mark - **************** Event Response
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
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
    
}

#pragma mark - **************** UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y + kTableViewTopEdgeInset;
    self.headerView.centerX = self.view.centerX;
    if (offset >= 0) {
        self.headerView.y = -offset;
        self.headerView.height = kHeaderViewHeight;
    } else {
        self.headerView.y = 0;
        self.headerView.height = kHeaderViewHeight - offset;
    }
}

#pragma mark - **************** Setter Getter
- (UIView *)navigationBar {
    if (!_navigationBar) {
        _navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavgationBarHeight)];
        UIButton *backButton = [UIButton buttonWithImage:@"icon_qianbao_nav_back" taget:self action:@selector(back)];
        backButton.frame = CGRectMake(10, kStatusBarHeight, 44, 44);
        [_navigationBar addSubview:backButton];
        
        UILabel *titleLabel = [UILabel labelWithName:QSLocalizedString(@"qs_pay_info_nav_title") font:[UIFont qs_fontOfSize18] textColor:[UIColor qs_colorWhiteFFFFFF] textAlignment:NSTextAlignmentCenter];
        titleLabel.frame = CGRectMake(100, kStatusBarHeight, kScreenWidth - 200, 44);
        [_navigationBar addSubview:titleLabel];
    }
    return _navigationBar;
}



@end
