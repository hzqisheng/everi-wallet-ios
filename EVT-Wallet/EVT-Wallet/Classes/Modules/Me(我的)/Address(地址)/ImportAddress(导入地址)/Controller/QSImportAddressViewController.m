//
//  QSImportAddressViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/29.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSImportAddressViewController.h"

@interface QSImportAddressViewController ()

@property (nonatomic, strong) UIView *importAddressView;
@property (nonatomic, strong) YYTextView *textView;

@end

@implementation QSImportAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_import_address_nav_title")];
    [self setupImportAddressView];
    [self setupBottomButton];
}

- (void)setupImportAddressView {
    UIView *importAddressView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kScreenWidth - kRealValue(30), kRealValue(235))];
    importAddressView.layer.cornerRadius = 8;
    importAddressView.backgroundColor = [UIColor whiteColor];
    importAddressView.layer.shadowOffset = CGSizeMake(0, 1);
    importAddressView.layer.shadowColor = [UIColor qs_colorGray00267B].CGColor;
    importAddressView.layer.shadowOpacity = 0.1f;
    //    self.shadowContainerView.layer.shadowRadius = 6;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:importAddressView.bounds cornerRadius:6];
    importAddressView.layer.shadowPath = path.CGPath;
    [self.view addSubview:importAddressView];
    _importAddressView = importAddressView;
    
    UIImageView *dottedLineView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kRealValue(315), kRealValue(95))];
    dottedLineView.image = [UIImage imageNamed:@"img_daorudizhi"];
    [importAddressView addSubview:dottedLineView];
    
    UILabel *tipsLabel = [UILabel labelWithName:QSLocalizedString(@"qs_import_address_tips_title") font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    [tipsLabel changeLineSpaceWithSpace:kRealValue(10) textAlignment:NSTextAlignmentLeft];
    tipsLabel.frame = CGRectMake(kRealValue(15), kRealValue(10), dottedLineView.width - kRealValue(30), dottedLineView.height - kRealValue(20));
    tipsLabel.numberOfLines = 0;
    [dottedLineView addSubview:tipsLabel];
    
    UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(0, dottedLineView.maxY + kRealValue(16), importAddressView.width, BORDER_WIDTH_1PX)];
    sepLine.backgroundColor = [UIColor qs_colorGrayCCCCCC];
    [importAddressView addSubview:sepLine];
    
    YYTextView *textView = [[YYTextView alloc] initWithFrame:CGRectMake(0, sepLine.maxY, importAddressView.width, importAddressView.height - sepLine.maxY - kRealValue(15))];
    textView.font = [UIFont qs_fontOfSize14];
    textView.textColor = [UIColor qs_colorBlack313745];
    textView.placeholderFont = [UIFont qs_fontOfSize14];
    textView.placeholderText = QSLocalizedString(@"qs_import_address_paste_address_title");
    textView.contentInset = UIEdgeInsetsMake(kRealValue(15), kRealValue(15), 0, -kRealValue(15));
    [importAddressView addSubview:textView];
}

- (void)setupBottomButton {
    UIButton *bottomButton = [self createBottomButtonWithTitle:QSLocalizedString(@"qs_import_address_save_btn_title") target:self action:@selector(saveButtonClicked)];
    CGFloat bottomButtomY = kDevice_Is_iPhoneX ? kScreenHeight - kNavgationBarHeight - kiPhoneXSafeAreaBottomMagin - kBottomButtonHeight : kScreenHeight - kNavgationBarHeight - kRealValue(15) - kBottomButtonHeight;
    bottomButton.frame = CGRectMake(kRealValue(15), bottomButtomY, kBottomButtonWidth, kBottomButtonHeight);
    [self.view addSubview:bottomButton];
}

#pragma mark - **************** Event Response
- (void)saveButtonClicked {
    DLog(@"保存");
}

@end
