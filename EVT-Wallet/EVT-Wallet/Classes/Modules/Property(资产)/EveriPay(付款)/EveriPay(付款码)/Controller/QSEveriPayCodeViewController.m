//
//  QSEveriPayCodeViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSEveriPayCodeViewController.h"
#import "QSScanningViewController.h"
#import "QSEveriPayCollectAmountViewController.h"
#import "QSPayAmountViewController.h"
#import "QSPaySuccessViewController.h"

#import "QSQRCodeScanTipsCell.h"
#import "QSQRCodeAddressCell.h"
#import "QSQRImageCodeCell.h"
#import "QSQRCodeScanItem.h"
#import "QSQRCodeSelectAddressCell.h"
#import "QSQRCodeMaxPayAmountCell.h"
#import "QSQRCodeBottomToolBar.h"
#import "QSSelectCurrencyView.h"

typedef NS_ENUM(NSUInteger, QSEveriPayCodeCellType) {
    QSEveriPayCodeCellTypeSelectAddress = 1,
};

@interface QSEveriPayCodeViewController ()

@property (nonatomic, strong) QSQRCodeBottomToolBar *bottomToolBar;

@property (nonatomic, copy) NSString *maxAmount;
@property (nonatomic, copy) NSString *linkId;
@property (nonatomic, assign) BOOL isPushPaySuccessVC;

@end

@implementation QSEveriPayCodeViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[QSEveriApiWebViewController sharedWebView] stopEVTLinkQrImageReload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_btn_pay_everipay")];
    self.tableView.height = kScreenHeight - kNavgationBarHeight - [QSQRCodeBottomToolBar toolBarHeight];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.bottomToolBar];
    self.bottomToolBar.frame = CGRectMake(0, self.tableView.maxY, kScreenWidth, [QSQRCodeBottomToolBar toolBarHeight]);
    
    if (self.selectFTModel) {
        [self getlinkId];
    } else {
        [self getFirstFT];
    }
}

#pragma mark - **************** Requests
- (void)getFirstFT {
    WeakSelf(weakSelf);
    [[QSEveriApiWebViewController sharedWebView] getEVTFungibleBalanceListWithPublicKey:QSPublicKey andCompeleteBlock:^(NSInteger statusCode, NSArray * _Nonnull ftList) {
        if (statusCode == kResponseSuccessCode) {
            if (ftList.count > 0) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:1];
                QSQRCodeScanItem *addressItem = (QSQRCodeScanItem *)[weakSelf itemInIndexPath:indexPath];
                addressItem.FTModel = ftList[0];
                weakSelf.selectFTModel = ftList[0];
                [weakSelf getlinkId];
            }
        }
    }];
}

- (void)getlinkId {
    [[QSEveriApiWebViewController sharedWebView] stopEVTLinkQrImageReload];
    
    //!self.selectFTModel.creator.length ||
    if (!self.maxAmount.length) {
        UIImage *photo = [UIImage imageWithColor:[UIColor qs_colorGrayDDDDDD]];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
        QSQRCodeScanItem *codeItem = (QSQRCodeScanItem *)[self itemInIndexPath:indexPath];
        codeItem.codeImage = photo;
        [self.tableView reloadData];
        return;
    }
    
    WeakSelf(weakSelf);
    [[QSEveriApiWebViewController sharedWebView] getUniqueLinkIdAndCompeleteBlock:^(NSInteger statusCode, NSString * _Nonnull linkId) {
        if (statusCode == kResponseSuccessCode) {
            weakSelf.linkId = linkId;
            [weakSelf getCode];
            [weakSelf getLinkState];
        }
    }];
}

- (void)getCode {
    WeakSelf(weakSelf);
    NSArray *symArr = [self.selectFTModel.sym componentsSeparatedByString:@"#"];
    if (symArr.count < 2) {
        return;
    }
    NSString *sybId = symArr[1];
    NSArray *symArr2 = [self.selectFTModel.sym componentsSeparatedByString:@","];
    if (symArr2.count < 2) {
        return;
    }
    NSString *jinduStr = symArr2[0];
    NSInteger maxAmountNumber = [self.maxAmount integerValue];
    for (int i = 0 ; i < [jinduStr integerValue]; i++) {
        maxAmountNumber = maxAmountNumber * 10;
    }
    NSString *maxAmountStr = [NSString stringWithFormat:@"%ld",maxAmountNumber];
    
    [[QSEveriApiWebViewController sharedWebView] getEVTLinkQrImageWithSym:sybId andMaxAmount:maxAmountStr andLinkId:self.linkId AndCompeleteBlock:^(NSInteger statusCode, NSString * _Nonnull addressCodeString) {
        if (statusCode == kResponseSuccessCode) {
            NSData * imageData =[[NSData alloc] initWithBase64EncodedString:addressCodeString options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *photo = [UIImage imageWithData:imageData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
            QSQRCodeScanItem *codeItem = (QSQRCodeScanItem *)[weakSelf itemInIndexPath:indexPath];
            codeItem.codeImage = photo;
            [weakSelf.tableView reloadData];
        }
    }];
}

- (void)getLinkState {
    WeakSelf(weakSelf);
    [[QSEveriApiWebViewController sharedWebView] getStatusOfEvtLinkWithLink:self.linkId AndCompeleteBlock:^(NSInteger statusCode, QSEvtLinkStatus * _Nonnull status) {
        if (status.pending == 0
            && status.transactionId.length) {
            if (!weakSelf.isPushPaySuccessVC) {
                QSPaySuccessViewController *success = [[QSPaySuccessViewController alloc] init];
                success.transactionId = status.transactionId;
                [weakSelf pushRemoveSelfToViewController:success animated:YES];
                weakSelf.isPushPaySuccessVC = YES;
            }
        } else {
            [weakSelf getLinkState];
        }
    }];
}

#pragma mark - **************** Private Methods
- (void)showSelectCurrencyViewWithArray:(NSArray *)array {
    NSInteger isCreate = 0;
    for (UIView *v in QSAppKeyWindow.subviews){
        if ([v isKindOfClass:[QSSelectCurrencyView class]]) {
            isCreate = 1;
        }
    }
    if (isCreate == 1) {
        return;
    }

    WeakSelf(weakSelf);
    [QSSelectCurrencyView showSelectCurrencyViewWithFTList:array
                                            seletedSymName:self.selectFTModel.sym_name
                                          andSelectFTBlock:^(QSFT * _Nonnull FTModel) {
                                              NSIndexPath *index = [NSIndexPath indexPathForRow:2 inSection:1];
                                              QSQRCodeScanItem *selectedItem = (QSQRCodeScanItem *)[self itemInIndexPath:index];
                                              selectedItem.FTModel = FTModel;
                                              weakSelf.selectFTModel = FTModel;
                                              [weakSelf.tableView reloadData];
                                              [weakSelf getlinkId];
                                          }];
}

#pragma mark - **************** Event Response
- (void)bottomToolBarClickedItemAtIndex:(NSInteger)index {
    DLog(@"%ld",(long)index);
    if (index == 1) {
        QSScanningViewController *scan = [[QSScanningViewController alloc] init];
        scan.scanningType = QSScanningTypePay;
        [self.navigationController pushViewController:scan animated:YES];
    }
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<NSArray<QSBaseCellItem *> *> *)createMultiSectionDataSource {
    WeakSelf(weakSelf);
    QSQRCodeScanItem *tipsItem = [[QSQRCodeScanItem alloc] init];
    tipsItem.cellIdentifier = NSStringFromClass([QSQRCodeScanTipsCell class]);
    tipsItem.cellHeight = kRealValue(55);
    
    QSQRCodeScanItem *addressItem = [[QSQRCodeScanItem alloc] init];
    addressItem.cellIdentifier = NSStringFromClass([QSQRCodeAddressCell class]);
    addressItem.cellHeight = kRealValue(57);
    addressItem.address = QSPublicKey;
    
    QSQRCodeScanItem *codeImageItem = [[QSQRCodeScanItem alloc] init];
    codeImageItem.cellIdentifier = NSStringFromClass([QSQRImageCodeCell class]);
    codeImageItem.cellHeight = kRealValue(285);
    codeImageItem.address = QSPublicKey;
    codeImageItem.cellSeapratorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
    
    QSQRCodeScanItem *selectAddressItem = [[QSQRCodeScanItem alloc] init];
    selectAddressItem.cellIdentifier = NSStringFromClass([QSQRCodeSelectAddressCell class]);
    selectAddressItem.cellHeight = kRealValue(60);
    selectAddressItem.cellTag = QSEveriPayCodeCellTypeSelectAddress;
    if (self.selectFTModel.sym_name.length) {
        selectAddressItem.FTModel = self.selectFTModel;
    }
    
    QSQRCodeScanItem *maxPayItem = [[QSQRCodeScanItem alloc] init];
    maxPayItem.cellIdentifier = NSStringFromClass([QSQRCodeMaxPayAmountCell class]);
    maxPayItem.cellHeight = kRealValue(44);
    maxPayItem.keyboardType = UIKeyboardTypeNumberPad;
    maxPayItem.codeScanItemTextChangedBlock = ^(NSString * _Nonnull text) {
        weakSelf.maxAmount = text;
        [[QSEveriApiWebViewController sharedWebView] stopEVTLinkQrImageReload];
    };
    if (!self.maxAmount.length) {
        self.maxAmount = @"100";
    }
    maxPayItem.codeScanItemEndEditingBlock = ^{
        [weakSelf getlinkId];
    };
    return @[@[tipsItem],
             @[addressItem,
               codeImageItem,
               selectAddressItem,
               maxPayItem]];
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
    if (item.cellTag == QSEveriPayCodeCellTypeSelectAddress) {
        WeakSelf(weakSelf);
        [[QSEveriApiWebViewController sharedWebView] getEVTFungibleBalanceListWithPublicKey:QSPublicKey andCompeleteBlock:^(NSInteger statusCode, NSArray * _Nonnull ftList) {
            if (statusCode == kResponseSuccessCode) {
                [weakSelf showSelectCurrencyViewWithArray:ftList];
            }
        }];
    } else {
//        QSEveriPayCollectAmountViewController *collect = [[QSEveriPayCollectAmountViewController alloc] init];
//        [self.navigationController pushViewController:collect animated:YES];
    }
}

#pragma mark - **************** Setter Getter
- (QSQRCodeBottomToolBar *)bottomToolBar {
    if (!_bottomToolBar) {
        _bottomToolBar = [[QSQRCodeBottomToolBar alloc] init];
        _bottomToolBar.codeTitle = QSLocalizedString(@"qs_everipay_bottom_tool_bar_code_title");
        _bottomToolBar.scanTitle = QSLocalizedString(@"qs_everipay_bottom_tool_bar_scan_title");
        @weakify(self);
        _bottomToolBar.clickedItemBlock = ^(NSInteger index) {
            @strongify(self);
            [self bottomToolBarClickedItemAtIndex:index];
        };
    }
    return _bottomToolBar;
}

@end
