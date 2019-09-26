//
//  QSEveriPassTransferAddressViewController.m
//  EVT-Wallet
//
//  Created by SJ on 2019/8/5.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSEveriPassTransferAddressViewController.h"
#import "QSScanningViewController.h"
#import "QSEveriPassTransferConfirmViewController.h"

#import "QSEveriPassTransferAddressInputItem.h"
#import "QSEveriPassTransferAddressItem.h"
#import "QSEveriPassTransferAddressInputCell.h"
#import "QSEveriPassTransferAddressCell.h"

@interface QSEveriPassTransferAddressViewController ()

@property (nonatomic, strong) UIView *domainNameView;
@property (nonatomic, strong) UIView *submitButtonView;

@end

@implementation QSEveriPassTransferAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_transfer_nft_nav_title")];
    
    self.tableView.tableHeaderView = self.domainNameView;
    self.tableView.tableFooterView = self.submitButtonView;

    QSEveriPassTransferAddressInputItem *inputItem = [[QSEveriPassTransferAddressInputItem alloc] init];
    inputItem.cellIdentifier = NSStringFromClass([QSEveriPassTransferAddressInputCell class]);
    @weakify(self);
    inputItem.everiPassTransferAddressInputAddBlock = ^(NSString * _Nonnull text) {
        @strongify(self);
        [self everiPassTransferAddressInputAdd:text];
    };
    inputItem.everiPassTransferAddressInputScanBlock = ^(QSEveriPassTransferAddressInputItem * _Nonnull item) {
        @strongify(self);
        [self everiPassTransferAddressInputScan:item];
    };
    [self.dataArray addObject:inputItem];
    
    [self.tableView reloadData];
}

#pragma mark - ***************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<NSArray<id<QSBaseCellItemDataProtocol>> *> *)createMultiSectionDataSource {
    return self.dataArray;
}

#pragma mark - ***************** Private Methods
- (BOOL)checkAddresExist:(NSString *)address {
    for (QSBaseCellItem *item in self.dataArray) {
        if ([item isKindOfClass:[QSEveriPassTransferAddressItem class]]) {
            QSEveriPassTransferAddressItem * addressItem = (QSEveriPassTransferAddressItem *)item;
            if ([addressItem.address isEqualToString:address]) {
                return YES;
            }
        }
    }
    return NO;
}

#pragma mark - ***************** Event Response
- (void)everiPassTransferAddressInputAdd:(NSString *)text {
    if (!text.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_transfer_nft_address_placeholder")];
        return;
    }
    @weakify(self);
    [[QSEveriApiWebViewController sharedWebView] checkValidPublicKey:text andCompeleteBlock:^(NSInteger statusCode, BOOL isValid) {
        @strongify(self);
        if (statusCode == kResponseSuccessCode) {
            if (isValid) {
                if ([self checkAddresExist:text]) {
                    [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_transfer_nft_address_exist_title")];
                    return;
                }
                QSEveriPassTransferAddressInputItem *inputItem = self.dataArray.firstObject;
                inputItem.inputText = @"";
                
                QSEveriPassTransferAddressItem *addressItem = [[QSEveriPassTransferAddressItem alloc] init];
                addressItem.cellIdentifier = NSStringFromClass([QSEveriPassTransferAddressCell class]);
                addressItem.address = text;
                addressItem.everiPassTransferAddressDeleteBlock = ^(QSEveriPassTransferAddressItem * _Nonnull item) {
                    [self.dataArray removeObject:item];
                    [self.tableView reloadData];
                };
                [self.dataArray addObject:addressItem];
                [self.tableView reloadData];
            } else {
                [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_transfer_nft_address_error_title")];
            }
        }
    }];
}

- (void)oneceAddressForNextStep:(NSString *)text {
    if (!text.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_transfer_nft_address_placeholder")];
        return;
    }
    @weakify(self);
    [[QSEveriApiWebViewController sharedWebView] checkValidPublicKey:text andCompeleteBlock:^(NSInteger statusCode, BOOL isValid) {
        @strongify(self);
        if (statusCode == kResponseSuccessCode) {
            if (isValid) {
                if ([self checkAddresExist:text]) {
                    [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_transfer_nft_address_exist_title")];
                    return;
                }
                QSEveriPassTransferAddressInputItem *inputItem = self.dataArray.firstObject;
                inputItem.inputText = @"";
                
                QSEveriPassTransferAddressItem *addressItem = [[QSEveriPassTransferAddressItem alloc] init];
                addressItem.cellIdentifier = NSStringFromClass([QSEveriPassTransferAddressCell class]);
                addressItem.address = text;
                addressItem.everiPassTransferAddressDeleteBlock = ^(QSEveriPassTransferAddressItem * _Nonnull item) {
                    [self.dataArray removeObject:item];
                    [self.tableView reloadData];
                };
                [self.dataArray addObject:addressItem];
                [self.tableView reloadData];
                
                NSMutableArray *addressList = [NSMutableArray array];
                
                for (QSBaseCellItem *item in self.dataArray) {
                    if ([item isKindOfClass:[QSEveriPassTransferAddressItem class]]) {
                        QSEveriPassTransferAddressItem * addressItem = (QSEveriPassTransferAddressItem *)item;
                        [addressList addObject:addressItem.address];
                    }
                }
                NSDictionary *actionDic = @{
                                            @"domain" : QSNoNilString(self.domain),
                                            @"name"   : QSNoNilString(self.name),
                                            @"to"     : addressList.copy,
                                            @"memo"   : @""
                                            };
                
                QSEveriPassTransferConfirmViewController *confirm = [[QSEveriPassTransferConfirmViewController alloc] init];
                confirm.actions = actionDic;
                @weakify(self);
                confirm.everiPassTransferConfirmSuccessBlock = ^{
                    @strongify(self);
                    if (self.everiPassTransferAddressSuccessBlock) {
                        self.everiPassTransferAddressSuccessBlock();
                    }
                    [self.navigationController popToViewControllerWithClassName:@"QSEveriPassTransferLogViewController" animated:YES];
                };
                [self.navigationController pushViewController:confirm animated:YES];
            } else {
                [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_transfer_nft_address_error_title")];
            }
        }
    }];
}


- (void)everiPassTransferAddressInputScan:(QSEveriPassTransferAddressInputItem *)inputItem {
    QSScanningViewController *scan = [[QSScanningViewController alloc] init];
    @weakify(self);
    scan.parseEvtLinkAndPopBlock = ^(NSString * _Nonnull publicKey) {
        @strongify(self);
        inputItem.inputText = publicKey;
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:scan animated:YES];
}

- (void)submitButtonClicked {
    
    //一个cell输入地址可以直接点击下一步
    if (self.dataArray.count == 1) {
        QSBaseCellItem *item = self.dataArray.firstObject;
        if ([item isKindOfClass:[QSEveriPassTransferAddressInputItem class]]) {
            QSEveriPassTransferAddressInputItem * addressItem = (QSEveriPassTransferAddressInputItem *)item;
            [self oneceAddressForNextStep:addressItem.inputText];
            return;
        }
    }
    
    NSMutableArray *addressList = [NSMutableArray array];
    
    for (QSBaseCellItem *item in self.dataArray) {
        if ([item isKindOfClass:[QSEveriPassTransferAddressItem class]]) {
            QSEveriPassTransferAddressItem * addressItem = (QSEveriPassTransferAddressItem *)item;
            [addressList addObject:addressItem.address];
        }
    }
    
    
    if (!addressList.count) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_transfer_nft_address_placeholder")];
        return;
    }
    
    /*
     {domain:'333',name:'521521',to:['EVT7Q3hQ6rjTsyus4vE4aDxCvFxfSSC3jJi8E3GzmpGq24UdqQp7w'],memo:''}
     */
    
    NSDictionary *actionDic = @{
                                @"domain" : QSNoNilString(self.domain),
                                @"name"   : QSNoNilString(self.name),
                                @"to"     : addressList.copy,
                                @"memo"   : @""
                                };
    
    QSEveriPassTransferConfirmViewController *confirm = [[QSEveriPassTransferConfirmViewController alloc] init];
    confirm.actions = actionDic;
    @weakify(self);
    confirm.everiPassTransferConfirmSuccessBlock = ^{
        @strongify(self);
        if (self.everiPassTransferAddressSuccessBlock) {
            self.everiPassTransferAddressSuccessBlock();
        }
        [self.navigationController popToViewControllerWithClassName:@"QSEveriPassTransferLogViewController" animated:YES];
    };
    [self.navigationController pushViewController:confirm animated:YES];
}

#pragma mark - ***************** Setter Getter
- (UIView *)domainNameView {
    if (!_domainNameView) {
        _domainNameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - kRealValue(30), kRealValue(30))];
        
        UILabel *domainLabel = [UILabel labelWithName:self.name font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
        domainLabel.frame = _domainNameView.bounds;
        [_domainNameView addSubview:domainLabel];
    }
    return _domainNameView;
}

- (UIView *)submitButtonView {
    if (!_submitButtonView) {
        _submitButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - kRealValue(30), kRealValue(90))];
        
        UIButton *submitButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_transfer_nft_next_btn_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize15] taget:self action:@selector(submitButtonClicked)];
        submitButton.backgroundColor = [UIColor qs_colorBlack313745];
        submitButton.layer.cornerRadius = 2;
        submitButton.frame = CGRectMake(0, kRealValue(30), _submitButtonView.width, kRealValue(40));
        [_submitButtonView addSubview:submitButton];
    }
    return _submitButtonView;
}

@end
