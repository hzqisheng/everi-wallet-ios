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
#import "QSMyPassCell.h"
#import "QSBlankPageView.h"

@interface QSMyPassViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) QSBlankPageView *blankPage;

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
    WeakSelf(weakSelf);
    cell.myPassCellClickMoreButtonBlock = ^(QSMyPassCell * _Nonnull passCell) {
        
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRealValue(100);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSBatchCreateNFTSViewController *vc = [[QSBatchCreateNFTSViewController alloc] init];
    vc.NFTModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - **************** Setter Getter
- (QSBlankPageView *)blankPage {
    if (!_blankPage) {
        _blankPage = [[QSBlankPageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - kRealValue(30), kScreenHeight - kNavgationBarHeight - kBottomButtonHeight - kiPhoneXSafeAreaBottomMagin - kRealValue(35))];
        _blankPage.hidden = YES;
        [self.tableView addSubview:_blankPage];
    }
    return _blankPage;
}

@end
