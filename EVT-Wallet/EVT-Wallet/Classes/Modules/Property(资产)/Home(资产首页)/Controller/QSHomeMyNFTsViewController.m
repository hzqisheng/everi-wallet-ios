//
//  QSHomeMyNFTsViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/26.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSHomeMyNFTsViewController.h"
#import "QSMyNFTsCell.h"

@interface QSHomeMyNFTsViewController ()

@end

static NSString *reuseIdentifier = @"QSHomeMyFTsCell";

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
    [self.tableView registerClass:[QSMyNFTsCell class] forCellReuseIdentifier:reuseIdentifier];
    [self addRefreshHeader];
    [self startRefreshing];
}

- (void)tableViewShouldUpdateDataByPageIndex:(NSInteger)pageIndex {
    [[QSEveriApiWebViewController sharedWebView] getOwnedTokensWithPublicKeys:QSPublicKey andCompeleteBlock:^(NSInteger statusCode, NSArray<QSOwnedToken *> * _Nonnull ownedTokens) {
        if (statusCode == kResponseSuccessCode) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:ownedTokens];
            [self.tableView reloadData];
        }
        [self endRefreshing];
    }];
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSMyNFTsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.ownedToken = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRealValue(65);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


@end
