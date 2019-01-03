//
//  QSIssueSelectAddressViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSIssueSelectAddressViewController.h"
#import "QSManageAddressCell.h"
#import "QSAddressHelper.h"

@interface QSIssueSelectAddressViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

static NSString * const kSelectAddressCell = @"selectAddressCell";

@implementation QSIssueSelectAddressViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_issue_issue_select_address_title")];
    
    UIButton *bottomButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_issue_issue_confirm_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(bottomButtonClicked)];
    bottomButton.backgroundColor = [UIColor qs_colorBlack313745];
    bottomButton.layer.cornerRadius = 2;
    [self.view addSubview:bottomButton];
    CGFloat bottomButtonBottomMargin = kDevice_Is_iPhoneX ? kiPhoneXSafeAreaBottomMagin : kRealValue(15);
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-bottomButtonBottomMargin);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kBottomButtonWidth, kBottomButtonHeight));
    }];
    [self setupTableView];
}

- (void)setupTableView {
    [self addRefreshHeader];
    self.tableView.frame = CGRectMake(kRealValue(15), 0, kRealValue(345), kScreenHeight - kNavgationBarHeight - kBottomButtonHeight - kiPhoneXSafeAreaBottomMagin - kRealValue(35));
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[QSManageAddressCell class] forCellReuseIdentifier:kSelectAddressCell];
}

- (void)tableViewShouldUpdateDataByPageIndex:(NSInteger)pageIndex {
    if (self.dataArray.count) {
        [self.dataArray removeAllObjects];
    }
    self.dataArray = [NSMutableArray arrayWithArray:[[QSAddressHelper sharedHelper] getAddress]];
    [self.tableView reloadData];
    [self endRefreshing];
}

#pragma mark - **************** Event Response
- (void)bottomButtonClicked {
    
}

#pragma mark - **************** TableView Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSManageAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:kSelectAddressCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.addressModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRealValue(100);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSAddress *addressModel = self.dataArray[indexPath.row];
    if (self.issueSelectAddressViewControllerChooseAddressBlock) {
        self.issueSelectAddressViewControllerChooseAddressBlock(addressModel.publicKey);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - **************** Setter Getter

@end
