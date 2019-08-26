//
//  QSEveriPassTransferConfirmViewController.m
//  EVT-Wallet
//
//  Created by SJ on 2019/8/6.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSEveriPassTransferConfirmViewController.h"
#import "QSEveriPassTransferConfirmCell.h"
#import "QSEveriPassTransferConfirmItem.h"

@interface QSEveriPassTransferConfirmViewController ()

@property (nonatomic, strong) UIView *domainNameView;
@property (nonatomic, strong) UIView *submitButtonView;

@end

@implementation QSEveriPassTransferConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_transfer_nft_confirm_transfer_nav_title")];
    
    self.tableView.estimatedRowHeight = kRealValue(100);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableHeaderView = self.domainNameView;
    self.tableView.tableFooterView = self.submitButtonView;
    
    QSEveriPassTransferConfirmItem *payerItem = [[QSEveriPassTransferConfirmItem alloc] init];
    payerItem.title = QSLocalizedString(@"qs_transfer_nft_confirm_transfer_payer_title");
    payerItem.content = QSPublicKey;
    payerItem.cellIdentifier = NSStringFromClass([QSEveriPassTransferConfirmCell class]);
    payerItem.cellHeight = 0;
    [self.dataArray addObject:payerItem];
    
    QSEveriPassTransferConfirmItem *payeeItem = [[QSEveriPassTransferConfirmItem alloc] init];
    payeeItem.title = QSLocalizedString(@"qs_transfer_nft_confirm_transfer_payee_title");
    payeeItem.content = [self getPayeesContent];
    payeeItem.cellIdentifier = NSStringFromClass([QSEveriPassTransferConfirmCell class]);
    payeeItem.cellHeight = 0;
    [self.dataArray addObject:payeeItem];
    
    [self.tableView reloadData];
    
    [self tableViewShouldUpdateDataByPageIndex:1];
}

- (void)tableViewShouldUpdateDataByPageIndex:(NSInteger)pageIndex {
    [QSAppKeyWindow showIndeterminateHudWithText:QSLocalizedString(@"qs_waiting_toast")];
    [[QSEveriApiWebViewController sharedWebView] getEstimatedChargeForTransaction:self.actions andCompeleteBlock:^(NSInteger statusCode, NSString * _Nonnull chargeString) {
        if (statusCode == kResponseSuccessCode) {
            [QSAppKeyWindow hideHud];
            QSEveriPassTransferConfirmItem *feeItem = [[QSEveriPassTransferConfirmItem alloc] init];
            feeItem.title = QSLocalizedString(@"qs_transfer_nft_confirm_transfer_fee_title");
            feeItem.content = chargeString;
            feeItem.cellIdentifier = NSStringFromClass([QSEveriPassTransferConfirmCell class]);
            feeItem.cellHeight = 0;
            [self.dataArray addObject:feeItem];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - ***************** Private Methods
- (NSString *)getPayeesContent {
    if ([self.actions.allKeys containsObject:@"to"]) {
        NSArray *payees = self.actions[@"to"];
        NSString *payeesContent = @"";
        for (int i = 0; i < payees.count; i++) {
            if (i == 0) {
                payeesContent = payees[i];
            } else {
                payeesContent = [NSString stringWithFormat:@"%@\n%@",payeesContent,payees[i]];
            }
        }
        return payeesContent;
    }
    
    return nil;
}

#pragma mark - ***************** Event Response
- (void)submitButtonClicked {
    /*
     actions: {domain:'333',name:'521521',to:['EVT7Q3hQ6rjTsyus4vE4aDxCvFxfSSC3jJi8E3GzmpGq24UdqQp7w'],memo:''}
     */
    [QSAppKeyWindow showIndeterminateHudWithText:QSLocalizedString(@"qs_waiting_toast")];
    [[QSEveriApiWebViewController sharedWebView] pushTransactionByActionName:@"transfer"
                                                                     actions:self.actions
                                                                      config:nil
                                                                      domain:self.actions[@"domain"]
                                                                         key:self.actions[@"name"]
                                                           completionHandler:^(NSInteger statusCode, NSDictionary * _Nonnull responseDic)
     {
         if (statusCode == kResponseSuccessCode) {
             [QSAppKeyWindow hideHud];
             if (self.everiPassTransferConfirmSuccessBlock) {
                 self.everiPassTransferConfirmSuccessBlock();
             }
         }
     }];
}

#pragma mark - ***************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<id<QSBaseCellItemDataProtocol>> *)createSingleSectionDataSource {
    return self.dataArray;
}

#pragma mark - ***************** Setter Getter
- (UIView *)domainNameView {
    if (!_domainNameView) {
        _domainNameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - kRealValue(30), kRealValue(30))];
        NSString *title;
        if ([self.actions.allKeys containsObject:@"name"]) {
            title = self.actions[@"name"];
        }
        UILabel *domainLabel = [UILabel labelWithName:title font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
        domainLabel.frame = _domainNameView.bounds;
        [_domainNameView addSubview:domainLabel];
    }
    return _domainNameView;
}

- (UIView *)submitButtonView {
    if (!_submitButtonView) {
        _submitButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - kRealValue(30), kRealValue(90))];
        
        UIButton *submitButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_transfer_nft_confirm_transfer_btn_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize15] taget:self action:@selector(submitButtonClicked)];
        submitButton.backgroundColor = [UIColor qs_colorBlack313745];
        submitButton.layer.cornerRadius = 2;
        submitButton.frame = CGRectMake(0, kRealValue(30), _submitButtonView.width, kRealValue(40));
        [_submitButtonView addSubview:submitButton];
    }
    return _submitButtonView;
}

@end
