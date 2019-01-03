//
//  QSEveriPayCollectSuccessViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSEveriPayCollectSuccessViewController.h"
#import "QSBottomButtonView.h"

@interface QSEveriPayCollectSuccessViewController ()

@property (nonatomic, strong) UILabel *amountLabel;

@end

@implementation QSEveriPayCollectSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    NSString *nameStr = @"";
    NSArray *totlyList = [self.Model.total_supply componentsSeparatedByString:@" "];
    if (totlyList.count == 2) {
        NSMutableString *test = [NSMutableString stringWithString:totlyList[1]];
        if([test hasPrefix:@"S"]){
            [test deleteCharactersInRange: [test rangeOfString:@"S"]];
        }
        nameStr = [NSString stringWithFormat:@"%@(%@)",self.Model.sym_name,test];
    } else {
        nameStr = self.Model.name;
    }
    _amountLabel = [UILabel labelWithName:[NSString stringWithFormat:@"+%@ %@",self.money,nameStr] font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentCenter];
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
}

@end
