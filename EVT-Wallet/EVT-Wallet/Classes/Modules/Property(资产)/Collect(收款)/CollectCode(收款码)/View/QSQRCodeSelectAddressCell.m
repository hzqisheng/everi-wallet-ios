//
//  QSQRCodeSelectAddressCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSQRCodeSelectAddressCell.h"
#import "QSQRCodeScanItem.h"

@interface QSQRCodeSelectAddressCell ()

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *walletNameLabel;
@property (nonatomic, strong) UILabel *walletTipsLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation QSQRCodeSelectAddressCell

- (void)configureSubViews {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.walletNameLabel];
    [self.contentView addSubview:self.walletTipsLabel];
    [self.contentView addSubview:self.arrowImageView];

    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kRealValue(25));
        make.centerY.equalTo(self.contentView);
        make.width.and.height.equalTo(@kRealValue(33));
    }];
    
    [self.walletNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY).offset(-kRealValue(2));
        make.left.equalTo(self.leftImageView.mas_right).offset(kRealValue(14));
        make.right.equalTo(self.arrowImageView.mas_left).offset(-kRealValue(14));
        make.height.equalTo(@([UIFont qs_fontOfSize15].lineHeight));
    }];
    
    [self.walletTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_centerY).offset(kRealValue(2));
        make.left.and.right.equalTo(self.walletNameLabel);
        make.height.equalTo(@([UIFont qs_fontOfSize12].lineHeight));
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftImageView);
        make.right.equalTo(self.contentView).offset(-kRealValue(23));
        make.width.and.height.equalTo(@kRealValue(22));
    }];
}

- (void)configureCellWithItem:(id<QSBaseCellItemDataProtocol>)item {
    self.item = item;
    
    QSQRCodeScanItem *FTItem = (QSQRCodeScanItem *)item;
    QSFT *FTModel = FTItem.FTModel;
    
    self.leftImageView.image = FTModel.assetImage;

    if (FTModel.sym_name
        && FTModel.fungibleId) {
        self.walletNameLabel.text = [NSString stringWithFormat:@"%@(#%@)",FTModel.sym_name,FTModel.fungibleId];
    } else {
        self.walletNameLabel.text = @"";
    }
}

#pragma mark - **************** Setter Getter
- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"icon_erweima_evt"];
        _leftImageView.layer.cornerRadius = kRealValue(16.5);
        _leftImageView.layer.masksToBounds = YES;
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftImageView;
}

- (UILabel *)walletNameLabel {
    if (!_walletNameLabel) {
        _walletNameLabel = [UILabel labelWithName:@"" font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    }
    return _walletNameLabel;
}

- (UILabel *)walletTipsLabel {
    if (!_walletTipsLabel) {
        _walletTipsLabel = [UILabel labelWithName:QSLocalizedString(@"qs_everipay_item_selected_wallet_title") font:[UIFont qs_fontOfSize12] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    }
    return _walletTipsLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"icon_erweima_enter"];
    }
    return _arrowImageView;
}



@end
