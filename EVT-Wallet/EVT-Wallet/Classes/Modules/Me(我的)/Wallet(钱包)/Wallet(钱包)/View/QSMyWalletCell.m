//
//  QSMyWalletCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSMyWalletCell.h"

@interface QSMyWalletCell ()

@property (nonatomic, strong) UIImageView *walletImageView;
@property (nonatomic, strong) UILabel *walletNameLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UILabel *walletTypeLabel;
@property (nonatomic, strong) UILabel *secretKeyLabel;
@property (nonatomic, strong) UIButton *pasteSecretKeyButton;

@end

@implementation QSMyWalletCell

- (void)configureSubViews {
    [self.contentView addSubview:self.walletBackgroundView];
    [self.walletBackgroundView addSubview:self.walletImageView];
    [self.walletBackgroundView addSubview:self.walletNameLabel];
    [self.walletBackgroundView addSubview:self.moreButton];
    [self.walletBackgroundView addSubview:self.walletTypeLabel];
    [self.walletBackgroundView addSubview:self.secretKeyLabel];
    [self.walletBackgroundView addSubview:self.pasteSecretKeyButton];
    [self p_addMassnory];
}

- (void)p_addMassnory {
    [self.walletBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.contentView);
        make.left.equalTo(@kRealValue(5));
        make.right.equalTo(@kRealValue(-5));
    }];
    
    [self.walletImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.walletBackgroundView);
        make.left.equalTo(self.walletBackgroundView).offset(kRealValue(25));
        make.size.mas_equalTo(CGSizeMake(kRealValue(23), kRealValue(14)));
    }];
    
    [self.walletNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.walletBackgroundView).offset(kRealValue(30));
        make.left.equalTo(self.walletBackgroundView).offset(kRealValue(68));
        make.height.equalTo(@([UIFont qs_fontOfSize15].lineHeight));
        make.right.equalTo(self.moreButton.mas_left).offset(-kRealValue(5));
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.walletNameLabel);
        make.right.equalTo(self.walletBackgroundView.mas_right).offset(-kRealValue(11));
        make.width.and.height.equalTo(@kRealValue(44));
    }];
    
    [self.walletTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.walletNameLabel);
        make.top.equalTo(self.walletNameLabel.mas_bottom).offset(kRealValue(10));
        make.width.equalTo(@kRealValue(30));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.secretKeyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.walletTypeLabel.mas_bottom);
        make.left.equalTo(self.walletTypeLabel.mas_right).offset(kRealValue(5));
        make.width.lessThanOrEqualTo(@kRealValue(160));
        make.height.equalTo(@([UIFont qs_fontOfSize13].lineHeight));
    }];
    
    [self.pasteSecretKeyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secretKeyLabel.mas_right);
        make.centerY.equalTo(self.walletTypeLabel);
        make.width.and.height.equalTo(@kRealValue(30));
    }];
}

#pragma mark - **************** Event Response
- (void)moreButtonClicked {
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock(self);
    }
}

- (void)pasteSecretKeyButtonClicked {
    if (self.pasteButtonClickedBlock) {
        self.pasteButtonClickedBlock(self);
    }
}

#pragma mark - **************** Setter Getter
- (UIImageView *)walletBackgroundView {
    if (!_walletBackgroundView) {
        _walletBackgroundView = [[UIImageView alloc] init];
        _walletBackgroundView.userInteractionEnabled = YES;
    }
    return _walletBackgroundView;
}

- (UIImageView *)walletImageView {
    if (!_walletImageView) {
        _walletImageView = [[UIImageView alloc] init];
        _walletImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_walletImageView setImage:[UIImage imageNamed:@"icon_erweima_evt"]];
    }
    return _walletImageView;
}

- (UILabel *)walletNameLabel {
    if (!_walletNameLabel) {
        _walletNameLabel = [UILabel labelWithName:@"EVT-wallet" font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentLeft];
    }
    return _walletNameLabel;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithImage:@"icon_qianbao_more" taget:self action:@selector(moreButtonClicked)];
    }
    return _moreButton;
}

- (UILabel *)walletTypeLabel {
    if (!_walletTypeLabel) {
        _walletTypeLabel = [UILabel labelWithName:@"evt" font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentCenter];
        _walletTypeLabel.layer.borderWidth = 1;
        _walletTypeLabel.layer.borderColor = [UIColor qs_colorBlack313745].CGColor;
    }
    return _walletTypeLabel;
}

- (UILabel *)secretKeyLabel {
    if (!_secretKeyLabel) {
        _secretKeyLabel = [UILabel labelWithName:@"EVT8LJq6...caQkAySeY" font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentLeft];
    }
    return _secretKeyLabel;
}

- (UIButton *)pasteSecretKeyButton {
    if (!_pasteSecretKeyButton) {
        _pasteSecretKeyButton = [UIButton buttonWithImage:@"icon_qianbao_card" taget:self action:@selector(pasteSecretKeyButtonClicked)];
    }
    return _pasteSecretKeyButton;
}

- (void)setWallet:(QSCreateEvt *)wallet {
    _wallet = wallet;
    if ([wallet.type isEqualToString:@"EVT"]) {
        self.walletNameLabel.text = wallet.evtShowName;
        self.walletTypeLabel.text = @"evt";
    } else if ([wallet.type isEqualToString:@"ETH"]) {
        self.walletTypeLabel.text = @"eth";
        self.walletNameLabel.text = @"eth-wallet";
    } else if ([wallet.type isEqualToString:@"EOS"]) {
        self.walletTypeLabel.text = @"eos";
        self.walletNameLabel.text = @"eos-wallet";
    }
    self.secretKeyLabel.text = self.wallet.publicKey;
}

@end
