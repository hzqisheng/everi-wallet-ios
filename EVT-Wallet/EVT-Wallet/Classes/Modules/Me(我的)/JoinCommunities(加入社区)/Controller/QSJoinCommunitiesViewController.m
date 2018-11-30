//
//  QSJoinCommunitiesViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/29.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSJoinCommunitiesViewController.h"
#import "QSSettingCell.h"
#import "QSSettingItem.h"

typedef NS_ENUM(NSUInteger, QSJoinCommunitiesCellTag) {
    QSJoinCommunitiesCellTagFacebook,
    QSJoinCommunitiesCellTagTwitter,
    QSJoinCommunitiesCellTagTelegram,
    QSJoinCommunitiesCellTagWeChat,
};

@interface QSJoinCommunitiesViewController ()

@end

static NSString *reuseIdentifier = @"QSSettingCell";

@implementation QSJoinCommunitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_join_communities_nav_title")];
    [self setupTableView];
    [self createDataSource];
}

- (void)setupTableView {
    self.tableView.frame = CGRectMake(kRealValue(15), 0, kScreenWidth - kRealValue(30), kScreenHeight - kNavgationBarHeight);
    self.tableView.contentInset = UIEdgeInsetsMake(kRealValue(15), 0, 0, 0);
    [self.tableView registerClass:[QSSettingCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)createDataSource {
    QSSettingItem *facebookItem = [[QSSettingItem alloc] init];
    facebookItem.cellType = QSSettingItemTypeImageAndLeftRightTitle;
    facebookItem.leftImage = [UIImage imageNamed:@"icon_jiarushequn_facebook"];
    facebookItem.leftTitle = @"Facebook";
    facebookItem.leftImageSize = CGSizeMake(kRealValue(33), kRealValue(33));
    facebookItem.cellTag = QSJoinCommunitiesCellTagFacebook;
    facebookItem.rightTitle = @"@everiToken";
    facebookItem.cellHeight = kRealValue(55);
    
    QSSettingItem *twitterItem = [[QSSettingItem alloc] init];
    twitterItem.cellType = QSSettingItemTypeImageAndLeftRightTitle;
    twitterItem.leftImage = [UIImage imageNamed:@"icon_jiarushequn_twitter"];
    twitterItem.leftTitle = @"Twitter";
    twitterItem.leftImageSize = CGSizeMake(kRealValue(33), kRealValue(33));
    twitterItem.cellTag = QSJoinCommunitiesCellTagTwitter;
    twitterItem.rightTitle = @"@everiToken";
    twitterItem.cellHeight = kRealValue(55);

    QSSettingItem *telegramItem = [[QSSettingItem alloc] init];
    telegramItem.cellType = QSSettingItemTypeImageAndLeftRightTitle;
    telegramItem.leftImage = [UIImage imageNamed:@"icon_jiarushequn_telegram"];
    telegramItem.leftTitle = @"Telegram";
    telegramItem.leftImageSize = CGSizeMake(kRealValue(33), kRealValue(33));
    telegramItem.cellTag = QSJoinCommunitiesCellTagTelegram;
    telegramItem.rightTitle = @"@everiToken";
    telegramItem.cellHeight = kRealValue(55);

    QSSettingItem *weChatItem = [[QSSettingItem alloc] init];
    weChatItem.cellType = QSSettingItemTypeImageAndLeftRightTitle;
    weChatItem.leftImage = [UIImage imageNamed:@"icon_jiarushequn_wechat"];
    weChatItem.leftTitle = @"WeChat";
    weChatItem.leftImageSize = CGSizeMake(kRealValue(33), kRealValue(33));
    weChatItem.cellTag = QSJoinCommunitiesCellTagWeChat;
    weChatItem.rightTitle = @"@everiToken";
    weChatItem.cellHeight = kRealValue(55);

    self.dataArray = [@[facebookItem,
                       twitterItem,
                       telegramItem,
                       weChatItem] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    QSSettingItem *item = self.dataArray[indexPath.row];
    [cell configureCellWithItem:item];
    [cell addSectionCornerWithTableView:tableView
                              indexPath:indexPath
                        cornerViewframe:CGRectMake(0, 0, item.cellWidth, item.cellHeight)
                           cornerRadius:8];
    cell.separatorInset = UIEdgeInsetsMake(0, item.leftSubviewMargin, 0, 0);
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSSettingItem *item = self.dataArray[indexPath.row];
    return item.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSSettingItem *item = self.dataArray[indexPath.row];
    if (item.cellTag == QSJoinCommunitiesCellTagFacebook) {
        QSOpenURL(kFacebookAddress);
    } else if (item.cellTag == QSJoinCommunitiesCellTagTwitter) {
        QSOpenURL(kTwitterAddress);
    } else if (item.cellTag == QSJoinCommunitiesCellTagTelegram) {
        QSOpenURL(kTelegramAddress);
    } else if (item.cellTag == QSJoinCommunitiesCellTagWeChat) {
        UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:kWechatAddress];
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_join_communities_paste_success_toast")];
    }
}


@end
