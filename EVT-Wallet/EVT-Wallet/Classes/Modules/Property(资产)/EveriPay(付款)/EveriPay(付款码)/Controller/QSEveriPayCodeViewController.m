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

@end

@implementation QSEveriPayCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_btn_home_pay")];
    self.tableView.height = kScreenHeight - kNavgationBarHeight - [QSQRCodeBottomToolBar toolBarHeight];
    [self.view addSubview:self.bottomToolBar];
    self.bottomToolBar.frame = CGRectMake(0, self.tableView.maxY, kScreenWidth, [QSQRCodeBottomToolBar toolBarHeight]);
}

#pragma mark - **************** Event Response
- (void)bottomToolBarClickedItemAtIndex:(NSInteger)index {
    DLog(@"%ld",(long)index);
    if (index == 1) {
        QSScanningViewController *scan = [[QSScanningViewController alloc] init];
        [self.navigationController pushViewController:scan animated:YES];
    }
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<Class> *)getRigisterMultiCellClasses {
    return @[[QSQRCodeScanTipsCell class],
             [QSQRCodeAddressCell class],
             [QSQRImageCodeCell class],
             [QSQRCodeSelectAddressCell class],
             [QSQRCodeMaxPayAmountCell class]];
}

- (NSArray<NSArray<QSBaseCellItem *> *> *)createMultiSectionDataSource {
    QSQRCodeScanItem *tipsItem = [[QSQRCodeScanItem alloc] init];
    tipsItem.cellIdentifier = NSStringFromClass([QSQRCodeScanTipsCell class]);
    tipsItem.cellHeight = kRealValue(55);
    
    QSQRCodeScanItem *addressItem = [[QSQRCodeScanItem alloc] init];
    addressItem.cellIdentifier = NSStringFromClass([QSQRCodeAddressCell class]);
    addressItem.cellHeight = kRealValue(57);
    addressItem.address = @"EKHD888HJKDS887DSD888779979sdf";
    
    QSQRCodeScanItem *codeImageItem = [[QSQRCodeScanItem alloc] init];
    codeImageItem.cellIdentifier = NSStringFromClass([QSQRImageCodeCell class]);
    codeImageItem.cellHeight = kRealValue(285);
    codeImageItem.address = @"EKHD888HJKDS887DSD888779979sdf";
    codeImageItem.cellSeapratorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
    
    QSQRCodeScanItem *selectAddressItem = [[QSQRCodeScanItem alloc] init];
    selectAddressItem.cellIdentifier = NSStringFromClass([QSQRCodeSelectAddressCell class]);
    selectAddressItem.cellHeight = kRealValue(60);
    selectAddressItem.cellTag = QSEveriPayCodeCellTypeSelectAddress;
    
    QSQRCodeScanItem *maxPayItem = [[QSQRCodeScanItem alloc] init];
    maxPayItem.cellIdentifier = NSStringFromClass([QSQRCodeMaxPayAmountCell class]);
    maxPayItem.cellHeight = kRealValue(44);
    maxPayItem.maxPayAmount = @"1000000000";
    
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
        [QSSelectCurrencyView showSelectCurrencyView];
    } else {
        QSEveriPayCollectAmountViewController *collect = [[QSEveriPayCollectAmountViewController alloc] init];
        [self.navigationController pushViewController:collect animated:YES];
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
