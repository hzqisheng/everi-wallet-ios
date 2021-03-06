//
//  QSEveriPayCurrencyCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSEveriPayCollectCurrencyCell.h"
#import "QSEveriPayCollectCurrencyItem.h"
#import "QSFungibleSymbol.h"

@interface QSEveriPayCollectCurrencyCell ()

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *walletNameLabel;
@property (nonatomic, strong) UILabel *walletTipsLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation QSEveriPayCollectCurrencyCell

- (void)configureSubViews {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.walletNameLabel];
    [self.contentView addSubview:self.walletTipsLabel];
    [self.contentView addSubview:self.arrowImageView];
    
    [self.walletTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY).offset(-kRealValue(5));
        make.left.equalTo(self.contentView).offset(kRealValue(20));
        make.right.equalTo(self.contentView).offset(-kRealValue(14));
        make.height.equalTo(@([UIFont qs_fontOfSize15].lineHeight));
    }];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kRealValue(20));
        make.top.equalTo(self.walletTipsLabel.mas_bottom).offset(kRealValue(5));
        make.width.and.height.equalTo(@kRealValue(27));
    }];
    
    [self.walletNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftImageView);
        make.right.equalTo(self.walletNameLabel);
        make.left.equalTo(self.leftImageView.mas_right).offset(kRealValue(14));
    }];
    
//    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.contentView);
//        make.right.equalTo(self.contentView).offset(-kRealValue(13));
//        make.width.and.height.equalTo(@kRealValue(22));
//    }];
}

- (void)configureCellWithItem:(id<QSBaseCellItemDataProtocol>)item {
    self.item = item;
    
    QSEveriPayCollectCurrencyItem *currentItem = (QSEveriPayCollectCurrencyItem *)item;
    QSFungibleSymbol *FTModel = currentItem.FTModel;
    
    if (FTModel.sym_name) {
        self.walletNameLabel.text = [NSString stringWithFormat:@"%@(#%@)",FTModel.sym_name,currentItem.currceny];
    } else {
        self.walletNameLabel.text = @"";
    }
    
    self.leftImageView.image = FTModel.assetImage;
}

#pragma mark - **************** Setter Getter
- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"icon_erweima_evt"];
        _leftImageView.layer.cornerRadius = kRealValue(13.5);
        _leftImageView.layer.masksToBounds = YES;
    }
    return _leftImageView;
}

- (UILabel *)walletNameLabel {
    if (!_walletNameLabel) {
        _walletNameLabel = [UILabel labelWithName:@"EVT(#1)" font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentLeft];
    }
    return _walletNameLabel;
}

- (UILabel *)walletTipsLabel {
    if (!_walletTipsLabel) {
        _walletTipsLabel = [UILabel labelWithName:QSLocalizedString(@"qs_collect_amount_item_currency_title") font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentLeft];
    }
    return _walletTipsLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"icon_fukuan_enter"];
    }
    return _arrowImageView;
}

@end
