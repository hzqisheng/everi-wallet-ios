//
//  QSNodeSettingDetailViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/15.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSNodeSettingDetailViewController.h"
#import "QSNodeSettingAddAlertView.h"
#import "QSNodeSettingItem.h"

@interface QSNodeSettingDetailViewController ()

@end

@implementation QSNodeSettingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_everitoken_node_setting_title")];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:QSLocalizedString(@"qs_everitoken_node_setting_add") font:[UIFont qs_fontOfSize15] titleColor:[UIColor whiteColor] target:self action:@selector(rightBarButtonItemClicked)];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.frame = CGRectMake(kRealValue(15), 0, kScreenWidth - kRealValue(30), kScreenHeight - kNavgationBarHeight);
    self.tableView.contentInset = UIEdgeInsetsMake(kRealValue(15), 0, 0, 0);
    
    [self createDataSource];
}

- (void)createDataSource {
    NSArray *dataArray = [[QSWalletHelper sharedHelper] getAllNodes];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:[QSNodeSettingItem mj_objectArrayWithKeyValuesArray:dataArray]];
    
    QSNodeSettingItem *selectedNode = [QSWalletHelper sharedHelper].currentNode;
    for (QSNodeSettingItem *item in self.dataArray) {
        if ([item.title isEqualToString:selectedNode.title]) {
            item.isSelected = 1;
        }
    }
    [self.tableView reloadData];
}

#pragma mark - **************** Private Methods
- (QSNodeSettingItem *)getSelectedItem {
    for (QSNodeSettingItem *item in self.dataArray) {
        if (item.isSelected) {
            return item;
        }
    }
    return nil;
}

#pragma mark - **************** Event
- (void)tableViewCellClicked {
    QSNodeSettingItem *seletedItem = [self getSelectedItem];
    DLog(@"%@",seletedItem.title);
    if (!seletedItem.title) {
        return;
    }
    [[QSWalletHelper sharedHelper] changeCurrentNode:seletedItem];
}

- (void)rightBarButtonItemClicked {
    [QSNodeSettingAddAlertView showAlertViewAndConfirmBlock:^(NSString * _Nonnull nodeAddress) {
        NSLog(@"%@",nodeAddress);
        if (![nodeAddress isValidUrl]) {
            [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_everitoken_node_setting_add_error_toast")];
            return;
        }
        // http://www.asf.as:401 这种格式
        NSArray *absoluteStringArray = [nodeAddress componentsSeparatedByString:@"//"];
        if (absoluteStringArray.count == 2) {
            NSString *absoluteString = absoluteStringArray[1];
            NSArray *titleList = [absoluteString componentsSeparatedByString:@":"];
            if (titleList.count == 2) {
                NSString *protocol = [nodeAddress hasPrefix:@"http"] ? @"http" : @"https";
                NSString *host = titleList[0];
                NSString *port = titleList[1];
                NSLog(@"protocol:%@,host:%@,port:%@",protocol,host,port);
                [[QSEveriApiWebViewController sharedWebView] checkNetworkByProtocol:protocol port:port host:host andCompeleteBlock:^(NSInteger statusCode) {
                    if (statusCode == kResponseSuccessCode) {
                        [[QSWalletHelper sharedHelper] cacheCustomNode:host nodeDetail:@"CustemNet" port:port protocol:protocol];
                        [self createDataSource];
                    }
                }];
            }
        }
    }];
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellID"];
    }
    
    QSNodeSettingItem *item = self.dataArray[indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.detail;
    cell.detailTextLabel.textColor = [UIColor qs_colorGray686868];
    if (item.isSelected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell addSectionCornerWithTableView:tableView
                              indexPath:indexPath
                        cornerViewframe:CGRectMake(0, 0, kScreenWidth - kRealValue(30), kRealValue(50))
                           cornerRadius:8];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRealValue(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (QSNodeSettingItem *item in self.dataArray) {
        item.isSelected = 0;;
    }
    QSNodeSettingItem *item = self.dataArray[indexPath.row];
    item.isSelected = 1;
    [self tableViewCellClicked];
}

@end
