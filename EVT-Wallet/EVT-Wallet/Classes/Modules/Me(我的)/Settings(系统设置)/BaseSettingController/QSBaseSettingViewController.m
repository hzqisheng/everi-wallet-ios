//
//  QSBaseSettingViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseSettingViewController.h"

@interface QSBaseSettingViewController ()

@property (nonatomic, assign) BOOL isMultiSection;

@end

@implementation QSBaseSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    NSArray *singleDataSource = [self createSingleSectionDataSource];
    NSArray *multiDataSource = [self createSingleSectionDataSource];
    if (singleDataSource.count) {
        _isMultiSection = NO;
        [self.dataArray addObjectsFromArray:singleDataSource];
    } else {
        _isMultiSection = YES;
        [self.dataArray addObjectsFromArray:multiDataSource];
    }
    [self.tableView reloadData];
}

#pragma mark - **************** Initials
- (void)setupTableView {
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

#pragma mark - **************** QSBaseSettingViewControllerProtocol
- (NSArray *)createSingleSectionDataSource {
   //override
    return nil;
}

- (NSArray *)createMultiSectionDataSource {
    return nil;
}

- (Class)getRigisterCellClass {
    return [QSSettingCell class];
}

- (NSArray<Class> *)getRigisterMultiCellClasses {
    return nil;
}

- (QSSettingItem *)itemInIndexPath:(NSIndexPath *)indexPath {
    if (self.isMultiSection) {
        QSSettingItem *item = self.dataArray[indexPath.section][indexPath.row];
        return item;
    }
    QSSettingItem *item = self.dataArray[indexPath.row];
    return item;
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSSettingItem *item = [self itemInIndexPath:indexPath];
    QSSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:item.cellIdentifier forIndexPath:indexPath];
    [cell configureCellWithItem:item];
    [cell addSectionCornerWithTableView:tableView
                              indexPath:indexPath
                        cornerViewframe:CGRectMake(0, 0, item.cellWidth, item.cellHeight)
                           cornerRadius:8];
    cell.separatorInset = UIEdgeInsetsMake(0, item.leftSubviewMargin, 0, 0);
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
    QSSettingItem *item = [self itemInIndexPath:indexPath];
    return item.cellHeight;
}

@end
