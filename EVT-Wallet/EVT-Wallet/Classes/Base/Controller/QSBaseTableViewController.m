//
//  QSBaseTableViewController.m
//  QSSmarkPark-iOS
//
//  Created by 孙俊 on 2018/4/2.
//  Copyright © 2018年 QiSheng. All rights reserved.
//

#import "QSBaseTableViewController.h"
#import "QSRefreshHeader.h"
#import "QSRefreshFooter.h"

@interface QSBaseTableViewController ()

/** page default:1 */
@property(nonatomic, assign) NSInteger pageIndex;

@end

@implementation QSBaseTableViewController

- (instancetype)init {
    if (self = [super init]) {
        _pageIndex = 1;
        _style = UITableViewStylePlain;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor qs_colorWhiteF5F7FB];
    [self.view addSubview:self.tableView];
}

#pragma mark - **************** Public Methods
- (void)addRefreshHeader {
    WeakSelf(weakSelf);
    self.tableView.mj_header = [QSRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        [weakSelf tableViewShouldUpdateDataByPageIndex:weakSelf.pageIndex];
    }];
}

- (void)addRefreshFooter {
    WeakSelf(weakSelf);
    self.tableView.mj_footer = [QSRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf tableViewShouldUpdateDataByPageIndex:weakSelf.pageIndex];
    }];
}

- (void)endRefreshing {
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)endRefreshingWithNoMoreData {
    if (self.tableView.mj_footer) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)startRefreshing {
    [self startRefreshing:NO];
}

- (void)startRefreshing:(BOOL)animated {
    self.pageIndex = 1;
    if (animated) {
        [self.tableView.mj_header beginRefreshing];
    } else {
        [self tableViewShouldUpdateDataByPageIndex:self.pageIndex];
    }
}

#pragma mark - **************** RefreshDataManager
- (void)tableViewShouldUpdateDataByPageIndex:(NSInteger)pageIndex {
    //override
}

#pragma mark - **************** UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

#pragma mark - **************** Setter Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavgationBarHeight) style:_style];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorColor = [UIColor qs_colorGrayCCCCCC];
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor qs_colorWhiteF5F7FB];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
