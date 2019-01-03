//
//  QSMyNFTsCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/9.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSMyNFTsCell.h"

@interface QSMyNFTsCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UIButton *payButton;

@end

@implementation QSMyNFTsCell

- (void)configureSubViews {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.amountLabel];
    [self.contentView addSubview:self.payButton];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@kRealValue(17));
        make.left.equalTo(self.contentView).offset(kRealValue(21));
        make.right.equalTo(self.payButton.mas_left).offset(-kRealValue(9));
        make.height.equalTo(@([UIFont qs_fontOfSize14].lineHeight));
    }];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(kRealValue(11));
        make.left.and.right.equalTo(self.nameLabel);
        make.height.equalTo(@([UIFont qs_fontOfSize13].lineHeight));
    }];
    
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-kRealValue(15));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(kRealValue(74), kRealValue(22)));
    }];
}

#pragma mark - **************** Event Response
- (void)payButtonClicked {
    if (self.everiPayClickedBlock) {
        self.everiPayClickedBlock(self);
    }
}

#pragma mark - **************** Setter Getter
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithName:@"PEVT(#2)" font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}

- (UILabel *)amountLabel {
    if (!_amountLabel) {
        _amountLabel = [UILabel labelWithName:@"0.97821" font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorGrayBBBBBB] textAlignment:NSTextAlignmentLeft];
    }
    return _amountLabel;
}

- (UIButton *)payButton {
    if (!_payButton) {
        _payButton = [UIButton buttonWithImage:@"icon_home_everipass" taget:self action:@selector(payButtonClicked)];
    }
    return _payButton;
}

- (void)setOwnedToken:(QSOwnedToken *)ownedToken {
    _ownedToken = ownedToken;
    
    self.nameLabel.text = ownedToken.name;
    
    self.amountLabel.text = ownedToken.domain;
}

@end
