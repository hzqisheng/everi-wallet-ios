//
//  QSEveriPassDetailViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/11.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSEveriPassDetailViewController.h"

@interface QSEveriPassDetailViewController ()

@end

@implementation QSEveriPassDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBarTitle:self.name];
    [self setupSubViews];
}

- (void)setupSubViews {
    UIView *nameDomainView = [[UIView alloc] init];
    nameDomainView.backgroundColor = [UIColor whiteColor];
    nameDomainView.layer.cornerRadius = 8;
    [self.view addSubview:nameDomainView];
    [nameDomainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kRealValue(15));
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
        make.height.equalTo(@kRealValue(63));
    }];
    
    UILabel *domainLabel = [UILabel labelWithName:self.domain font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    [nameDomainView addSubview:domainLabel];
    [domainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameDomainView).offset(kRealValue(8));
        make.left.equalTo(nameDomainView).offset(kRealValue(15));
        make.right.equalTo(nameDomainView).offset(-kRealValue(15));
    }];
    
    UILabel *nameLabel = [UILabel labelWithName:self.name font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    [nameDomainView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(domainLabel.mas_bottom).offset(kRealValue(8));
        make.left.equalTo(nameDomainView).offset(kRealValue(15));
        make.right.equalTo(nameDomainView).offset(-kRealValue(15));
    }];
    
    
    UIView *ownerView = [[UIView alloc] init];
    ownerView.backgroundColor = [UIColor whiteColor];
    ownerView.layer.cornerRadius = 8;
    [self.view addSubview:ownerView];
    [ownerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameDomainView.mas_bottom).offset(kRealValue(15));
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
        make.height.equalTo(@kRealValue(76));
    }];
    
    UILabel *ownerLabel = [UILabel labelWithName:QSLocalizedString(@"qs_everipass_ownner_title") font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    [ownerView addSubview:ownerLabel];
    [ownerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ownerView).offset(kRealValue(8));
        make.left.equalTo(ownerView).offset(kRealValue(15));
        make.right.equalTo(ownerView).offset(-kRealValue(15));
    }];
    
    UILabel *publicKeyLabel = [UILabel labelWithName:[QSWalletHelper sharedHelper].currentEvt.publicKey font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    publicKeyLabel.numberOfLines = 2;
    [ownerView addSubview:publicKeyLabel];
    [publicKeyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ownerLabel.mas_bottom).offset(kRealValue(8));
        make.left.equalTo(ownerView).offset(kRealValue(15));
        make.right.equalTo(ownerView).offset(-kRealValue(15));
    }];
}

@end
