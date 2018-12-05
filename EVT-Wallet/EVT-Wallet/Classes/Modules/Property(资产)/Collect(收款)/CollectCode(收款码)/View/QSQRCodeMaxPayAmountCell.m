//
//  QSQRCodeMaxPayAmountCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSQRCodeMaxPayAmountCell.h"
#import "QSQRCodeScanItem.h"

@interface QSQRCodeMaxPayAmountCell ()

@property (nonatomic, strong) UILabel *maxPayAmountTipsLabel;
@property (nonatomic, strong) UILabel *maxPayAmountLabel;

@end

@implementation QSQRCodeMaxPayAmountCell

- (void)configureSubViews {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.maxPayAmountTipsLabel];
    [self.contentView addSubview:self.maxPayAmountLabel];
    
    [self.maxPayAmountTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kRealValue(24));
        make.width.lessThanOrEqualTo(@kRealValue(100));
    }];
    
    [self.maxPayAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-kRealValue(24));
        make.left.equalTo(self.maxPayAmountTipsLabel.mas_right).offset(kRealValue(15));
    }];
}

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    self.item = item;
    
    QSQRCodeScanItem *scanItem = (QSQRCodeScanItem *)item;
    self.maxPayAmountLabel.text = scanItem.maxPayAmount;
}

#pragma mark - **************** Setter Getter
- (UILabel *)maxPayAmountTipsLabel {
    if (!_maxPayAmountTipsLabel) {
        _maxPayAmountTipsLabel = [UILabel labelWithName:QSLocalizedString(@"qs_everipay_item_max_pay_title") font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    }
    return _maxPayAmountTipsLabel;
}

- (UILabel *)maxPayAmountLabel {
    if (!_maxPayAmountLabel) {
        _maxPayAmountLabel = [UILabel labelWithName:QSLocalizedString(@"qs_collect_item_max_pay_title") font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorBlue4D7BF3] textAlignment:NSTextAlignmentRight];
    }
    return _maxPayAmountLabel;
}


@end
