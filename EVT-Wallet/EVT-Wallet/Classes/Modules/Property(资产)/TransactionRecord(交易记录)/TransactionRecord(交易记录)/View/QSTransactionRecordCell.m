//
//  QSTransactionRecordCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSTransactionRecordCell.h"
#import "QSTransactionRecordItem.h"

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
    QSTransactionRecordItem *recordItem = (QSTransactionRecordItem *)item;
    NSArray *timeArr = [recordItem.transferModel.timestamp componentsSeparatedByString:@"+"];
    if (timeArr.count == 2) {
        self.timeLabel.text = timeArr[0];
    }
    NSArray *amountArr = [recordItem.transferModel.data.number componentsSeparatedByString:@" "];
    
    if ([recordItem.transferModel.name isEqualToString:@"issuefungible"]) {
        self.addressLabel.text = QSLocalizedString(@"qs_btn_home_issue");
        if (amountArr.count == 2) {
            self.amountLabel.text = [NSString stringWithFormat:@"+%@",amountArr[0]];
        }
    } else if ([recordItem.transferModel.name isEqualToString:@"transferft"]) {
        if ([recordItem.transferModel.data.from isEqualToString:QSPublicKey]) {
            self.addressLabel.text = recordItem.transferModel.data.to;
            if (amountArr.count == 2) {
                self.amountLabel.text = [NSString stringWithFormat:@"-%@",amountArr[0]];
                self.amountLabel.textColor = [UIColor qs_colorBlack313745];
            }
        } else if ([recordItem.transferModel.data.to isEqualToString:QSPublicKey]) {
            self.addressLabel.text = recordItem.transferModel.data.from;
            if (amountArr.count == 2) {
                self.amountLabel.text = [NSString stringWithFormat:@"+%@",amountArr[0]];
            }
        }
    } else if ([recordItem.transferModel.name isEqualToString:@"everipay"]) {
        NSArray *addressArr = recordItem.transferModel.data.link[@"keys"];
        if (!addressArr.count) {
            return;
        }
        NSString *shoukuanAddress = addressArr[0];
        if ([recordItem.transferModel.data.payee isEqualToString:QSPublicKey]) {
            self.addressLabel.text = shoukuanAddress;
            if (amountArr.count == 2) {
                self.amountLabel.text = [NSString stringWithFormat:@"+%@",amountArr[0]];
            }
        } else if ([shoukuanAddress isEqualToString:QSPublicKey]) {
            self.addressLabel.text = recordItem.transferModel.data.payee;
            if (amountArr.count == 2) {
                self.amountLabel.text = [NSString stringWithFormat:@"-%@",amountArr[0]];
                self.amountLabel.textColor = [UIColor qs_colorBlack313745];
            }
        }
    }
    
    
}

#pragma mark - **************** Setter Getter
- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [UILabel labelWithName:@"" font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentLeft];
    }
    return _addressLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithName:@"" font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    }
    return _timeLabel;
}

- (UILabel *)amountLabel {
    if (!_amountLabel) {
        _amountLabel = [UILabel labelWithName:@"" font:[UIFont qs_boldFontOfSize17] textColor:[UIColor qs_colorRedFF1E48] textAlignment:NSTextAlignmentRight];
    }
    return _amountLabel;
}

@end
