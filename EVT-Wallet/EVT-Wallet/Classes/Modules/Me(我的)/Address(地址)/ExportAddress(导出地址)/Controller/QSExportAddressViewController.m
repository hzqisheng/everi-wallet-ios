//
//  QSExportAddressViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/29.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSExportAddressViewController.h"
#import "QSAddressHelper.h"

@interface QSExportAddressViewController ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation QSExportAddressViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self upload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_export_address_nav_title")];
    [self setupAddressView];
}

- (void)setupAddressView {
    CGFloat bottomButtomY = kDevice_Is_iPhoneX ? kScreenHeight - kNavgationBarHeight - kiPhoneXSafeAreaBottomMagin - kBottomButtonHeight : kScreenHeight - kNavgationBarHeight - kRealValue(15) - kBottomButtonHeight;

    UIView *importAddressView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kScreenWidth - kRealValue(30), bottomButtomY - kRealValue(30))];
    importAddressView.layer.cornerRadius = 8;
    importAddressView.backgroundColor = [UIColor whiteColor];
    importAddressView.layer.shadowOffset = CGSizeMake(0, 1);
    importAddressView.layer.shadowColor = [UIColor qs_colorGray00267B].CGColor;
    importAddressView.layer.shadowOpacity = 0.1f;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:importAddressView.bounds cornerRadius:6];
    importAddressView.layer.shadowPath = path.CGPath;
    [self.view addSubview:importAddressView];
    
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
    
    UILabel *contentLabel = [UILabel labelWithName:@"" font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    [contentLabel changeLineSpaceWithSpace:kRealValue(10) textAlignment:NSTextAlignmentLeft];
    contentLabel.frame = CGRectMake(kRealValue(15), sepLine.maxY + kRealValue(15), importAddressView.width - kRealValue(30), importAddressView.height - sepLine.maxY - kRealValue(30));
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel = contentLabel;
    [importAddressView addSubview:self.contentLabel];
    
    UIButton *bottomButton = [self createBottomButtonWithTitle:QSLocalizedString(@"qs_export_address_paste_btn_title") target:self action:@selector(saveButtonClicked)];
    bottomButton.frame = CGRectMake(kRealValue(15), bottomButtomY, kBottomButtonWidth, kBottomButtonHeight);
    [self.view addSubview:bottomButton];
}

- (void)upload {
    NSMutableArray *addressArray = [NSMutableArray arrayWithArray:[[QSAddressHelper sharedHelper] getAddress]];
    NSString *allAddressStr = @"";
    for (int i = 0; i < addressArray.count; i++) {
        QSAddress *address = addressArray[i];
        NSString *addressString = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@",address.type,address.publicKey,address.groupName,address.name,address.phone,address.note];
        if (i == 0) {
            allAddressStr = addressString;
            
        } else {
            allAddressStr = [allAddressStr stringByAppendingString:[NSString stringWithFormat:@"\n%@",addressString]];
        }
    }
    self.contentLabel.text = allAddressStr;
}

#pragma mark - **************** Event Response
- (void)saveButtonClicked {
    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.contentLabel.text];
    [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_collect_btn_copy_success_title")];
}

@end
