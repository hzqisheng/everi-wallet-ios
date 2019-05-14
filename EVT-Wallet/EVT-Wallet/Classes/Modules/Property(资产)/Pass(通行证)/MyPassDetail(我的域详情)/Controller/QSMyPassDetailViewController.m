//
//  QSMyPassDetailViewController.m
//  EVT-Wallet
//
//  Created by SJ on 2019/5/13.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSMyPassDetailViewController.h"
#import "QSEveriApiWebViewController.h"
#import "QSCreateNFTSViewController.h"
#import "QSAddMetaDataViewController.h"

#import "QSMyPassDetailNameItem.h"
#import "QSMyPassDetailPermissionItem.h"
#import "QSMetaDataView.h"

@interface QSMyPassDetailViewController ()

@property (nonatomic, strong) QSMetaDataView *metaDataView;

@property (nonatomic, strong) QSNFT *domainDetail;
@end

@implementation QSMyPassDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:QSLocalizedString(@"qs_pass_mypass_detail_authority_title") font:[UIFont qs_fontOfSize15] titleColor:[UIColor qs_colorWhiteFFFFFF] target:self action:@selector(rightBarButtonItemClicked)];

    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self startRefreshing];
}

#pragma mark - ***************** Refresh
- (void)tableViewShouldUpdateDataByPageIndex:(NSInteger)pageIndex {
    @weakify(self);
    [[QSEveriApiWebViewController sharedWebView] getDomainDetailByName:self.domainName andCompeleteBlock:^(NSInteger statusCode, QSNFT * _Nullable domainDetail) {
        @strongify(self);
        if (statusCode == kResponseSuccessCode) {
            [QSAppKeyWindow hideHud];
            
            self.domainDetail = domainDetail;
            
            QSMyPassDetailNameItem *nameItem = [[QSMyPassDetailNameItem alloc] init];
            nameItem.name = domainDetail.name;
            nameItem.issue_time = domainDetail.create_time;
            
            QSMyPassDetailPermissionItem *issue = [[QSMyPassDetailPermissionItem alloc] init];
            issue.name = QSLocalizedString(@"qs_pass_mypass_detail_issue_title");
            issue.authorizers = domainDetail.issue.authorizers;
            issue.threshold = domainDetail.issue.threshold;
            
            QSMyPassDetailPermissionItem *transfer = [[QSMyPassDetailPermissionItem alloc] init];
            transfer.name = QSLocalizedString(@"qs_pass_mypass_detail_transfer_title");
            transfer.authorizers = domainDetail.transfer.authorizers;
            transfer.threshold = domainDetail.transfer.threshold;
            
            QSMyPassDetailPermissionItem *manage = [[QSMyPassDetailPermissionItem alloc] init];
            manage.name = QSLocalizedString(@"qs_pass_mypass_detail_manage_title");
            manage.authorizers = domainDetail.manage.authorizers;
            manage.threshold = domainDetail.manage.threshold;
            
            self.dataArray = @[@[nameItem],
                               @[issue,transfer,manage]].mutableCopy;
            
            self.metaDataView.metas = domainDetail.metas;
            self.tableView.tableFooterView = self.metaDataView;
            
            [self reloadTableViewData];
        }
    }];
}

#pragma mark - ***************** Event Response
- (void)rightBarButtonItemClicked {
    if (!self.domainDetail) {
        return;
    }
    
    QSCreateNFTSViewController *authority = [[QSCreateNFTSViewController alloc] initWithDomain:self.domainDetail];
    @weakify(self);
    authority.createNFTSSuccessBlock = ^{
        @strongify(self);
        [QSAppKeyWindow showIndeterminateHudWithText:QSLocalizedString(@"qs_waiting_toast")];
        [self startRefreshing];
    };
    [authority setupNavgationBarTitle:QSLocalizedString(@"qs_pass_mypass_detail_authority_title")];
    [self.navigationController pushViewController:authority animated:YES];
}

- (void)addMetaDataClicked {
    QSAddMetaDataViewController *addMetadata = [[QSAddMetaDataViewController alloc] init];
    @weakify(self);
    addMetadata.addMetaDataBlock = ^(NSString * _Nonnull key, NSString * _Nonnull value) {
        @strongify(self);
        [QSAppKeyWindow showIndeterminateHudWithText:QSLocalizedString(@"qs_waiting_toast")];
        [[QSEveriApiWebViewController sharedWebView] addMetaByActionKey:key
                                                            actionValue:value
                                                          actionCreator:[NSString stringWithFormat:@"[A] %@",QSPublicKey]
                                                                 domain:self.domainName
                                                                    key:@".meta"
                                                      andCompeleteBlock:^(NSInteger statusCode)
         {
             if (statusCode == kResponseSuccessCode) {
                 [self startRefreshing];
             }
         }];
    };
    [self.navigationController pushViewController:addMetadata animated:YES];
}

#pragma mark - ***************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<NSArray<id<QSBaseCellItemDataProtocol>> *> *)createMultiSectionDataSource {
    return self.dataArray;
}

#pragma mark - ***************** Setter Getter
- (QSMetaDataView *)metaDataView {
    if (!_metaDataView) {
        _metaDataView = [[QSMetaDataView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - kRealValue(30), 0)];
        @weakify(self);
        _metaDataView.addMetaDataBlock = ^{
            @strongify(self);
            [self addMetaDataClicked];
        };
    }
    return _metaDataView;
}

@end
