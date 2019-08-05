//
//  QSEveriPassTransferLogViewController.m
//  EVT-Wallet
//
//  Created by SJ on 2019/8/5.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSEveriPassTransferLogViewController.h"
#import "QSEveriPassTransferAddressViewController.h"

#import "QSEveriPassTransferLogCell.h"

@interface QSEveriPassTransferLogViewController ()

@property (nonatomic, strong) UILabel *noDataLabel;

@end

@implementation QSEveriPassTransferLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_transfer_nft_log_nav_title")];
    
    self.noDataLabel.hidden = YES;
    [self.tableView addSubview:self.noDataLabel];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.estimatedRowHeight = kRealValue(100);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[QSEveriPassTransferLogCell class] forCellReuseIdentifier:@"QSEveriPassTransferLogCell"];
    [self setupBottomToolBar];
    [self addRefreshHeader];
    [self startRefreshing];
}

- (void)tableViewShouldUpdateDataByPageIndex:(NSInteger)pageIndex {
    
    [[QSEveriApiWebViewController sharedWebView] getNFTTrasferLogsByDomain:self.domain name:self.name andCompeleteBlock:^(NSInteger statusCode, NSArray<QSNFTTransferLog *> * _Nonnull transferLogList) {
        if (statusCode == kResponseSuccessCode) {
            self.noDataLabel.hidden = transferLogList.count;
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:transferLogList];
            [self.tableView reloadData];
        }
        [self endRefreshing];
    }];
}

- (void)setupBottomToolBar {
    UIView *bottomToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kNavgationBarHeight - kRealValue(65) - kiPhoneXSafeAreaBottomMagin, kScreenWidth, kRealValue(65))];
    bottomToolBar.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
    [self.view addSubview:bottomToolBar];
    
    self.tableView.height = bottomToolBar.y;
    self.noDataLabel.frame = self.tableView.bounds;
    
    UIButton *transferButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_transfer_nft_log_transfer_btn_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize15] taget:self action:@selector(transferButtonClicked)];
    transferButton.backgroundColor = [UIColor qs_colorBlack313745];
    transferButton.layer.cornerRadius = kRealValue(5);
    [self.view addSubview:transferButton];
    [transferButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomToolBar).offset(kRealValue(10));
        make.right.equalTo(bottomToolBar.mas_centerX).offset(-kRealValue(5));
        make.bottom.equalTo(bottomToolBar).offset(-kRealValue(10));
        make.left.equalTo(bottomToolBar).offset(kRealValue(15));
    }];
    
    UIButton *destroyButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_transfer_nft_log_distory_btn_title") titleColor:[UIColor qs_colorWhiteFFFFFF] font:[UIFont qs_fontOfSize15] taget:self action:@selector(destroyButtonClicked)];
    destroyButton.backgroundColor = [UIColor qs_colorBlue4D7BF3];
    destroyButton.layer.cornerRadius = kRealValue(5);
    [self.view addSubview:destroyButton];
    [destroyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomToolBar).offset(kRealValue(10));
        make.left.equalTo(bottomToolBar.mas_centerX).offset(kRealValue(5));
        make.bottom.equalTo(bottomToolBar).offset(-kRealValue(10));
        make.right.equalTo(bottomToolBar).offset(-kRealValue(15));
    }];
}

#pragma mark - ***************** Event Response
- (void)transferButtonClicked {
    QSEveriPassTransferAddressViewController *transfer = [[QSEveriPassTransferAddressViewController alloc] init];
    transfer.name = self.name;
    transfer.domain = self.domain;
    @weakify(self);
    transfer.everiPassTransferAddressSuccessBlock = ^{
        @strongify(self);
        [self startRefreshing];
    };
    [self.navigationController pushViewController:transfer animated:YES];
}

- (void)destroyButtonClicked {
    NSDictionary *actions = @{
                              @"domain":QSNoNilString(self.domain),
                              @"name":QSNoNilString(self.name)
                              };
    [[QSEveriApiWebViewController sharedWebView] pushTransactionByActionName:@"destroytoken"
                                                                     actions:actions
                                                                      config:nil
                                                                      domain:self.domain
                                                                         key:self.name
                                                           completionHandler:^(NSInteger statusCode, NSDictionary * _Nonnull responseDic)
     {
         if (statusCode == kResponseSuccessCode) {
             [self.navigationController popViewControllerAnimated:YES];
         }
     }];
}

#pragma mark - ***************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSEveriPassTransferLogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QSEveriPassTransferLogCell" forIndexPath:indexPath];
    cell.transferLog = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark - ***************** Setter Getter
- (UILabel *)noDataLabel {
    if (!_noDataLabel) {
        _noDataLabel = [UILabel labelWithName:QSLocalizedString(@"qs_transfer_nft_log_no_log_title") font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentCenter];
    }
    return _noDataLabel;
}

@end
