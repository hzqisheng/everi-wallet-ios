//
//  QSImportAddressViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/29.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSImportAddressViewController.h"
#import "QSAddress.h"

@interface QSImportAddressViewController ()<YYTextViewDelegate>

@property (nonatomic, strong) UIView *importAddressView;
@property (nonatomic, strong) YYTextView *textView;

@property (nonatomic, assign) BOOL isValidKey;

@end

@implementation QSImportAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_import_address_nav_title")];
    [self setupImportAddressView];
    [self setupBottomButton];
    self.isValidKey = YES;
}

- (void)setupImportAddressView {
    UIView *importAddressView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kScreenWidth - kRealValue(30), kRealValue(350))];
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
    textView.delegate = self;
    [importAddressView addSubview:textView];
    _textView = textView;
}

- (void)setupBottomButton {
    UIButton *bottomButton = [self createBottomButtonWithTitle:QSLocalizedString(@"qs_import_address_save_btn_title") target:self action:@selector(saveButtonClicked)];
    CGFloat bottomButtomY = kDevice_Is_iPhoneX ? kScreenHeight - kNavgationBarHeight - kiPhoneXSafeAreaBottomMagin - kBottomButtonHeight : kScreenHeight - kNavgationBarHeight - kRealValue(15) - kBottomButtonHeight;
    bottomButton.frame = CGRectMake(kRealValue(15), bottomButtomY, kBottomButtonWidth, kBottomButtonHeight);
    [self.view addSubview:bottomButton];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
}

- (NSString *)removeSpaceAndNewline:(NSString *)str {
    NSString *temp = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return text;
}

#pragma mark - **************** Event Response
- (void)saveButtonClicked {
    DLog(@"保存");
    NSArray *addressAllArray = [self.textView.text componentsSeparatedByString:@"\n"];
    NSMutableArray *addressModelArray = [NSMutableArray array];
    if (!addressAllArray.count) {
        return;
    }
    BOOL isVaild = YES;
    for (NSString *address in addressAllArray) {
        if (address.length) {
            NSString *resultAddress = [self removeSpaceAndNewline:address];
            NSArray *addressArray = [resultAddress componentsSeparatedByString:@","];
            if (addressArray.count == 6) {
                QSAddress *address = [[QSAddress alloc] init];
                address.type = addressArray[0];
                address.publicKey = addressArray[1];
                address.groupName = addressArray[2];
                address.name = addressArray[3];
                address.phone = addressArray[4];
                address.note = addressArray[5];
                [addressModelArray addObject:address];
            } else {
                isVaild = NO;
                [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_import_address_error_title")];
            }
        }
    }
    
    if (isVaild) {
        for (QSAddress *address in addressModelArray) {
            [[QSAddressHelper sharedHelper] addAddress:address];
        }
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_import_address_success_title")];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
