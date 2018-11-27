//
//  QSHomeMyNFTsViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/26.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSHomeMyNFTsViewController.h"

@interface QSHomeMyNFTsViewController ()

@end

@implementation QSHomeMyNFTsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHomeHeaderViewHeight)];
    headerView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
    self.tableView.tableHeaderView = headerView;
    [self addRefreshHeader];
}

- (void)tableViewShouldUpdateDataByPageIndex:(NSInteger)pageIndex {
    [self endRefreshing];
}

@end
