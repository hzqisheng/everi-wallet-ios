//
//  QSManageAddressCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSManageAddressCell.h"

@interface QSManageAddressCell ()

@property (nonatomic, strong) UIImageView *addressBackgroundView;
@property (nonatomic, strong) UILabel *secretKeyLabel;
@property (nonatomic, strong) UILabel *addressContentLabel;
@property (nonatomic, strong) UILabel *addressTypeLabel;

@end

@implementation QSManageAddressCell

- (void)configureSubViews {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.addressBackgroundView];
    [self.addressBackgroundView addSubview:self.secretKeyLabel];
    [self.addressBackgroundView addSubview:self.addressContentLabel];
    [self.addressBackgroundView addSubview:self.addressTypeLabel];
    
    [self.addressBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 5, 0, 5));
    }];
    
    [self.secretKeyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressBackgroundView).offset(kRealValue(35));
        make.left.equalTo(self.addressBackgroundView).offset(kRealValue(31));
        make.width.lessThanOrEqualTo(@kRealValue(200));
        make.height.equalTo(@([UIFont qs_fontOfSize14].lineHeight));
    }];
    
    [self.addressContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secretKeyLabel);
        make.top.equalTo(self.secretKeyLabel.mas_bottom).offset(kRealValue(8));
        make.width.lessThanOrEqualTo(@kRealValue(200));
        make.height.equalTo(@([UIFont qs_fontOfSize13].lineHeight));
    }];
    
    [self.addressTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.addressBackgroundView);
        make.right.equalTo(self.addressBackgroundView).offset(-kRealValue(36));
        make.size.mas_equalTo(CGSizeMake(kRealValue(35), kRealValue(16)));
    }];
}

#pragma mark - **************** Setter Getter
- (UIImageView *)addressBackgroundView {
    if (!_addressBackgroundView) {
        _addressBackgroundView = [[UIImageView alloc] init];
        _addressBackgroundView.image = [UIImage imageNamed:@"img_dizhiguanli_card"];
    }
    return _addressBackgroundView;
}

- (UILabel *)secretKeyLabel {
    if (!_secretKeyLabel) {
        _secretKeyLabel = [UILabel labelWithName:@"EVT8LJq6...caQkAySesdfsdfsf" font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentLeft];
    }
    return _secretKeyLabel;
}

- (UILabel *)addressContentLabel {
    if (!_addressContentLabel) {
        _addressContentLabel = [UILabel labelWithName:@"钱钱钱" font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentLeft];
    }
    return _addressContentLabel;
}

- (UILabel *)addressTypeLabel {
    if (!_addressTypeLabel) {
        _addressTypeLabel = [UILabel labelWithName:@"EVT" font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentCenter];
        _addressTypeLabel.layer.borderColor = [UIColor qs_colorBlack313745].CGColor;
        _addressTypeLabel.layer.borderWidth = 1;
    }
    return _addressTypeLabel;
}

@end
