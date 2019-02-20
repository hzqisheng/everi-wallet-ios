//
//  QSTransactionSuccessViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSTransactionSuccessViewController.h"
#import "QSBottomButtonView.h"

@interface QSTransactionSuccessViewController ()

@property (nonatomic, strong) UILabel *amountLabel;

@end

@implementation QSTransactionSuccessViewController

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
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
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
    NSString *nameStr = @"";
    NSArray *totlyList = [self.FTModel.asset componentsSeparatedByString:@" "];
    if (totlyList.count == 2) {
        NSMutableString *test = [NSMutableString stringWithString:totlyList[1]];
        if([test hasPrefix:@"S"]){
            [test deleteCharactersInRange: [test rangeOfString:@"S"]];
        }
        nameStr = [NSString stringWithFormat:@"%@(%@)",self.FTModel.sym_name,test];
    } else {
        nameStr = self.FTModel.name;
    }
    _amountLabel = [UILabel labelWithName:[NSString stringWithFormat:@"-%@ %@",self.count,nameStr] font:[UIFont qs_fontOfSize19] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
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
}

- (void)back {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
