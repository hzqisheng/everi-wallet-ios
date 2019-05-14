//
//  QSMyPassViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSMyPassViewController.h"
#import "QSCreateNFTSViewController.h"
#import "QSBatchCreateNFTSViewController.h"
#import "QSMyPassDetailViewController.h"

#import "QSMyPassCell.h"
#import "QSBlankPageView.h"

@interface QSMyPassViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *noDataView;

@end

static NSString * const kMyPassCell = @"myPassCell";

@implementation QSMyPassViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_pass_mypass_navi_title")];
    
    UIButton *bottomButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_pass_mypass_btn_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(bottomButtonClicked)];
    [bottomButton setImage:[UIImage imageNamed:@"icon_xuanzedaibi_plus"] forState:UIControlStateNormal];
    bottomButton.backgroundColor = [UIColor qs_colorBlack313745];
    bottomButton.layer.cornerRadius = 2;
    bottomButton.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
    bottomButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
    [self.view addSubview:bottomButton];
    CGFloat bottomButtonBottomMargin = kDevice_Is_iPhoneX ? kiPhoneXSafeAreaBottomMagin : kRealValue(15);
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-bottomButtonBottomMargin);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kBottomButtonWidth, kBottomButtonHeight));
    }];
    [self setupTableView];
}

- (void)tableViewShouldUpdateDataByPageIndex:(NSInteger)pageIndex {
    WeakSelf(weakSelf);
    [[QSEveriApiWebViewController sharedWebView] getEVTDomainsListWithPublicKey:[QSWalletHelper sharedHelper].currentEvt.publicKey andCompeleteBlock:^(NSInteger statusCode, NSArray * _Nonnull ftList) {
        if (statusCode == kResponseSuccessCode) {
            weakSelf.tableView.tableHeaderView = ftList.count ? nil : weakSelf.noDataView;
            if (weakSelf.dataArray.count) {
                [weakSelf.dataArray removeAllObjects];
            }
            weakSelf.dataArray = [NSMutableArray arrayWithArray:ftList];
            [weakSelf.tableView reloadData];
        }
    }];
    [self endRefreshing];
}

- (void)setupTableView {
    self.tableView.frame = CGRectMake(kRealValue(15), kRealValue(15), kRealValue(345), kScreenHeight - kNavgationBarHeight - kBottomButtonHeight - kiPhoneXSafeAreaBottomMagin - kRealValue(35));
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[QSMyPassCell class] forCellReuseIdentifier:kMyPassCell];
    [self addRefreshHeader];
}

#pragma mark - **************** Event Response
- (void)bottomButtonClicked {
    QSCreateNFTSViewController *vc = [[QSCreateNFTSViewController alloc] init];
    [vc setupNavgationBarTitle:QSLocalizedString(@"qs_pass_mypass_btn_title")];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - **************** TableView Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSMyPassCell *cell = [tableView dequeueReusableCellWithIdentifier:kMyPassCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.NFTModel = self.dataArray[indexPath.row];
    @weakify(self);
    cell.myPassCellClickMoreButtonBlock = ^(QSMyPassCell * _Nonnull passCell) {
        @strongify(self);
        QSBatchCreateNFTSViewController *vc = [[QSBatchCreateNFTSViewController alloc] init];
        [vc setupNavgationBarTitle:passCell.NFTModel.name];
        vc.NFTModel = passCell.NFTModel;
        [self.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRealValue(100);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSMyPassDetailViewController *detail = [[QSMyPassDetailViewController alloc] init];
    QSNFT *NFTModel = self.dataArray[indexPath.row];
    detail.domainName = NFTModel.name;
    [detail setupNavgationBarTitle:NFTModel.name];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - **************** Setter Getter
- (UIView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(345), kScreenHeight - kNavgationBarHeight - kBottomButtonHeight - kiPhoneXSafeAreaBottomMagin - kRealValue(35))];
        UILabel *noDataLabel = [UILabel labelWithName:QSLocalizedString(@"qs_pass_mypass_no_pass_title") font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentCenter];
        noDataLabel.frame = _noDataView.bounds;
        [_noDataView addSubview:noDataLabel];
    }
    return _noDataView;
}

@end
