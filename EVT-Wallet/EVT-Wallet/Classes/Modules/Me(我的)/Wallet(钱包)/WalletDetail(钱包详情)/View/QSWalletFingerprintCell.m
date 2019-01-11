//
//  QSWalletFingerprintCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/9.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSWalletFingerprintCell.h"
#import "QSWallectFingerprintItem.h"

@interface QSWalletFingerprintCell ()

@property (nonatomic, strong) UISwitch *fingerPrintSwitch;

@end

@implementation QSWalletFingerprintCell

- (void)configureSubViews {
    self.contentView.backgroundColor = [UIColor clearColor];
    self.leftTitleLabel.font = [UIFont qs_fontOfSize16];
    self.leftTitleLabel.textColor = [UIColor qs_colorBlack333333];
    self.leftTitleLabel.text = QSLocalizedString(@"qs_wallet_detail_item_fingerprint_title");
    
    [self.contentView addSubview:self.leftTitleLabel];
    [self.contentView addSubview:self.fingerPrintSwitch];
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kRealValue(15));
        make.centerY.equalTo(self.contentView);
        make.width.lessThanOrEqualTo(@(kScreenWidth/2));
    }];
    
    [self.fingerPrintSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-kRealValue(15));
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    self.item = item;
    QSWallectFingerprintItem *fingerprintItem = (QSWallectFingerprintItem *)self.item;
    [self.fingerPrintSwitch setOn:fingerprintItem.isOpenFingerprint animated:YES];
}

- (void)valueChanged:(UISwitch *)sender {
    QSWallectFingerprintItem *fingerprintItem = (QSWallectFingerprintItem *)self.item;
    if (fingerprintItem.switchValueChangedBlock) {
        fingerprintItem.switchValueChangedBlock(sender.isOn);
    }
}

#pragma mark - **************** Setter Getter
- (UISwitch *)fingerPrintSwitch {
    if (!_fingerPrintSwitch) {
        _fingerPrintSwitch = [[UISwitch alloc] init];
        _fingerPrintSwitch.onTintColor = [UIColor qs_colorBlue4D7BF3];
        [_fingerPrintSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _fingerPrintSwitch;
}

@end
