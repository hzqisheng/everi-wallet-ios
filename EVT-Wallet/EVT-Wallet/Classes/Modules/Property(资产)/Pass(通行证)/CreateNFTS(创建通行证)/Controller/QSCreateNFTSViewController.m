//
//  QSCreateNFTSViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateNFTSViewController.h"
#import "QSCreateNFTAddGroupViewController.h"

#import "QSIssueFTNFTHelpPopupView.h"
#import "QSAddAddressPopupView.h"

#import "QSCreateNFTDomainNameItem.h"
#import "QSCreateNFTPermissionNameItem.h"
#import "QSCreateNFTThresholdItem.h"
#import "QSCreateNFTAuthorizerItem.h"

@interface QSCreateNFTSViewController ()

@property (nonatomic, weak) QSIssueFTNFTHelpPopupView *popupView;
@property (nonatomic, strong) UIView *submitButtonView;

@property (nonatomic, strong) QSNFT *domainDetail;
@property (nonatomic, assign, getter=isAuthoritySetting) BOOL authoritySetting;

@end

@implementation QSCreateNFTSViewController

- (instancetype)initWithDomain:(QSNFT *)domain {
    if (self = [super init]) {
        _domainDetail = domain;
        _authoritySetting = domain != nil;
        
        if (!_domainDetail) {
            _domainDetail = [[QSNFT alloc] init];
        }
    }
    return self;
}

- (instancetype)init {
    return [self initWithDomain:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.domainDetail.name) {
        UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_chuangjianyu_help"] target:self action:@selector(rightBarItemClicked)];
        self.navigationItem.rightBarButtonItem = rightBarItem;
    }
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = self.submitButtonView;
    
    [self createDefaultDataSource];
}

- (void)createDefaultDataSource {
    [self.dataArray removeAllObjects];
    
    //处理 发行 转移 管理 的默认数据
    if (!self.domainDetail.creator.length) {
        self.domainDetail.creator = QSPublicKey;
    }
    
    if (self.domainDetail.issue.threshold == 0) {
        self.domainDetail.issue.threshold = 1;
    }
    if (!self.domainDetail.issue.authorizers.count) {
        QSAuthorizers *authorizers = [[QSAuthorizers alloc] init];
        authorizers.ref = [NSString stringWithFormat:@"[A] %@",QSPublicKey];
        authorizers.weight = 1;
        self.domainDetail.issue.authorizers = @[authorizers];
    }
    if (!self.domainDetail.issue.name.length) {
        self.domainDetail.issue.name = @"issue";
    }
    
    if (self.domainDetail.transfer.threshold == 0) {
        self.domainDetail.transfer.threshold = 1;
    }
    if (!self.domainDetail.transfer.authorizers.count) {
        QSAuthorizers *authorizers = [[QSAuthorizers alloc] init];
        authorizers.ref = @"[G] .OWNER";
        authorizers.weight = 1;
        self.domainDetail.transfer.authorizers = @[authorizers];
    }
    if (!self.domainDetail.transfer.name.length) {
        self.domainDetail.transfer.name = @"transfer";
    }
    
    if (self.domainDetail.manage.threshold == 0) {
        self.domainDetail.manage.threshold = 1;
    }
    if (!self.domainDetail.manage.authorizers.count) {
        QSAuthorizers *authorizers = [[QSAuthorizers alloc] init];
        authorizers.ref = [NSString stringWithFormat:@"[A] %@",QSPublicKey];
        authorizers.weight = 1;
        self.domainDetail.manage.authorizers = @[authorizers];
    }
    if (!self.domainDetail.manage.name.length) {
        self.domainDetail.manage.name = @"manage";
    }
    
    //开始创建tableview的数据源
    //域
    QSCreateNFTDomainNameItem *domainNameItem = [[QSCreateNFTDomainNameItem alloc] init];
    domainNameItem.domainName = self.domainDetail.name;
    @weakify(self);
    domainNameItem.domainNameDidChangeBlock = ^(NSString * _Nonnull domainName) {
        @strongify(self);
        self.domainDetail.name = domainName;
    };
    if (!self.isAuthoritySetting) {
        [self.dataArray addObject:@[domainNameItem]];
    }
    
    //发行
    NSArray *permissionModelList = self.permissionModelList;
    NSArray *permissionTitleList = self.permissionTitleList;
    
    NSInteger nowDataSection = self.dataArray.count;
    
    for (int i = 0; i < permissionModelList.count; i++) {
        
        QSNFTTransfer *model = permissionModelList[i];
        
        NSMutableArray *permissionItemList = [NSMutableArray array];
        
        //标题
        QSCreateNFTPermissionNameItem *titleItem = [[QSCreateNFTPermissionNameItem alloc] init];
        titleItem.permissionName = permissionTitleList[i];
        @weakify(self);
        titleItem.addPermissionClickedBlock = ^(QSCreateNFTPermissionNameItem * _Nonnull item) {
            @strongify(self);
            NSInteger itemSection = i + nowDataSection;
            [self addAuthorizerClickedInSection:itemSection];
        };
        [permissionItemList addObject:titleItem];
        
        //threshold
        QSCreateNFTThresholdItem *thresholdItem = [[QSCreateNFTThresholdItem alloc] init];
        thresholdItem.threshold = model.threshold;
        thresholdItem.thresholdDidChangeBlock = ^(NSInteger threshold) {
            model.threshold = threshold;
        };
        [permissionItemList addObject:thresholdItem];
        
        //authorizers
        for (QSAuthorizers *authorizers in model.authorizers) {
            QSCreateNFTAuthorizerItem *issueAuthorizerItem = [[QSCreateNFTAuthorizerItem alloc] init];
            issueAuthorizerItem.authorizer = [NSString stringWithFormat:@"%@,%ld",authorizers.ref, (long)authorizers.weight];
            [permissionItemList addObject:issueAuthorizerItem];
            issueAuthorizerItem.deleteAuthorizerClickedBlock = ^(QSCreateNFTAuthorizerItem * _Nonnull item) {
                @strongify(self);
                NSInteger itemSection = i + nowDataSection;
                [self deleteAuthorizerItem:item authorizer:authorizers inTableViewSection:itemSection];
            };
        }
        
        //dataSource
        [self.dataArray addObject:permissionItemList.copy];
    }
    
    [self reloadTableViewData];
}

#pragma mark - ***************** Private Methods
- (NSArray<QSNFTTransfer *> *)permissionModelList {
    return @[self.domainDetail.issue, self.domainDetail.transfer, self.domainDetail.manage];
}

- (NSArray<NSString *> *)permissionTitleList {
    return @[QSLocalizedString(@"qs_pass_createNFTS_issue_title"), QSLocalizedString(@"qs_pass_createNFTS_transfer_title"), QSLocalizedString(@"qs_pass_createNFTS_manage_title")];
}

- (void)addAuthorizerClickedInSection:(NSInteger)section {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *group = [UIAlertAction actionWithTitle:QSLocalizedString(@"qs_pass_createNFTS_add_group_alert_title") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self addGroupClickedInSection:section];
    }];
    UIAlertAction *address = [UIAlertAction actionWithTitle:QSLocalizedString(@"qs_pass_createNFTS_add_address_alert_title") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self addAddressClickedInSection:section];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:QSLocalizedString(@"qs_pass_createNFTS_add_alert_cancel_title") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [alertController addAction:address];
    [alertController addAction:group];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)addAuthorizerItem:(QSCreateNFTAuthorizerItem *)authorizerItem
               authorizer:(QSAuthorizers *)authorizer
                inSection:(NSInteger)section {
    //添加到tableView数据源中
    NSArray *itemList = self.dataArray[section];
    NSMutableArray *mutableItemList = itemList.mutableCopy;
    [mutableItemList addObject:authorizerItem];
    self.dataArray[section] = mutableItemList.copy;
    [self reloadTableViewData];
    
    //打印
    NSArray *permissionList = self.dataArray[section];
    NSInteger itemRow = [permissionList indexOfObject:authorizerItem];
    DLog(@"itemSection:%ld，itemRow:%ld", (long)section, (long)itemRow);
    
    //添加到permissionModel中
    NSInteger modelIndex = [self modelIndexInTableViewSection:section];

    QSNFTTransfer *permissionModel = self.permissionModelList[modelIndex];
    NSMutableArray *mutableAuthorizers = [NSMutableArray arrayWithArray:permissionModel.authorizers];
    [mutableAuthorizers addObject:authorizer];
    permissionModel.authorizers = mutableAuthorizers.copy;
}

- (void)deleteAuthorizerItem:(QSCreateNFTAuthorizerItem *)authorizerItem
                  authorizer:(QSAuthorizers *)authorizer
      inTableViewSection:(NSInteger)section {
    //删除tableView数据源中的数据
    NSArray *itemList = self.dataArray[section];
    NSMutableArray *mutableItemList = itemList.mutableCopy;
    [mutableItemList removeObject:authorizerItem];
    self.dataArray[section] = mutableItemList.copy;
    [self reloadTableViewData];
    
    //打印
    NSArray *permissionList = self.dataArray[section];
    NSInteger itemRow = [permissionList indexOfObject:authorizerItem];
    DLog(@"itemSection:%ld，itemRow:%ld", (long)section, (long)itemRow);
    
    //删除permissionModel中的数据
    NSInteger modelIndex = [self modelIndexInTableViewSection:section];

    QSNFTTransfer *permissionModel = self.permissionModelList[modelIndex];
    NSMutableArray *mutableAuthorizers = [NSMutableArray arrayWithArray:permissionModel.authorizers];
    [mutableAuthorizers removeObject:authorizer];
    permissionModel.authorizers = mutableAuthorizers.copy;
}

#pragma mark - ***************** Event Response
- (void)rightBarItemClicked {
    if (self.popupView) {
        [self.popupView dissmiss];
    } else {
        QSIssueFTNFTHelpModel *domain = [[QSIssueFTNFTHelpModel alloc] initWithTitle:QSLocalizedString(@"qs_pass_domain_help_title") content:QSLocalizedString(@"qs_pass_domain_help_content")];
        self.popupView = [QSIssueFTNFTHelpPopupView showInView:self.view
                                                     dataArray:@[domain]];
    }
}

- (void)submitButtonClicked {
    //域名
    if (!self.domainDetail.name.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_pass_createNFTS_yu_placeholder")];
        return;
    }
    
    
    //authorizers
    if (!self.domainDetail.issue.authorizers.count
        || !self.domainDetail.transfer.authorizers.count
        || !self.domainDetail.manage.authorizers.count) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_pass_createNFTS_invaild_domain_toast")];
        return;
    }
    
    //threshold
    if (self.domainDetail.issue.threshold < 1
        || self.domainDetail.transfer.threshold < 1
        || self.domainDetail.manage.threshold < 1) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_pass_createNFTS_invaild_threshold_toast")];
        return;
    }
    
    NSString *actionName = @"newdomain";
    if (self.isAuthoritySetting) {
        actionName = @"updatedomain";
    }
    
    [QSAppKeyWindow showIndeterminateHudWithText:QSLocalizedString(@"qs_waiting_toast")];
    @weakify(self);
    [[QSEveriApiWebViewController sharedWebView] pushTransactionByActionName:actionName
                                                                     actions:self.domainDetail.mj_keyValues
                                                                      config:nil
                                                                      domain:nil
                                                                         key:nil
                                                           completionHandler:^(NSInteger statusCode, NSDictionary * _Nonnull responseDic) {
                                                               @strongify(self);
                                                               if (statusCode == kResponseSuccessCode) {
                                                                   [QSAppKeyWindow hideHud];
                                                                   if (self.createNFTSSuccessBlock) {
                                                                       self.createNFTSSuccessBlock();
                                                                   }
                                                                   [self.navigationController popViewControllerAnimated:YES];
                                                               }
                                                           }];
}

- (void)addGroupClickedInSection:(NSInteger)section {
    QSCreateNFTAddGroupViewController *addGroup = [[QSCreateNFTAddGroupViewController alloc] init];
    [addGroup setupNavgationBarTitle:QSLocalizedString(@"qs_pass_createNFTS_add_group_alert_title")];
    @weakify(self);
    addGroup.createNFTAddGroupConfirmBlock = ^(NSString * _Nonnull groupName, NSString * _Nonnull weight) {
        @strongify(self);
        QSAuthorizers *authorizer = [[QSAuthorizers alloc] init];
        authorizer.weight = weight.integerValue;
        authorizer.ref = [NSString stringWithFormat:@"[G] %@",groupName];
        
        QSCreateNFTAuthorizerItem *addressAuthorizerItem = [[QSCreateNFTAuthorizerItem alloc] init];
        addressAuthorizerItem.authorizer = [NSString stringWithFormat:@"%@,%ld",authorizer.ref,(long)authorizer.weight];
        addressAuthorizerItem.deleteAuthorizerClickedBlock = ^(QSCreateNFTAuthorizerItem * _Nonnull item) {
            @strongify(self);
            [self deleteAuthorizerItem:item
                            authorizer:authorizer
                    inTableViewSection:section];
        };
        
        [self addAuthorizerItem:addressAuthorizerItem
                     authorizer:authorizer
                      inSection:section];
    };
    [self.navigationController pushViewController:addGroup animated:YES];
}

- (NSInteger)modelIndexInTableViewSection:(NSInteger)section {
    NSInteger modelIndex = self.isAuthoritySetting ? section : section - 1;
    return modelIndex;
}

- (void)addAddressClickedInSection:(NSInteger)section {
    @weakify(self);
    [QSAddAddressPopupView showInView:self.view
                                title:self.permissionTitleList[[self modelIndexInTableViewSection:section]]
                         confirmBlock:^(NSString * _Nonnull publicKey, NSString * _Nonnull weight) {
                             [[QSEveriApiWebViewController sharedWebView] checkValidPublicKey:publicKey andCompeleteBlock:^(NSInteger statusCode, BOOL isValid) {
                                 @strongify(self);
                                 if (isValid) {
                                     QSAuthorizers *authorizer = [[QSAuthorizers alloc] init];
                                     authorizer.weight = weight.integerValue;
                                     authorizer.ref = [NSString stringWithFormat:@"[A] %@",publicKey];
                                     
                                     QSCreateNFTAuthorizerItem *addressAuthorizerItem = [[QSCreateNFTAuthorizerItem alloc] init];
                                     addressAuthorizerItem.authorizer = [NSString stringWithFormat:@"%@,%ld",authorizer.ref, (long)authorizer.weight];
                                     addressAuthorizerItem.deleteAuthorizerClickedBlock = ^(QSCreateNFTAuthorizerItem * _Nonnull item) {
                                         [self deleteAuthorizerItem:item
                                                         authorizer:authorizer
                                                 inTableViewSection:section];
                                     };
                                     
                                     [self addAuthorizerItem:addressAuthorizerItem
                                                  authorizer:authorizer
                                                   inSection:section];
                                 } else {
                                     [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_pass_createNFTS_invalid_public_key")];
                                 }
                             }];
                         }];
}

#pragma mark - ***************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<NSArray<id<QSBaseCellItemDataProtocol>> *> *)createMultiSectionDataSource {
    return self.dataArray.copy;
}

#pragma mark - ***************** Setter Getter
- (UIView *)submitButtonView {
    if (!_submitButtonView) {
        _submitButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - kRealValue(30), kRealValue(90))];
        
        UIButton *submitButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_pass_createNFTS_commit_btn_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize15] taget:self action:@selector(submitButtonClicked)];
        submitButton.backgroundColor = [UIColor qs_colorBlack313745];
        submitButton.layer.cornerRadius = 2;
        submitButton.frame = CGRectMake(0, kRealValue(30), _submitButtonView.width, kRealValue(40));
        [_submitButtonView addSubview:submitButton];
    }
    return _submitButtonView;
}

@end
