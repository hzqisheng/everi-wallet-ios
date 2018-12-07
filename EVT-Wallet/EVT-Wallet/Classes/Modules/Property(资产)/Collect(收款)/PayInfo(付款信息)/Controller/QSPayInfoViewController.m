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
    
    //nav
    [self.view addSubview:self.navigationBar];
    
    //headerview
    self.headerView = [[QSPayInfoHeaderView alloc] init];
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, kHeaderViewHeight);
    [self.view insertSubview:self.headerView atIndex:0];
    
    //tableView
    self.tableView.height = kScreenHeight;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(kTableViewTopEdgeInset, 0, 0, 0);
    @weakify(self);
    self.tableView.tableFooterView = [[QSBottomButtonView alloc] initWithFrame:CGRectMake(0, 0, kBottomButtonWidth, kRealValue(100))
                                                                         title:QSLocalizedString(@"qs_pay_info_btn_confirm_title")
                                                                  clickedBlock:^
                                      {
                                          @strongify(self);
                                          QSTransactionSuccessViewController *success = [[QSTransactionSuccessViewController alloc] init];
                                          [self.navigationController pushViewController:success animated:YES];
                                      }];

}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (Class)getRigisterCellClass {
    return [QSPayInfoCell class];
}

- (NSArray<NSArray<QSBaseCellItem *> *> *)createMultiSectionDataSource {
    QSPayInfoItem *payItem = [[QSPayInfoItem alloc] init];
    payItem.cellIdentifier = NSStringFromClass([QSPayInfoCell class]);
    payItem.title = QSLocalizedString(@"qs_pay_info_item_payer_title");
    payItem.content = @"EVT824300sdi997JJH4300sdi99784jjd";
    payItem.cellHeight = kRealValue(70);
    
    QSPayInfoItem *receiveItem = [[QSPayInfoItem alloc] init];
    receiveItem.cellIdentifier = NSStringFromClass([QSPayInfoCell class]);
    receiveItem.title = QSLocalizedString(@"qs_pay_info_item_beneficiary_title");
    receiveItem.content = @"EVT824300sdi997JJH4300sdi99784jjd";
    receiveItem.cellHeight = kRealValue(70);

    QSPayInfoItem *remarkItem = [[QSPayInfoItem alloc] init];
    remarkItem.cellIdentifier = NSStringFromClass([QSPayInfoCell class]);
    remarkItem.title = QSLocalizedString(@"qs_pay_info_item_remark_title");
    remarkItem.content = QSLocalizedString(@"qs_pay_info_item_no_remark_title");;
    remarkItem.cellHeight = kRealValue(70);
    
    QSPayInfoItem *feeItem = [[QSPayInfoItem alloc] init];
    feeItem.cellIdentifier = NSStringFromClass([QSPayInfoCell class]);
    feeItem.title = QSLocalizedString(@"qs_pay_info_item_fee_title");
    feeItem.content = @"EVT824300sdi997JJH4300sdi99784jjd";
    feeItem.cellHeight = kRealValue(70);
    
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
