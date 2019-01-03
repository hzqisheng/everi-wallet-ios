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

@end

@implementation QSCreateFTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_select_ft_btn_titlte")];
    [self addSubButton];
    [self.view addSubview:self.tableView];
    self.tableView.height = kScreenHeight - kNavgationBarHeight - kRealValue(60) - self.submitButton.height - kiPhoneXSafeAreaBottomMagin;
    self.tableView.showsVerticalScrollIndicator = NO;
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<Class> *)getRigisterMultiCellClasses {
    return @[[QSCreateFTTextCell class],[QSCreateFTIconCell class],[QSCreateFTAlertCell class]];
}

- (NSArray<NSArray<QSBaseCellItem *> *> *)createMultiSectionDataSource {
    QSCreateFTItem *nameItem = [[QSCreateFTItem alloc] init];
    nameItem.cellIdentifier = NSStringFromClass([QSCreateFTTextCell class]);
    nameItem.cellHeight = kRealValue(70);
    nameItem.title = QSLocalizedString(@"qs_issue_ft_name_title");
    nameItem.placeholde = QSLocalizedString(@"qs_select_ft_token_placeholde");
    WeakSelf(weakSelf);
    nameItem.createFTItemTextBlock = ^(NSString * _Nonnull text) {
        weakSelf.name = text;
    };
    nameItem.KeyboardType = UIKeyboardTypeAlphabet;
    
    QSCreateFTItem *tokenItem = [[QSCreateFTItem alloc] init];
    tokenItem.cellIdentifier = NSStringFromClass([QSCreateFTTextCell class]);
    tokenItem.cellHeight = kRealValue(70);
    tokenItem.title = QSLocalizedString(@"qs_select_ft_token_title");
    tokenItem.placeholde = QSLocalizedString(@"qs_select_ft_token_placeholde");
    tokenItem.createFTItemTextBlock = ^(NSString * _Nonnull text) {
        weakSelf.shortName = text;
    };
    tokenItem.KeyboardType = UIKeyboardTypeAlphabet;
    
    QSCreateFTItem *assetItem = [[QSCreateFTItem alloc] init];
    assetItem.cellIdentifier = NSStringFromClass([QSCreateFTTextCell class]);
    assetItem.cellHeight = kRealValue(70);
    assetItem.title = QSLocalizedString(@"qs_select_ft_assetNumbers_title");
    assetItem.placeholde = QSLocalizedString(@"qs_select_ft_assetNumbers_placeholde");
    assetItem.createFTItemTextBlock = ^(NSString * _Nonnull text) {
        weakSelf.assetNumber = text;
    };
    assetItem.KeyboardType = UIKeyboardTypePhonePad;
    
    QSCreateFTItem *circulationItem = [[QSCreateFTItem alloc] init];
    circulationItem.cellIdentifier = NSStringFromClass([QSCreateFTTextCell class]);
    circulationItem.cellHeight = kRealValue(70);
    circulationItem.title = QSLocalizedString(@"qs_select_ft_circulation_title");
    circulationItem.placeholde = QSLocalizedString(@"qs_select_ft_circulation_placeholde");
    circulationItem.createFTItemTextBlock = ^(NSString * _Nonnull text) {
        weakSelf.circulation = text;
    };
    circulationItem.KeyboardType = UIKeyboardTypePhonePad;
    
    QSCreateFTItem *precisionItem = [[QSCreateFTItem alloc] init];
    precisionItem.cellIdentifier = NSStringFromClass([QSCreateFTTextCell class]);
    precisionItem.cellHeight = kRealValue(70);
    precisionItem.title = QSLocalizedString(@"qs_select_ft_precision_title");
    precisionItem.placeholde = QSLocalizedString(@"qs_select_ft_precision_placeholde");
    precisionItem.createFTItemTextBlock = ^(NSString * _Nonnull text) {
        weakSelf.precision = text;
    };
    precisionItem.KeyboardType = UIKeyboardTypePhonePad;
    
//    QSCreateFTItem *moneyItem = [[QSCreateFTItem alloc] init];
//    moneyItem.cellIdentifier = NSStringFromClass([QSCreateFTTextCell class]);
//    moneyItem.cellHeight = kRealValue(70);
//    moneyItem.title = QSLocalizedString(@"qs_select_ft_money_title");
//    moneyItem.placeholde = QSLocalizedString(@"qs_select_ft_money_placeholde");
//    moneyItem.createFTItemTextBlock = ^(NSString * _Nonnull text) {
//        weakSelf.money = text;
//    };
//    moneyItem.KeyboardType = UIKeyboardTypePhonePad;
    
    QSCreateFTIconItem *iconItem = [[QSCreateFTIconItem alloc] init];
    iconItem.cellIdentifier = NSStringFromClass([QSCreateFTIconCell class]);
    iconItem.cellHeight = kRealValue(96);
    iconItem.title = QSLocalizedString(@"qs_select_ft_icon_title");
    iconItem.createFTIconItemSelectedImageBlock = ^(UIImage * _Nonnull image) {
        weakSelf.IconImage = image;
    };
    
    QSCreateFTAlertItem *alertItem = [[QSCreateFTAlertItem alloc] init];
    alertItem.cellIdentifier = NSStringFromClass([QSCreateFTAlertCell class]);
    alertItem.cellHeight = kRealValue(87);
    alertItem.title = QSLocalizedString(@"qs_select_ft_permissions_title");
    alertItem.jurisdiction = 0;
    alertItem.createFTAlertItemJurisdictionBlock = ^(NSInteger jurisdiction) {
        weakSelf.permissions = jurisdiction;
    };
    return @[@[nameItem,tokenItem,assetItem,circulationItem,precisionItem,iconItem,alertItem]];
}

#pragma mark - **************** Private Methods
- (void)bottomButtonClicked {
    if (!self.shortName.length || !self.assetNumber.length || !self.circulation.length || !self.precision.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_content_empty")];
        return;
    }
    QSFT *ftmodel = [[QSFT alloc] init];
    ftmodel.name = self.name;
    ftmodel.sym_name = self.shortName;
    ftmodel.sym = [NSString stringWithFormat:@"%@,S#%@",self.precision,self.assetNumber];
    ftmodel.creator = [QSWalletHelper sharedHelper].currentEvt.publicKey;
    QSFTIssue *issue = [[QSFTIssue alloc] init];
    issue.name = @"issue";
    QSFTManage *manage = [[QSFTManage alloc] init];
    manage.name = @"manage";
    QSAuthorizers *authorizers = [[QSAuthorizers alloc] init];
//    authorizers.ref = [NSString stringWithFormat:@"[A] %@",[QSWalletHelper sharedHelper].currentEvt.publicKey];
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
    
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
    [self.IconImage drawInRect:CGRectMake(0, 0, 100, 100)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *data = UIImageJPEGRepresentation(resultImage, 0.1);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    WeakSelf(weakSelf);
    [[QSEveriApiWebViewController sharedWebView] pushTransactionWithActionName:@"newfungible" andFt:ftmodel andConfig:encodedImageStr andCompeleteBlock:^(NSInteger statusCode, QSFT * _Nonnull ftmodel) {
        if (statusCode == kResponseSuccessCode) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
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
