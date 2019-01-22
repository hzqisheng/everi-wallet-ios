//
//  QSCreateFTViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/11.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateFTViewController.h"
#import "QSCreateFTTextCell.h"
#import "QSCreateFTIconCell.h"
#import "QSCreateFTAlertCell.h"
#import "QSCreateFTItem.h"
#import "QSCreateFTIconItem.h"
#import "QSCreateFTAlertItem.h"
#import "QSAuthorizers.h"
#import "QSIssueFTNFTHelpPopupView.h"

@interface QSCreateFTViewController ()

@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *shortName;
@property (nonatomic, copy) NSString *assetNumber;
@property (nonatomic, copy) NSString *circulation;
@property (nonatomic, copy) NSString *precision;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, strong) UIImage *IconImage;
@property (nonatomic, assign) NSInteger permissions;

@property (nonatomic, weak) QSIssueFTNFTHelpPopupView *popupView;

@end

@implementation QSCreateFTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_select_ft_btn_titlte")];
    [self addSubButton];
    [self.view addSubview:self.tableView];
    self.tableView.height = kScreenHeight - kNavgationBarHeight - kRealValue(60) - self.submitButton.height - kiPhoneXSafeAreaBottomMagin;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_chuangjianyu_help"] target:self action:@selector(rightBarItemClicked)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<Class> *)getRigisterMultiCellClasses {
    return @[[QSCreateFTTextCell class],[QSCreateFTIconCell class],[QSCreateFTAlertCell class]];
}

- (NSArray<NSArray<QSBaseCellItem *> *> *)createMultiSectionDataSource {
    //代币全称
    QSCreateFTItem *nameItem = [[QSCreateFTItem alloc] init];
    nameItem.cellIdentifier = NSStringFromClass([QSCreateFTTextCell class]);
    nameItem.cellHeight = kRealValue(70);
    nameItem.title = QSLocalizedString(@"qs_select_ft_full_name_title");
    nameItem.placeholde = QSLocalizedString(@"qs_select_ft_full_name_placeholder");
    WeakSelf(weakSelf);
    nameItem.createFTItemTextBlock = ^(NSString * _Nonnull text) {
        weakSelf.name = text;
    };
    nameItem.KeyboardType = UIKeyboardTypeAlphabet;
    
    //代币简称
    QSCreateFTItem *tokenItem = [[QSCreateFTItem alloc] init];
    tokenItem.cellIdentifier = NSStringFromClass([QSCreateFTTextCell class]);
    tokenItem.cellHeight = kRealValue(70);
    tokenItem.title = QSLocalizedString(@"qs_select_ft_token_title");
    tokenItem.placeholde = QSLocalizedString(@"qs_select_ft_token_placeholde");
    tokenItem.createFTItemTextBlock = ^(NSString * _Nonnull text) {
        weakSelf.shortName = text;
    };
    tokenItem.KeyboardType = UIKeyboardTypeAlphabet;
    
    //资产编号
    QSCreateFTItem *assetItem = [[QSCreateFTItem alloc] init];
    assetItem.cellIdentifier = NSStringFromClass([QSCreateFTTextCell class]);
    assetItem.cellHeight = kRealValue(70);
    assetItem.title = QSLocalizedString(@"qs_select_ft_assetNumbers_title");
    assetItem.placeholde = QSLocalizedString(@"qs_select_ft_assetNumbers_placeholde");
    assetItem.createFTItemTextBlock = ^(NSString * _Nonnull text) {
        weakSelf.assetNumber = text;
    };
    assetItem.KeyboardType = UIKeyboardTypePhonePad;
    
    //发行总量
    QSCreateFTItem *circulationItem = [[QSCreateFTItem alloc] init];
    circulationItem.cellIdentifier = NSStringFromClass([QSCreateFTTextCell class]);
    circulationItem.cellHeight = kRealValue(70);
    circulationItem.title = QSLocalizedString(@"qs_select_ft_circulation_title");
    circulationItem.placeholde = QSLocalizedString(@"qs_select_ft_circulation_placeholde");
    circulationItem.createFTItemTextBlock = ^(NSString * _Nonnull text) {
        weakSelf.circulation = text;
    };
    circulationItem.KeyboardType = UIKeyboardTypePhonePad;
    
    //精度
    QSCreateFTItem *precisionItem = [[QSCreateFTItem alloc] init];
    precisionItem.cellIdentifier = NSStringFromClass([QSCreateFTTextCell class]);
    precisionItem.cellHeight = kRealValue(70);
    precisionItem.title = QSLocalizedString(@"qs_select_ft_precision_title");
    precisionItem.placeholde = QSLocalizedString(@"qs_select_ft_precision_placeholde");
    precisionItem.createFTItemTextBlock = ^(NSString * _Nonnull text) {
        weakSelf.precision = text;
    };
    precisionItem.KeyboardType = UIKeyboardTypePhonePad;
    
    //图标
    QSCreateFTIconItem *iconItem = [[QSCreateFTIconItem alloc] init];
    iconItem.cellIdentifier = NSStringFromClass([QSCreateFTIconCell class]);
    iconItem.cellHeight = kRealValue(96);
    iconItem.title = QSLocalizedString(@"qs_select_ft_icon_title");
    iconItem.createFTIconItemSelectedImageBlock = ^(UIImage * _Nonnull image) {
        weakSelf.IconImage = image;
    };
    
    //权限
    QSCreateFTAlertItem *alertItem = [[QSCreateFTAlertItem alloc] init];
    alertItem.cellIdentifier = NSStringFromClass([QSCreateFTAlertCell class]);
    alertItem.cellHeight = kRealValue(87);
    alertItem.title = QSLocalizedString(@"qs_select_ft_permissions_title");
    alertItem.jurisdiction = 0;
    alertItem.createFTAlertItemJurisdictionBlock = ^(NSInteger jurisdiction) {
        weakSelf.permissions = jurisdiction;
    };
    return @[@[tokenItem,nameItem,assetItem,circulationItem,precisionItem,iconItem,alertItem]];
}

#pragma mark - **************** Event
- (void)bottomButtonClicked {
    if (!self.shortName.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_select_ft_token_placeholde")];
        return;
    }
    if (!self.name.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_select_ft_full_name_placeholder")];
        return;
    }
    if (!self.assetNumber.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_select_ft_assetNumbers_placeholde")];
        return;
    }
    if (!self.circulation.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_select_ft_circulation_placeholde")];
        return;
    }
    if (!self.precision.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_select_ft_precision_placeholde")];
        return;
    }
    if (!self.IconImage) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_select_ft_no_icon_toast")];
        return;
    }
    
    QSFT *ftmodel = [[QSFT alloc] init];
    ftmodel.name = self.name;
    ftmodel.sym_name = self.shortName;
    ftmodel.assetNumber = self.assetNumber;
    ftmodel.sym = [NSString stringWithFormat:@"%@,S#%@",self.precision,self.assetNumber];
    ftmodel.creator = [QSWalletHelper sharedHelper].currentEvt.publicKey;
    QSFTIssue *issue = [[QSFTIssue alloc] init];
    issue.name = @"issue";
    QSFTManage *manage = [[QSFTManage alloc] init];
    manage.name = @"manage";
    QSAuthorizers *authorizers = [[QSAuthorizers alloc] init];
    authorizers.ref = [NSString stringWithFormat:@"[A] %@",QSPublicKey];
    authorizers.weight = 1;
    if (self.permissions == 0) {
        issue.threshold = 1;
        manage.threshold = 0;
        NSArray * authArr = @[authorizers];
        issue.authorizers = [NSArray arrayWithArray:authArr];
    } else if (self.permissions == 1) {
        issue.threshold = 1;
        manage.threshold = 1;
        NSArray * authArr = @[authorizers];
        issue.authorizers = [NSArray arrayWithArray:authArr];
        manage.authorizers = [NSArray arrayWithArray:authArr];
    }
    ftmodel.issue = issue;
    ftmodel.manage = manage;
    NSString *jinduStr = [NSString stringWithFormat:@"%@.",self.circulation];
    for (int i = 0 ; i < [self.precision integerValue]; i++) {
        jinduStr = [jinduStr stringByAppendingString:@"0"];
    }
    ftmodel.total_supply = [NSString stringWithFormat:@"%@ S#%@",jinduStr,self.assetNumber];

    [QSAppKeyWindow showIndeterminateHudWithText:QSLocalizedString(@"qs_language_setting_change_toast")];
    NSData *data = UIImageJPEGRepresentation(self.IconImage, 0.1);
    NSString *encodedImageStr = [data base64EncodedString];
    
    WeakSelf(weakSelf);
    [[QSEveriApiWebViewController sharedWebView] pushTransactionWithActionName:@"newfungible" andFt:ftmodel andConfig:encodedImageStr andCompeleteBlock:^(NSInteger statusCode, QSFT * _Nonnull ftmodel) {
        if (statusCode == kResponseSuccessCode) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [QSAppKeyWindow hideHud];
        }
    }];
}

- (void)rightBarItemClicked {
    NSArray *titleList = @[QSLocalizedString(@"qs_create_ft_issueFTs_help_title"),QSLocalizedString(@"qs_create_ft_symbol_help_title"),QSLocalizedString(@"qs_create_ft_asset_number_help_title"),QSLocalizedString(@"qs_create_ft_total_supply_help_title"),QSLocalizedString(@"qs_create_ft_decimals_help_title"),QSLocalizedString(@"qs_create_ft_icon_help_title")];
    NSArray *contentList = @[QSLocalizedString(@"qs_create_ft_issueFTs_help_content"),QSLocalizedString(@"qs_create_ft_symbol_help_content"),QSLocalizedString(@"qs_create_ft_asset_number_help_content"),QSLocalizedString(@"qs_create_ft_total_supply_help_content"),QSLocalizedString(@"qs_create_ft_decimals_help_content"),QSLocalizedString(@"qs_create_ft_icon_help_content")];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i < titleList.count; i++) {
        NSString *title = titleList[i];
        NSString *content = contentList[i];
        QSIssueFTNFTHelpModel *model = [[QSIssueFTNFTHelpModel alloc] initWithTitle:title content:content];
        [dataArray addObject:model];
    }
    
    if (self.popupView) {
        [self.popupView dissmiss];
    } else {
        self.popupView = [QSIssueFTNFTHelpPopupView showInView:self.view
                                                     dataArray:[dataArray copy]];
    }
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return kRealValue(10);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

#pragma mark - **************** Setter Getter
- (void)addSubButton {
    UIButton *bottomButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_select_ft_btn_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(bottomButtonClicked)];
    bottomButton.backgroundColor = [UIColor qs_colorBlack313745];
    bottomButton.layer.cornerRadius = 2;
    [self.view addSubview:bottomButton];
    CGFloat bottomButtonBottomMargin = kDevice_Is_iPhoneX ? kiPhoneXSafeAreaBottomMagin : kRealValue(15);
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-bottomButtonBottomMargin);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kBottomButtonWidth, kBottomButtonHeight));
    }];
    self.submitButton = bottomButton;
}

@end
