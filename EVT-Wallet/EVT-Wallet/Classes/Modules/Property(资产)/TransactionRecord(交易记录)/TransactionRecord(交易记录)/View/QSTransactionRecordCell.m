//
//  QSTransactionRecordCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSTransactionRecordCell.h"

@interface QSTransactionRecordCell ()

@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *amountLabel;

@end

@implementation QSTransactionRecordCell

- (void)configureSubViews {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.amountLabel];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-kRealValue(4));
        make.left.equalTo(self.contentView).offset(kRealValue(25));
        make.width.lessThanOrEqualTo(@kRealValue(180));
    }];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_centerY).offset(kRealValue(4));
        make.left.equalTo(self.contentView).offset(kRealValue(25));
        make.width.lessThanOrEqualTo(@kRealValue(180));
    }];

    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.addressLabel);
        make.right.equalTo(self.contentView).offset(-kRealValue(25));
        make.width.lessThanOrEqualTo(@kRealValue(100));
    }];
}

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    self.item = item;
}

#pragma mark - **************** Setter Getter
- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [UILabel labelWithName:@"EVT2397430jjsee37HJ" font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentLeft];
    }
    return _addressLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithName:@"2018-11-19  14:18:08" font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    }
    return _timeLabel;
}

- (UILabel *)amountLabel {
    if (!_amountLabel) {
        _amountLabel = [UILabel labelWithName:@"+200.00" font:[UIFont qs_boldFontOfSize17] textColor:[UIColor qs_colorRedFF1E48] textAlignment:NSTextAlignmentRight];
    }
    return _amountLabel;
}

@end
