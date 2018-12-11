//
//  QSBaseCornerSectionTableViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCornerSectionTableViewController.h"

@interface QSBaseCornerSectionTableViewController ()

@property (nonatomic, assign) BOOL isMultiSection;

@end

@implementation QSBaseCornerSectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
    [self getDataSource];
}

#pragma mark - **************** Initials
- (void)p_setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.frame = CGRectMake(kRealValue(15), 0, kScreenWidth - kRealValue(30), kScreenHeight - kNavgationBarHeight);
    self.tableView.contentInset = UIEdgeInsetsMake(kRealValue(15), 0, 0, 0);
    if ([self getRigisterMultiCellClasses].count) {
        NSArray *classArray = [self getRigisterMultiCellClasses];
        for (Class cellClass in classArray) {
            [self.tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
        }
    } else {
        [self.tableView registerClass:[self getRigisterCellClass] forCellReuseIdentifier:NSStringFromClass([self getRigisterCellClass])];
    }
}

#pragma mark - **************** Public Methods
- (QSBaseCellItem *)itemInIndexPath:(NSIndexPath *)indexPath {
    if (self.isMultiSection) {
        QSBaseCellItem *item = self.dataArray[indexPath.section][indexPath.row];
        return item;
    }
    QSBaseCellItem *item = self.dataArray[indexPath.row];
    return item;
}

- (void)reloadTableViewData {
    [self getDataSource];
}

- (void)getDataSource {
    NSArray *singleDataSource = [self createSingleSectionDataSource];
    NSArray *multiDataSource = [self createMultiSectionDataSource];
    if (singleDataSource.count) {
        _isMultiSection = NO;
        [self.dataArray addObjectsFromArray:singleDataSource];
    } else {
        _isMultiSection = YES;
        self.dataArray = [multiDataSource mutableCopy];
    }
    [self.tableView reloadData];
}

#pragma mark - **************** QSBaseSettingViewControllerProtocol
- (NSArray *)createSingleSectionDataSource {
    //override
    return nil;
}

- (NSArray *)createMultiSectionDataSource {
    return nil;
}

- (Class)getRigisterCellClass {
    return nil;
}

- (NSArray<Class> *)getRigisterMultiCellClasses {
    return nil;
}

- (BOOL)isShowCornerSection {
    return YES;
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSBaseCellItem *item = [self itemInIndexPath:indexPath];
    QSBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.cellIdentifier forIndexPath:indexPath];
    [cell configureCellWithItem:item];
    if ([self isShowCornerSection]) {
        [cell addSectionCornerWithTableView:tableView
                                  indexPath:indexPath
                            cornerViewframe:CGRectMake(0, 0, item.cellWidth, item.cellHeight)
                               cornerRadius:8];
    }
    cell.separatorInset = item.cellSeapratorInset;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isMultiSection) {
        return self.dataArray.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isMultiSection) {
        return [self.dataArray[section] count];
    }
    return self.dataArray.count;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSBaseCellItem *item = [self itemInIndexPath:indexPath];
    return item.cellHeight;
}


@end
