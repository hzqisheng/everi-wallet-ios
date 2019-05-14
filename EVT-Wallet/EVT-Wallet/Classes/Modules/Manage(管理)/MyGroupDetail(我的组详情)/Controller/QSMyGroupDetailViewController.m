//
//  QSMyGroupDetailViewController.m
//  EVT-Wallet
//
//  Created by SJ on 2019/5/9.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSMyGroupDetailViewController.h"
#import "QSEveriApiWebViewController.h"
#import "QSAddMetaDataViewController.h"
#import "QSEveriApiWebViewController.h"
#import "QSCreateGroupViewController.h"

#import "QSGroupDetailGroupNameView.h"
#import "QSMetaDataView.h"

@interface QSMyGroupDetailViewController ()

@property (nonatomic, strong) QSGroupDetailGroupNameView *groupNameView;
@property (nonatomic, strong) QSMetaDataView *metaDataView;

@property (nonatomic, strong) NSSet<MYTreeItem *> *allowEditingTreeItems;
@property (nonatomic, copy) NSString *threshold;

@end

@implementation QSMyGroupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBarTitle:self.groupName];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:QSLocalizedString(@"qs_manage_group_detail_authority_title") font:[UIFont qs_fontOfSize15] titleColor:[UIColor qs_colorWhiteFFFFFF] target:self action:@selector(rightBarButtonItemClicked)];
    
    [self requestData];
}

- (void)requestData {
    [[QSEveriApiWebViewController sharedWebView] getGroupDetailByGroupName:self.groupName andCompeleteBlock:^(NSInteger statusCode, NSDictionary * _Nullable data) {
        if (statusCode == kResponseSuccessCode) {
            [QSAppKeyWindow hideHud];
            
            NSString *name = data[@"name"];
            NSNumber *threshold;
            if ([data.allKeys containsObject:@"root"]) {
                NSDictionary *rootNode = data[@"root"];
                if ([rootNode.allKeys containsObject:@"threshold"]) {
                    threshold = data[@"root"][@"threshold"];
                }
            }
            self.threshold = threshold.stringValue;
            [self.groupNameView configureViewByGroupName:name threshold:threshold.stringValue];
            self.tableView.tableHeaderView = self.groupNameView;
            
            NSArray<QSMetas *> *metasModels = [QSMetas mj_objectArrayWithKeyValuesArray:data[@"metas"]];
            self.metaDataView.metas = metasModels;
            self.tableView.tableFooterView = self.metaDataView;
            
            self.allowEditingTreeItems = [self handleRequestOriginalData:data isAllowEditing:YES];

            NSSet *treeItems = [self handleRequestOriginalData:data isAllowEditing:NO];
            self.manager = [[MYTreeTableManager alloc] initWithItems:treeItems andExpandLevel:0];
            
            self.isShowExpandedAnimation = NO;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self expandAllItem:YES];
                self.isShowExpandedAnimation = YES;
            });
        }
    }];
}

#pragma mark - ***************** Event Response
- (void)rightBarButtonItemClicked {
    //Authority
    QSCreateGroupViewController *createGroup = [[QSCreateGroupViewController alloc] initWithGroupName:self.groupName
                                                                                            threshold:self.threshold
                                                                                            treeItems:self.allowEditingTreeItems];
    [createGroup setupNavgationBarTitle:QSLocalizedString(@"qs_manage_group_detail_authority_title")];
    createGroup.groupDidCreateSuccessBlock = ^{
        [QSAppKeyWindow showIndeterminateHudWithText:QSLocalizedString(@"qs_waiting_toast")];
        [self requestData];
    };
    [self.navigationController pushViewController:createGroup animated:YES];
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
                                                                 domain:@".group"
                                                                    key:self.groupName
                                                      andCompeleteBlock:^(NSInteger statusCode)
         {
             if (statusCode == kResponseSuccessCode) {
                 [self requestData];
             }
         }];
    };
    [self.navigationController pushViewController:addMetadata animated:YES];
}

#pragma mark - ***************** Setter Getter
- (QSGroupDetailGroupNameView *)groupNameView {
    if (!_groupNameView) {
        _groupNameView = [[QSGroupDetailGroupNameView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - kRealValue(30), kRealValue(140))];
    }
    return _groupNameView;
}

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

