//
//  QSQRCodeAddressTCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSQRCodeAddressCell.h"
#import "QSQRCodeScanItem.h"

@interface QSQRCodeAddressCell ()

@property (nonatomic, strong) UILabel *addressTitleLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation QSQRCodeAddressCell

- (void)configureSubViews {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.addressTitleLabel];
    [self.contentView addSubview:self.addressLabel];
    
    [self.addressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kRealValue(20));
        make.width.lessThanOrEqualTo(@kRealValue(60));
        make.height.equalTo(@([UIFont qs_fontOfSize15].lineHeight));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.contentView);
        make.left.equalTo(self.addressTitleLabel.mas_right).offset(kRealValue(13));
        make.right.equalTo(self.contentView).offset(-kRealValue(20));
    }];
}

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    self.item = item;
    
    QSQRCodeScanItem *scanItem = (QSQRCodeScanItem *)item;
    self.addressLabel.text = scanItem.address;
}

#pragma mark - **************** Setter Getter
- (UILabel *)addressTitleLabel {
    if (!_addressTitleLabel) {
        _addressTitleLabel = [UILabel labelWithName:QSLocalizedString(@"qs_collect_item_address_title") font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    }
    return _addressTitleLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [UILabel labelWithName:nil font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
        _addressLabel.numberOfLines = 0;
    }
    return _addressLabel;
}

@end
