//
//  QSExportPrivateKeyViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/4.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSExportPrivateKeyViewController.h"
#import "QSSettingCell.h"
#import "QSSettingItem.h"

typedef NS_ENUM(NSUInteger, QSExportPrivateKeyType) {
    QSExportPrivateKeyTypeAddress,
    QSExportPrivateKeyTypePrivateKey,
};

@interface QSExportPrivateKeyViewController ()

@property (nonatomic, strong) UIView *headerView;

@end

@implementation QSExportPrivateKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_export_private_key_nav_title")];
    [self setupHeaderView];
}

- (void)setupHeaderView {
    //headerView
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(149))];
    
    //mentionBackgroundImageView
    UIImageView *mentionBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(30), kRealValue(15), kScreenWidth - kRealValue(60), kRealValue(86))];
    mentionBackgroundImageView.image = [UIImage imageNamed:@"img_daoruqianbao"];
    [self.headerView addSubview:mentionBackgroundImageView];
    
    //tipsLabel
    NSString *totalText = QSLocalizedString(@"qs_export_private_key_metion_total_title");
    NSString *highlightText = QSLocalizedString(@"qs_export_private_key_metion_highlight_title");
    YYLabel *mentionsLabel = [YYLabel new];
    mentionsLabel.numberOfLines = 0;
    mentionsLabel.frame = CGRectMake(kRealValue(15),  kRealValue(15), mentionBackgroundImageView.width - kRealValue(30), kRealValue(55));
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:totalText ];
    [attr yy_setFont:[UIFont qs_fontOfSize13] range:NSMakeRange(0, attr.length)];
    [attr yy_setColor:[UIColor qs_colorGray686868] range:NSMakeRange(0, attr.length)];
    [attr yy_setColor:[UIColor qs_colorBlue4D7BF3] range:[totalText rangeOfString:highlightText]];
    mentionsLabel.attributedText = attr;
    [mentionsLabel sizeToFit];
    mentionBackgroundImageView.height = mentionsLabel.height + kRealValue(30);
    [mentionBackgroundImageView addSubview:mentionsLabel];

    //paste
    UILabel *pasteLabel = [UILabel labelWithName:QSLocalizedString(@"qs_export_private_key_paste_tips_title") font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentCenter];
    pasteLabel.frame = CGRectMake(0, mentionBackgroundImageView.maxY + kRealValue(24), kScreenWidth, [UIFont qs_fontOfSize18].lineHeight);
    [self.headerView addSubview:pasteLabel];
    
    [self.view addSubview:self.headerView];
    self.tableView.contentInset = UIEdgeInsetsMake(self.headerView.height, kRealValue(15), 0, kRealValue(15));
    self.tableView.scrollEnabled = NO;
}

- (Class)getRigisterCellClass {
    return [QSSettingCell class];
}

- (NSArray<QSBaseCellItem *> *)createSingleSectionDataSource {
    QSSettingItem *addressItem = [[QSSettingItem alloc] init];
    addressItem.leftTitle = QSLocalizedString(@"qs_export_private_key_address_title");
    addressItem.leftTitleFont = [UIFont qs_fontOfSize16];
    addressItem.cellTag = QSExportPrivateKeyTypeAddress;
    addressItem.cellType = QSSettingItemTypeLeftRightTitle;
    addressItem.cellSeapratorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    addressItem.cellIdentifier = NSStringFromClass([QSSettingCell class]);
    addressItem.cellHeight = kRealValue(60);
    addressItem.rightNumberOfLines = 2;
    addressItem.rightTitle = @"EOS5fKvaUBt7gBagCUBt7gBagCUBt7gBagCUBt7gBagCUBt7gBagC";
    addressItem.rightSubviewMargin = kRealValue(20);
    addressItem.rightTitleFont = [UIFont qs_fontOfSize12];
    addressItem.rightTitleColor = [UIColor qs_colorGray686868];
    addressItem.rightTitleLabelSize = CGSizeMake(kRealValue(210), addressItem.rightTitleLabelSize.height*2);

    QSSettingItem *keyItem = [[QSSettingItem alloc] init];
    keyItem.leftTitle = QSLocalizedString(@"qs_export_private_key_private_key_title");
    keyItem.leftTitleFont = [UIFont qs_fontOfSize16];
    keyItem.cellTag = QSExportPrivateKeyTypePrivateKey;
    keyItem.cellType = QSSettingItemTypeLeftRightTitle;
    keyItem.cellSeapratorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    keyItem.cellIdentifier = NSStringFromClass([QSSettingCell class]);
    keyItem.cellHeight = kRealValue(60);
    keyItem.rightNumberOfLines = 2;
    keyItem.rightTitle = @"EOS5fKvaUBt7gBagCUBt7gBagCUBt7gBagCUBt7gBagCUBt7gBagC";
    keyItem.rightSubviewMargin = kRealValue(20);
    keyItem.rightTitleFont = [UIFont qs_fontOfSize12];
    keyItem.rightTitleColor = [UIColor qs_colorGray686868];
    keyItem.rightTitleLabelSize = CGSizeMake(kRealValue(210), keyItem.rightTitleLabelSize.height*2);
    
    return @[addressItem,
             keyItem];
}

#pragma mark - **************** UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSSettingItem *item = (QSSettingItem *)[self itemInIndexPath:indexPath];
    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:item.rightTitle];
    if (item.cellTag == QSExportPrivateKeyTypeAddress) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_export_private_key_address_paste_title")];
    } else if (item.cellTag == QSExportPrivateKeyTypePrivateKey) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_export_private_key_private_key_paste_title")];
    }
}


@end
