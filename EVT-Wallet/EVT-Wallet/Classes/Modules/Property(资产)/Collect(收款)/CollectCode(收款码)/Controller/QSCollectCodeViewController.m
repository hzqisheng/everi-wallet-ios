//
//  QSCollectCodeViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCollectCodeViewController.h"
#import "QSPayAmountViewController.h"
#import "QSScanningViewController.h"

#import "QSCollectTipsCell.h"
#import "QSQRCodeAddressCell.h"
#import "QSQRImageCodeCell.h"
#import "QSQRCodeScanItem.h"
#import "QSQRCodeBottomToolBar.h"

@interface QSCollectCodeViewController ()

@property (nonatomic, strong) QSQRCodeBottomToolBar *bottomToolBar;

@end

@implementation QSCollectCodeViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getAddress];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_btn_home_collect")];
    self.tableView.height = kScreenHeight - kNavgationBarHeight - [QSQRCodeBottomToolBar toolBarHeight];
    [self.view addSubview:self.bottomToolBar];
    self.bottomToolBar.frame = CGRectMake(0, self.tableView.maxY, kScreenWidth, [QSQRCodeBottomToolBar toolBarHeight]);
}

- (void)getAddress {
    WeakSelf(weakSelf);
//    [[QSEveriApiWebViewController sharedWebView] getEvtLinkForPayeeCodeAndCompeleteBlock:^(NSInteger statusCode, NSString * _Nonnull addressCodeString) {
//        if (statusCode == kResponseSuccessCode) {
//            NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:1];
//            QSQRCodeScanItem *codeItem = (QSQRCodeScanItem *)[self itemInIndexPath:index];
//            codeItem.qrcodeImageString = addressCodeString;
//            [weakSelf.tableView reloadData];
//        }
//    }];
    
    [[QSEveriApiWebViewController sharedWebView] getEVTLinkQrImageByFungibleId:self.fungibleId amount:self.amount andCompeleteBlock:^(NSInteger statusCode, QSCollectImageModel * _Nonnull collectImage) {
        if (statusCode == kResponseSuccessCode) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:1];
            QSQRCodeScanItem *codeItem = (QSQRCodeScanItem *)[self itemInIndexPath:index];
            codeItem.qrcodeImageString = collectImage.dataUrl;
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark - **************** Event Response
- (void)bottomToolBarClickedItemAtIndex:(NSInteger)index {
    DLog(@"%ld",(long)index);
    if (index == 1) {
        QSScanningViewController *scan = [[QSScanningViewController alloc] init];
        scan.scanningType = QSScanningTypeCollect;
        [self.navigationController pushViewController:scan animated:YES];
    }
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<NSArray<id<QSBaseCellItemDataProtocol>> *> *)createMultiSectionDataSource {
    QSQRCodeScanItem *tipsItem = [[QSQRCodeScanItem alloc] init];
    tipsItem.cellIdentifier = NSStringFromClass([QSCollectTipsCell class]);
    tipsItem.cellHeight = kRealValue(55);
    
    QSQRCodeScanItem *addressItem = [[QSQRCodeScanItem alloc] init];
    addressItem.cellIdentifier = NSStringFromClass([QSQRCodeAddressCell class]);
    addressItem.cellHeight = kRealValue(57);
    addressItem.address = QSPublicKey;
    
    QSQRCodeScanItem *codeImageItem = [[QSQRCodeScanItem alloc] init];
    codeImageItem.cellIdentifier = NSStringFromClass([QSQRImageCodeCell class]);
    codeImageItem.cellHeight = kRealValue(313);
    codeImageItem.address = QSPublicKey;
    codeImageItem.isShowCopyButton = YES;
    
    return @[@[tipsItem],
             @[addressItem,
               codeImageItem]];
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
//    QSPayAmountViewController *payAmount = [[QSPayAmountViewController alloc] init];
//    [self.navigationController pushViewController:payAmount animated:YES];
}

#pragma mark - **************** Setter Getter
- (QSQRCodeBottomToolBar *)bottomToolBar {
    if (!_bottomToolBar) {
        _bottomToolBar = [[QSQRCodeBottomToolBar alloc] init];
        _bottomToolBar.codeTitle = QSLocalizedString(@"qs_collect_bottom_tool_bar_receive_title");
        _bottomToolBar.scanTitle = QSLocalizedString(@"qs_collect_bottom_tool_bar_pay_title");
        @weakify(self);
        _bottomToolBar.clickedItemBlock = ^(NSInteger index) {
            @strongify(self);
            [self bottomToolBarClickedItemAtIndex:index];
        };
    }
    return _bottomToolBar;
}

@end
