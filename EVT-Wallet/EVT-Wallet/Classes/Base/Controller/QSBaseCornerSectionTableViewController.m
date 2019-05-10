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
@property (nonatomic, strong) NSMutableSet *mutableSet;

@end

@implementation QSBaseCornerSectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mutableSet = [NSMutableSet set];
    [self p_setupTableView];
    [self getDataSource];
}

#pragma mark - **************** Initials
- (void)p_setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.frame = CGRectMake(kRealValue(15), 0, kScreenWidth - kRealValue(30), kScreenHeight - kNavgationBarHeight);
    self.tableView.contentInset = UIEdgeInsetsMake(kRealValue(15), 0, 0, 0);
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
    
    BOOL condition = !(singleDataSource.count && multiDataSource.count);
    NSAssert((condition), @"one of createSingleSectionDataSource,createMultiSectionDataSource must be implemented");
    
    if (singleDataSource.count) {
        _isMultiSection = NO;
        [self.dataArray addObjectsFromArray:singleDataSource];
    } else if (multiDataSource.count) {
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

- (BOOL)isShowCornerSection {
    return YES;
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSBaseCellItem *item = [self itemInIndexPath:indexPath];
    
    Class registerClass = NSClassFromString(item.cellIdentifier);
    NSAssert(registerClass, @"the class get from 'baseCellItem.cellIdentifier' is invalid");

    if (![self.mutableSet containsObject:registerClass]) {
        [tableView registerClass:registerClass forCellReuseIdentifier:item.cellIdentifier];
        [self.mutableSet addObject:registerClass];
    }
    
    QSBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.cellIdentifier forIndexPath:indexPath];
    NSAssert(cell, @"your custom cell must be subclass of 'QSBaseTableViewCell'");
    
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
