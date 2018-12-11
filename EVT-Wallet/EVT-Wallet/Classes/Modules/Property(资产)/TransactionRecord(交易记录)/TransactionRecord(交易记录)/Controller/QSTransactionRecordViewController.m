//
//  QSTransactionRecordViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSTransactionRecordViewController.h"
#import "QSBatchTransferViewController.h"

#import "QSTransactionRecordHeaderView.h"
#import "QSTransactionRecordBottomToolBar.h"
#import "QSTransactionRecordCell.h"
#import "QSTransactionRecordTitleCell.h"
#import "QSTransactionRecordItem.h"

#define kHeaderViewHeight            kRealValue(243) + kStatusBarHeight
#define kTableViewTopEdgeInset       kRealValue(208) + kStatusBarHeight

@interface QSTransactionRecordViewController ()

@property (nonatomic, strong) UIView *navigationBar;
@property (nonatomic, strong) QSTransactionRecordHeaderView *headerView;
@property (nonatomic, strong) QSTransactionRecordBottomToolBar *bottomToolBar;

@end

@implementation QSTransactionRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //nav
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.navigationBar];
    
    //headerview
    self.headerView = [[QSTransactionRecordHeaderView alloc] init];
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, kHeaderViewHeight);
    [self.view insertSubview:self.headerView atIndex:0];
    
    //tableView
    self.tableView.height = kScreenHeight - [QSTransactionRecordBottomToolBar toolBarHeight];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(kTableViewTopEdgeInset, 0, 0, 0);
    
    //toolBar
    self.bottomToolBar.frame = CGRectMake(0, kScreenHeight - [QSTransactionRecordBottomToolBar toolBarHeight], kScreenWidth, [QSTransactionRecordBottomToolBar toolBarHeight]);
    [self.view addSubview:self.bottomToolBar];
}

#pragma mark - **************** Event Response
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)bottomToolBarClickedAtIndex:(NSInteger)index {
    if (index == 0) {
        
    } else if (index == 1) {
        QSBatchTransferViewController *batchTransfer = [[QSBatchTransferViewController alloc] init];
        [self.navigationController pushViewController:batchTransfer animated:YES];
    } else if (index == 2) {
        
    }
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<Class> *)getRigisterMultiCellClasses {
    return @[[QSTransactionRecordCell class],
             [QSTransactionRecordTitleCell class]];
}

- (NSArray<QSBaseCellItem *> *)createSingleSectionDataSource {
    QSBaseCellItem *titleItem = [[QSBaseCellItem alloc] init];
    titleItem.cellIdentifier = NSStringFromClass([QSTransactionRecordTitleCell class]);
    titleItem.cellHeight = kRealValue(45);
    
    QSTransactionRecordItem *recordItem = [[QSTransactionRecordItem alloc] init];
    recordItem.cellIdentifier = NSStringFromClass([QSTransactionRecordCell class]);
    recordItem.cellHeight = kRealValue(66);
    
    return @[titleItem,
             recordItem];
}

#pragma mark - **************** UITableViewDelegate
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
        
        UILabel *titleLabel = [UILabel labelWithName:nil font:[UIFont qs_fontOfSize18] textColor:[UIColor qs_colorWhiteFFFFFF] textAlignment:NSTextAlignmentCenter];
        titleLabel.frame = CGRectMake(100, kStatusBarHeight, kScreenWidth - 200, 44);
        [_navigationBar addSubview:titleLabel];
    }
    return _navigationBar;
}

- (QSTransactionRecordBottomToolBar *)bottomToolBar {
    if (!_bottomToolBar) {
        _bottomToolBar = [[QSTransactionRecordBottomToolBar alloc] init];
        @weakify(self);
        _bottomToolBar.toolBarClickedBlock = ^(NSInteger index) {
            @strongify(self);
            [self bottomToolBarClickedAtIndex:index];
        };
    }
    return _bottomToolBar;
}

@end
