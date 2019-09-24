//
//  QSImportWalletIndexViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSImportWalletIndexViewController.h"
#import "QSImportWalletByPrivateKeyViewController.h"
#import "QSImportWalletByKeyStoreCodeViewController.h"
#import "QSImportWalletByMnemonicCodeViewController.h"

@interface QSImportWalletIndexViewController ()

@property (nonatomic, assign) QSImportWalletType importWalletType;

@end

@implementation QSImportWalletIndexViewController

- (instancetype)initWithType:(QSImportWalletType)type {
    if (self = [super init]) {
        _importWalletType = type;
    }
    return self;
}

- (instancetype)init {
    return [self initWithType:QSImportWalletTypeEVT];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = QSLocalizedString(@"qs_import_wallet_nav_title");
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpAllViewController];
    
    @weakify(self);
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight,CGFloat *titleWidth) {
        @strongify(self);
        *titleFont = [UIFont systemFontOfSize:15];
        *titleHeight = kRealValue(40);
        *titleWidth = kScreenWidth/self.childViewControllers.count;
        *norColor = [UIColor qs_colorGray686868];
        *selColor = [UIColor qs_colorBlack313745];
    }];
    
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor,BOOL *isUnderLineEqualTitleWidth) {
        // 标题填充模式
        *underLineColor = [UIColor qs_colorBlack313745];
        *underLineH = 2;
        *isUnderLineEqualTitleWidth = YES;
    }];
    
    [self setUpContentViewFrame:^(UIView *contentView) {
        contentView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavgationBarHeight);
    }];
    
    self.contentViewDidScrollBlock = ^(CGPoint contentOffset) {
        @strongify(self);
        [self.view endEditing:YES];
    };
    
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"icon_qianbao_nav_back"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 44, 44);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn addTarget:target
            action:action
  forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

// 添加所有子控制器
- (void)setUpAllViewController
{
    if (self.importWalletType == QSImportWalletTypeEVT) {
        QSImportWalletByMnemonicCodeViewController *codeVC = [[QSImportWalletByMnemonicCodeViewController alloc] init];
        codeVC.title = QSLocalizedString(@"qs_import_wallet_mnemonic_code_title");
        [self addChildViewController:codeVC];
        
        QSImportWalletByPrivateKeyViewController *privateKeyVC = [[QSImportWalletByPrivateKeyViewController alloc] init];
        privateKeyVC.title = QSLocalizedString(@"qs_import_wallet_private_key_title");
        [self addChildViewController:privateKeyVC];
    } else if (self.importWalletType == QSImportWalletTypeETH) {
        QSImportWalletByMnemonicCodeViewController *codeVC = [[QSImportWalletByMnemonicCodeViewController alloc] init];
        codeVC.title = QSLocalizedString(@"qs_import_wallet_mnemonic_code_title");
        [self addChildViewController:codeVC];
        
        QSImportWalletByPrivateKeyViewController *privateKeyVC = [[QSImportWalletByPrivateKeyViewController alloc] init];
        privateKeyVC.title = QSLocalizedString(@"qs_import_wallet_private_key_title");
        [self addChildViewController:privateKeyVC];
        
        QSImportWalletByKeyStoreCodeViewController *keyStore = [[QSImportWalletByKeyStoreCodeViewController alloc] init];
        keyStore.title = QSLocalizedString(@"qs_import_wallet_key_store_title");
        [self addChildViewController:keyStore];
    } else if (self.importWalletType == QSImportWalletTypeEOS) {
        QSImportWalletByMnemonicCodeViewController *codeVC = [[QSImportWalletByMnemonicCodeViewController alloc] init];
        codeVC.title = QSLocalizedString(@"qs_import_wallet_mnemonic_code_title");
        [self addChildViewController:codeVC];
        
        QSImportWalletByPrivateKeyViewController *privateKeyVC = [[QSImportWalletByPrivateKeyViewController alloc] init];
        privateKeyVC.title = QSLocalizedString(@"qs_import_wallet_private_key_title");
        [self addChildViewController:privateKeyVC];
    }
}

@end
