//
//  QSManageAddressViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSManageAddressViewController.h"
#import "QSAddAddressViewController.h"
#import "QSImportAddressViewController.h"
#import "QSExportAddressViewController.h"

#import "QSManageAdressSearchView.h"
#import "QSManageAddressCell.h"

@interface QSManageAddressViewController ()

@property (nonatomic, strong) QSManageAdressSearchView *searchView;
@property (nonatomic, strong) UIButton *addAddressButton;
@property (nonatomic, strong) UIButton *importAddressButton;

@end

static NSString *reuseIdentifier = @"QSAdressCell";

@implementation QSManageAddressViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}

- (void)setupSubViews {
    //nav
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_manage_address_nav_title")];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:QSLocalizedString(@"qs_manage_address_right_navitem_title") font:[UIFont qs_fontOfSize14] titleColor:[UIColor qs_colorYellowE4B84F] target:self action:@selector(rightBarItemClicked)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    //search
//    self.searchView.frame = CGRectMake(0, 0, kScreenWidth, kManageAdressSearchViewHeight);
//    [self.view addSubview:self.searchView];
    
    //tableView
    [self addRefreshHeader];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView registerClass:[QSManageAddressCell class] forCellReuseIdentifier:reuseIdentifier];
    
    //footer button
    CGFloat footerButtonW = kRealValue(168);
    CGFloat footerButtonH = kRealValue(40);
    CGFloat footerButtonBottomMargin = kDevice_Is_iPhoneX ? kiPhoneXSafeAreaBottomMagin : kRealValue(15);
    if (self.haveNotBottomBar) {
        self.addAddressButton.frame = CGRectMake(kScreenWidth/2 - footerButtonW - 5 , kScreenHeight - kNavgationBarHeight - footerButtonBottomMargin - footerButtonH, footerButtonW, footerButtonH);
        [self.view addSubview:self.addAddressButton];
        self.importAddressButton.frame = CGRectMake(kScreenWidth/2 + 5 , kScreenHeight - kNavgationBarHeight - footerButtonBottomMargin - footerButtonH, footerButtonW, footerButtonH);
        [self.view addSubview:self.importAddressButton];
    } else {
        self.addAddressButton.frame = CGRectMake(kScreenWidth/2 - footerButtonW - 5 , kScreenHeight - kNavgationBarHeight - footerButtonBottomMargin - footerButtonH - kRealValue(64), footerButtonW, footerButtonH);
        [self.view addSubview:self.addAddressButton];
        self.importAddressButton.frame = CGRectMake(kScreenWidth/2 + 5 , kScreenHeight - kNavgationBarHeight - footerButtonBottomMargin - footerButtonH - kRealValue(64), footerButtonW, footerButtonH);
        [self.view addSubview:self.importAddressButton];
    }
}

#pragma mark - **************** UpdateData
- (void)tableViewShouldUpdateDataByPageIndex:(NSInteger)pageIndex {
    if (self.dataArray.count) {
        [self.dataArray removeAllObjects];
    }
    self.dataArray = [NSMutableArray arrayWithArray:[[QSAddressHelper sharedHelper] getAddress]];
    [self.tableView reloadData];
    [self endRefreshing];
}

#pragma mark - **************** Event Response
- (void)rightBarItemClicked {
    if (!self.dataArray.count) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_manage_address_no_address_exprot")];
        return;
    }
    QSExportAddressViewController *export = [[QSExportAddressViewController alloc] init];
    export.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:export animated:YES];
}

- (void)addAddressButtonClicked {
    QSAddAddressViewController *addAddress = [[QSAddAddressViewController alloc] init];
    addAddress.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addAddress animated:YES];
}

- (void)importAddressButtonClicked {
    QSImportAddressViewController *importAddress = [[QSImportAddressViewController alloc] init];
    importAddress.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:importAddress animated:YES];
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSManageAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.addressModel = self.dataArray[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        QSAddress *address = self.dataArray[indexPath.row];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        [[QSAddressHelper sharedHelper] deleteAddress:address.publicKey];
    }
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRealValue(105);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return QSLocalizedString(@"qs_manage_address_cell_delete");
}

#pragma mark - **************** Setter Getter
- (QSManageAdressSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[QSManageAdressSearchView alloc] init];
    }
    return _searchView;
}

- (UIButton *)addAddressButton {
    if (!_addAddressButton) {
        _addAddressButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_manage_address_btn_add_address") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize15] taget:self action:@selector(addAddressButtonClicked)];
        _addAddressButton.backgroundColor = [UIColor qs_colorBlack313745];
        _addAddressButton.layer.cornerRadius = 3;
    }
    return _addAddressButton;
}

- (UIButton *)importAddressButton {
    if (!_importAddressButton) {
        _importAddressButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_manage_address_btn_import_address") titleColor:[UIColor qs_colorWhiteFFFFFF] font:[UIFont qs_fontOfSize15] taget:self action:@selector(importAddressButtonClicked)];
        _importAddressButton.backgroundColor = [UIColor qs_colorBlack313745];
        _importAddressButton.layer.cornerRadius = 3;
    }
    return _importAddressButton;
}



@end
