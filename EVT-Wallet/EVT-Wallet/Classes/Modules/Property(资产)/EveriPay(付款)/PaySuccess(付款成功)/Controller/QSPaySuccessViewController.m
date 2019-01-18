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
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_transaction_success_title")];

    //amountView
    UIView *amountView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kScreenWidth - kRealValue(30), kRealValue(155))];
    amountView.layer.cornerRadius = 8;
    amountView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:amountView];
    
    //successImageView
    UIImageView *successImageView = [[UIImageView alloc] initWithFrame:CGRectMake(amountView.width/2 - kRealValue(45)/2, kRealValue(38), kRealValue(45), kRealValue(45))];
    successImageView.image = [UIImage imageNamed:@"icon_fukuan_complete"];
    [amountView addSubview:successImageView];
    
    //amountLabel
    //QSLocalizedString(@"qs_transaction_success_title")
    _amountLabel = [UILabel labelWithName:nil font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentCenter];
    _amountLabel.frame = CGRectMake(kRealValue(10), successImageView.maxY + kRealValue(22), amountView.width - kRealValue(20), kRealValue(16));
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
                        self.amountLabel.text = [NSString stringWithFormat:@"-%@ %@",transactionNumberList[0],fungibleSymbol.sym_name];
                    }
                }];
            }
        }
    }];
}

@end
