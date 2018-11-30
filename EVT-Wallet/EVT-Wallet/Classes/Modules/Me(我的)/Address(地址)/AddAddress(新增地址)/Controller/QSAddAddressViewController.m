//
//  QSAddAddressViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSAddAddressViewController.h"
#import "QSAddAddressCell.h"
#import "QSAddAddressItem.h"
#import "QSAddAddressCell+QSAddAddressInput.h"
#import "QSAddAddressCell+QSAddAddressScan.h"
#import "QSAddAddressCell+QSAddAddressType.h"

@interface QSAddAddressViewController ()

@property (nonatomic, strong) UIView *footerView;

@end

static NSString *reuseIdentifier = @"QSAddAddressCell";

@implementation QSAddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_add_address_nav_title")];
    [self setupTableView];
    [self createDataSource];
}

- (void)setupTableView {
    [self.tableView registerClass:[QSAddAddressCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.frame = CGRectMake(kRealValue(15), 0, kScreenWidth - kRealValue(30), kScreenHeight - kNavgationBarHeight);
    self.tableView.contentInset = UIEdgeInsetsMake(kRealValue(15), 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = self.footerView;
}

- (void)createDataSource {
    QSAddAddressItem *typeItem = [[QSAddAddressItem alloc] init];
    typeItem.leftTitle = QSLocalizedString(@"qs_add_address_item_type_title");
    typeItem.leftTitleFont = [UIFont qs_fontOfSize16];
    typeItem.showTypeButton = YES;
    typeItem.cellHeight = kRealValue(55);
    
    QSAddAddressItem *addressItem = [[QSAddAddressItem alloc] init];
    addressItem.leftTitle = QSLocalizedString(@"qs_add_address_item_address_title");
    addressItem.placeholder = QSLocalizedString(@"qs_add_address_item_address_placeholder");
    addressItem.leftTitleFont = [UIFont qs_fontOfSize16];
    addressItem.showScanButton = YES;
    addressItem.scanClickedBlock = ^(QSAddAddressCell * _Nonnull cell) {
        DLog(@"点击扫码");
    };
    addressItem.cellHeight = kRealValue(55);
    
    QSAddAddressItem *groupItem = [[QSAddAddressItem alloc] init];
    groupItem.leftTitle = QSLocalizedString(@"qs_add_address_item_group_title");
    groupItem.placeholder = QSLocalizedString(@"qs_add_address_item_group_placeholder");
    groupItem.leftTitleFont = [UIFont qs_fontOfSize16];
    groupItem.showTextField = YES;
    groupItem.cellHeight = kRealValue(55);

    QSAddAddressItem *nameItem = [[QSAddAddressItem alloc] init];
    nameItem.leftTitle = QSLocalizedString(@"qs_add_address_item_name_title");
    nameItem.placeholder = QSLocalizedString(@"qs_add_address_item_name_placeholder");
    nameItem.leftTitleFont = [UIFont qs_fontOfSize16];
    nameItem.showTextField = YES;
    nameItem.cellHeight = kRealValue(55);

    QSAddAddressItem *phoneItem = [[QSAddAddressItem alloc] init];
    phoneItem.leftTitle = QSLocalizedString(@"qs_add_address_item_phone_title");
    phoneItem.placeholder = QSLocalizedString(@"qs_add_address_item_phone_placeholder");
    phoneItem.leftTitleFont = [UIFont qs_fontOfSize16];
    phoneItem.showTextField = YES;
    phoneItem.textFieldTextChangedBlock = ^(QSAddAddressCell * _Nonnull cell) {
        DLog(@"电话文字改变%@",cell.addressItem.textFieldText);
    };
    phoneItem.cellHeight = kRealValue(55);

    QSAddAddressItem *memoItem = [[QSAddAddressItem alloc] init];
    memoItem.leftTitle = QSLocalizedString(@"qs_add_address_item_memo_title");
    memoItem.placeholder = QSLocalizedString(@"qs_add_address_item_memo_placeholder");
    memoItem.leftTitleFont = [UIFont qs_fontOfSize16];
    memoItem.showTextField = YES;
    memoItem.cellHeight = kRealValue(55);

    self.dataArray = [@[typeItem,
                        addressItem,
                        groupItem,
                        nameItem,
                        phoneItem,
                        memoItem] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - **************** Event Response
- (void)saveButtonClicked {
    DLog(@"保存");
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSAddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    QSAddAddressItem *item = self.dataArray[indexPath.row];
    if (item.showTextField) {
        [cell configureLeftTitleAndInputSubViewsWithItem:item];
    } else if (item.showScanButton) {
        [cell configureScanSubViewsWithItem:item];
    } else if (item.showTypeButton) {
        [cell configureTypeButtonSubViewsWithItem:item];
    }
    
    [cell addSectionCornerWithTableView:tableView indexPath:indexPath
                        cornerViewframe:CGRectMake(0, 0, item.cellWidth, item.cellHeight)
                           cornerRadius:8];
    cell.separatorInset = UIEdgeInsetsMake(0, item.leftSubviewMargin, 0, 0);
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSAddAddressItem *item = self.dataArray[indexPath.row];
    return item.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - **************** Setter Getter
- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kBottomButtonWidth , kBottomButtonHeight + kRealValue(30))];
        
        UIButton *saveButton = [self createBottomButtonWithTitle:QSLocalizedString(@"qs_add_address_save_btn_title")
                                                          target:self
                                                          action:@selector(saveButtonClicked)];
        saveButton.frame = CGRectMake(0, kRealValue(30), kBottomButtonWidth, kBottomButtonHeight);
        [_footerView addSubview:saveButton];
    }
    return _footerView;
}

@end
