//
//  QSSelectFTViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/10.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSSelectFTViewController.h"
#import "QSBottomButtonView.h"

@interface QSSelectFTViewController ()

@end

@implementation QSSelectFTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_select_ft_nav_titlte")];
    
    UIButton *bottomButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_select_ft_btn_titlte") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(bottomButtonClicked)];
    [bottomButton setImage:[UIImage imageNamed:@"icon_xuanzedaibi_plus"] forState:UIControlStateNormal];
    bottomButton.backgroundColor = [UIColor qs_colorBlack313745];
    bottomButton.layer.cornerRadius = 2;
    bottomButton.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
    bottomButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
    [self.view addSubview:bottomButton];
    CGFloat bottomButtonBottomMargin = kDevice_Is_iPhoneX ? kiPhoneXSafeAreaBottomMagin : kRealValue(15);
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-bottomButtonBottomMargin);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kBottomButtonWidth, kBottomButtonHeight));
    }];
}

#pragma mark - **************** Event Response
- (void)bottomButtonClicked {
    
}

@end
