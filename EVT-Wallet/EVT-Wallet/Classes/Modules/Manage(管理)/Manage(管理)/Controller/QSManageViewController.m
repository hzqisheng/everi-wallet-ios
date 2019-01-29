//
//  QSManageViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/23.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSManageViewController.h"
#import "QSMyPassViewController.h"
#import "QSMyGroupViewController.h"
#import "QSSelectFTViewController.h"

#import "QSSettingCell.h"
#import "QSSettingItem.h"

#import "QSShareHelper.h"

#define kTableViewTopEdgeInset  kRealValue(168)
#define kHeaderViewHeight       kRealValue(195)
#define kHeaderAvatarViewY      kRealValue(58)

typedef NS_ENUM(NSUInteger, QSMineCellTag) {
    QSManageCellMassTransfer,
    QSManageCellNFTs,
    QSManageCellGroup,
};

@interface QSManageViewController ()

@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UIImageView *headerAvatarView;

@end

static NSString *reuseIdentifier = @"QSSettingCell";

@implementation QSManageViewController

#pragma mark - **************** Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor qs_colorWhiteF5F7FB];
    [self setupHeaderView];
    [self setupTableView];
}

#pragma mark - **************** Initials
- (void)setupHeaderView {
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, kHeaderViewHeight);
    [self.view insertSubview:self.headerView atIndex:0];
}

- (void)setupTableView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(kTableViewTopEdgeInset, 0, 0, 0);
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (Class)getRigisterCellClass {
    return [QSSettingCell class];
}

- (NSArray<NSArray<QSBaseCellItem *> *> *)createMultiSectionDataSource {
    QSSettingItem *itemMassTransfer = [[QSSettingItem alloc] init];
    itemMassTransfer.leftImage = [UIImage imageNamed:@"icon_guanli_zhuanzhang"];
    itemMassTransfer.leftTitle = QSLocalizedString(@"qs_manage_created_token_title");
    itemMassTransfer.cellTag = QSManageCellMassTransfer;
    
    QSSettingItem *itemNFTs = [[QSSettingItem alloc] init];
    itemNFTs.leftImage = [UIImage imageNamed:@"icon_guanli_yu"];
    itemNFTs.leftTitle = QSLocalizedString(@"qs_manage_created_domain_title");
    itemNFTs.cellTag = QSManageCellNFTs;
    itemNFTs.cellType = QSSettingItemTypeImageAndLeftRightTitle;
    
    
    return @[@[itemMassTransfer],
             @[itemNFTs]];
}

#pragma mark - **************** Event Response
- (void)logoutButtonClicked {
    
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kRealValue(7);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSBaseCellItem *item = [self itemInIndexPath:indexPath];
    if (item.cellTag == QSManageCellMassTransfer) {
        QSSelectFTViewController *selectFT = [[QSSelectFTViewController alloc] init];
        selectFT.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:selectFT animated:YES];
    } else if (item.cellTag == QSManageCellNFTs) {
        QSMyPassViewController *myPassVC = [[QSMyPassViewController alloc] init];
        myPassVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myPassVC animated:YES];
    }
}

#pragma mark - **************** UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y + kTableViewTopEdgeInset;
    self.headerView.centerX = self.view.centerX;
    if (offset >= 0) {
        self.headerView.y = -offset;
        self.headerView.height = kHeaderViewHeight;
        self.headerAvatarView.y = kHeaderAvatarViewY;
    } else {
        self.headerView.y = 0;
        self.headerView.height = kHeaderViewHeight - offset;
        self.headerAvatarView.y = self.headerView.height - self.headerAvatarView.height - kRealValue(52);
    }
}

#pragma mark - **************** Setter Getter
- (UIImageView *)headerView {
    if (!_headerView) {
        _headerView = [[UIImageView alloc] init];
        _headerView.image = [UIImage imageNamed:@"img_wode"];
        _headerView.contentMode = UIViewContentModeScaleAspectFill;
        UIImageView *headerImageView = [[UIImageView alloc] init];
        headerImageView.frame = CGRectMake(kRealValue(88), kRealValue(70), kRealValue(198), kRealValue(53));
        headerImageView.image = [UIImage imageNamed:@"icon_guanli_logo"];
        [_headerView addSubview:headerImageView];
    }
    return _headerView;
}

@end
