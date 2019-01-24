//
//  QSPaySuccessViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/11.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSPaySuccessViewController.h"
#import "QSBottomButtonView.h"

@interface QSPaySuccessViewController ()

@property (nonatomic, strong) UILabel *amountLabel;

@end

@implementation QSPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    //amountView
    UIImageView *amountView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(210))];
    amountView.image = [UIImage imageNamed:@"bg_fukuan"];
    [self.view addSubview:amountView];
    
    //backButton
    UIButton *backButton = [UIButton buttonWithImage:@"icon_qianbao_nav_back" taget:self action:@selector(back)];
    backButton.frame = CGRectMake(5, kStatusBarHeight, 44, 44);
    [amountView addSubview:backButton];
    
    //successImageView
    UIImageView *successImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(135), kRealValue(92), kRealValue(36), kRealValue(36))];
    successImageView.image = [UIImage imageNamed:@"icon_fukuan_complete-1"];
    [amountView addSubview:successImageView];
    
    //successLabel
    UILabel *successLabel = [UILabel labelWithName:QSLocalizedString(@"qs_transaction_success_title") font:[UIFont qs_fontOfSize14] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    successLabel.frame = CGRectMake(successImageView.maxX + kRealValue(13), successImageView.y, kRealValue(100), kRealValue(36));
    successLabel.numberOfLines = 0;
    [amountView addSubview:successLabel];
    
    //amountLabel
    //QSLocalizedString(@"qs_transaction_success_title")
    _amountLabel =  [UILabel labelWithName:nil font:[UIFont qs_fontOfSize19] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    _amountLabel.frame = CGRectMake(kRealValue(10), successImageView.maxY + kRealValue(22), amountView.width - kRealValue(20), kRealValue(20));
    [amountView addSubview:_amountLabel];
    
    //buttonView
    @weakify(self);
    QSBottomButtonView *buttonView = [[QSBottomButtonView alloc] initWithFrame:CGRectMake(kRealValue(15), amountView.maxY, kBottomButtonWidth, kRealValue(100))
                                                                         title:QSLocalizedString(@"qs_collect_success_bottom_btn_title")
                                                                  clickedBlock:^
                                      {
                                          @strongify(self);
                                          [self.navigationController popToRootViewControllerAnimated:YES];
                                      }];
    [self.view addSubview:buttonView];
    
    [[QSEveriApiWebViewController sharedWebView] getTransactionDetailById:self.transactionId andCompeleteBlock:^(NSInteger statusCode, NSString * _Nonnull transactionNumber) {
        @strongify(self);
        if (statusCode == kResponseSuccessCode) {
            NSArray *transactionNumberList = [transactionNumber componentsSeparatedByString:@" "];
            if (transactionNumberList.count == 2) {
                NSString *symId = transactionNumberList[1];
                NSRange range = [symId rangeOfString:@"S#"];
                symId = [symId substringWithRange:NSMakeRange(range.location + range.length, symId.length - range.length)];
                [[QSEveriApiWebViewController sharedWebView] getFungibleSymbolDetailWithSymId:symId andCompeleteBlock:^(NSInteger statusCode, QSFungibleSymbol * _Nonnull fungibleSymbol) {
                    if (statusCode == kResponseSuccessCode) {
                        NSArray *symArray = [fungibleSymbol.sym componentsSeparatedByString:@","];
                        NSString *jingDuStr = symArray[0];
                        NSString *resultMoney = [self handleMoney:transactionNumberList[0] byPrecision:jingDuStr];
                        self.amountLabel.text = [NSString stringWithFormat:@"-%@ %@",resultMoney,fungibleSymbol.sym_name];
                    }
                }];
            }
        }
    }];
}

- (NSString *)handleMoney:(NSString *)money byPrecision:(NSString *)precision {
    NSString *floatString = [NSString stringWithFormat:@"%f",money.floatValue];
    NSRange range = [floatString rangeOfString:@"."];
    NSInteger subStringIndex = range.length + range.location + precision.integerValue;
    NSString *result = [floatString substringToIndex:subStringIndex];
    return result;
}

- (void)back {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
