//
//  QSMineViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/23.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSMineViewController.h"
#import "QSMyWalletViewController.h"
#import "QSManageAddressViewController.h"
#import "QSJoinCommunitiesViewController.h"
#import "QSHelpCenterViewController.h"
#import "QSSystemSettingsViewController.h"
#import "QSAboutusViewController.h"
#import "QSLogoutAlertView.h"

#import "QSSettingCell.h"
#import "QSSettingItem.h"

#import "QSShareHelper.h"

#define kTableViewTopEdgeInset  kRealValue(168)
#define kHeaderViewHeight       kRealValue(195)
#define kHeaderAvatarViewY      kRealValue(58)

typedef NS_ENUM(NSUInteger, QSMineCellTag) {
    QSMineCellTagWallet,
    QSMineCellTagAddress,
    QSMineCellTagCommunities,
    QSMineCellTagHelpCenter,
    QSMineCellTagSettings,
    QSMineCellTagShare,
    QSMineCellTagAboutus
};

@interface QSMineViewController ()

@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UIImageView *headerAvatarView;
@property (nonatomic, strong) UIView *footerLogoutView;

@end

static NSString *reuseIdentifier = @"QSSettingCell";

@implementation QSMineViewController

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
    self.tableView.tableFooterView = self.footerLogoutView;
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<NSArray<id<QSBaseCellItemDataProtocol>> *> *)createMultiSectionDataSource {
    QSSettingItem *itemWallet = [[QSSettingItem alloc] init];
    itemWallet.leftImage = [UIImage imageNamed:@"icon_wode_guanliqianbao"];
    itemWallet.leftTitle = QSLocalizedString(@"qs_me_item_managewallet");
    itemWallet.cellTag = QSMineCellTagWallet;
    
    QSSettingItem *itemAddress = [[QSSettingItem alloc] init];
    itemAddress.leftImage = [UIImage imageNamed:@"icon_wode_dizhiguanli"];
    itemAddress.leftTitle = QSLocalizedString(@"qs_me_item_manageaddress");
    itemAddress.cellTag = QSMineCellTagAddress;
    
    QSSettingItem *itemCommunities = [[QSSettingItem alloc] init];
    itemCommunities.leftImage = [UIImage imageNamed:@"icon_wode_jiarushequn"];
    itemCommunities.leftTitle = QSLocalizedString(@"qs_me_item_joincommunities");
    itemCommunities.cellTag = QSMineCellTagCommunities;

    QSSettingItem *itemHelpCenter = [[QSSettingItem alloc] init];
    itemHelpCenter.leftImage = [UIImage imageNamed:@"icon_wode_bangzhuzhongxin"];
    itemHelpCenter.leftTitle = QSLocalizedString(@"qs_me_item_helpcenter");
    itemHelpCenter.cellTag = QSMineCellTagHelpCenter;

    QSSettingItem *itemSetting = [[QSSettingItem alloc] init];
    itemSetting.leftImage = [UIImage imageNamed:@"icon_wode_xitongshezhi"];
    itemSetting.leftTitle = QSLocalizedString(@"qs_me_item_setting");
    itemSetting.cellTag = QSMineCellTagSettings;

    QSSettingItem *itemShare = [[QSSettingItem alloc] init];
    itemShare.leftImage = [UIImage imageNamed:@"icon_wode_fenxianghaoyou"];
    itemShare.leftTitle = QSLocalizedString(@"qs_me_item_share");
    itemShare.cellTag = QSMineCellTagShare;

    QSSettingItem *itemAboutus = [[QSSettingItem alloc] init];
    itemAboutus.leftImage = [UIImage imageNamed:@"icon_wode_guanyuwomen"];
    itemAboutus.leftTitle = QSLocalizedString(@"qs_me_item_aboutus");
    itemAboutus.cellTag = QSMineCellTagAboutus;
    
    return @[@[itemWallet],
             @[itemCommunities,
               itemHelpCenter,
               itemSetting],
             @[itemShare,
               itemAboutus]];
}

#pragma mark - **************** Event Response
- (void)logoutButtonClicked {
    [QSLogoutAlertView showLogoutAlertViewAndSubmitBlock:^{
        [[QSWalletHelper sharedHelper] logout];
        [[QSWalletHelper sharedHelper] turnToLoginViewController];
    }];
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kRealValue(7);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id<QSBaseCellItemDataProtocol> item = [self itemInIndexPath:indexPath];
    if (item.cellTag == QSMineCellTagWallet) {
        QSMyWalletViewController *wallet = [[QSMyWalletViewController alloc] init];
        wallet.style = UITableViewStyleGrouped;
        wallet.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:wallet animated:YES];
    } else if (item.cellTag == QSMineCellTagAddress) {
        QSManageAddressViewController *manageAdress = [[QSManageAddressViewController alloc] init];
        manageAdress.haveNotBottomBar = YES;
        manageAdress.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:manageAdress animated:YES];
    } else if (item.cellTag == QSMineCellTagCommunities) {
        QSJoinCommunitiesViewController *joinCommunities = [[QSJoinCommunitiesViewController alloc] init];
        joinCommunities.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:joinCommunities animated:YES];
    } else if (item.cellTag == QSMineCellTagHelpCenter) {
        QSHelpCenterViewController *helpCenter = [[QSHelpCenterViewController alloc] init];
        helpCenter.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:helpCenter animated:YES];
    } else if (item.cellTag == QSMineCellTagSettings) {
        QSSystemSettingsViewController *systemSettings = [[QSSystemSettingsViewController alloc] init];
        systemSettings.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:systemSettings animated:YES];
    } else if (item.cellTag == QSMineCellTagShare) {
        [[QSShareHelper sharedHelper] shareURL:kShareUrlString];
    } else if (item.cellTag == QSMineCellTagAboutus) {
        QSAboutusViewController *aboutus = [[QSAboutusViewController alloc] init];
        aboutus.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutus animated:YES];
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

- (UIView *)footerLogoutView {
    if (!_footerLogoutView) {
        _footerLogoutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - kRealValue(30), kRealValue(120))];
        UIButton *logoutButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_me_btn_logout") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(logoutButtonClicked)];
        logoutButton.backgroundColor = [UIColor qs_colorBlack313745];
        logoutButton.layer.cornerRadius = 4;
        logoutButton.frame = CGRectMake(0, _footerLogoutView.height - kRealValue(65), _footerLogoutView.width, kRealValue(40));
        [_footerLogoutView addSubview:logoutButton];
    }
    return _footerLogoutView;
}

@end
