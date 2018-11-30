//
//  QSHomeMyFTsCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/26.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSHomeMyFTsCell.h"

@interface QSHomeMyFTsCell ()

@property (nonatomic, strong) UIImageView *ftImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UIButton *payButton;

@end

@implementation QSHomeMyFTsCell

- (void)configureSubViews {
    [self.contentView addSubview:self.ftImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.amountLabel];
    [self.contentView addSubview:self.payButton];

    [self.ftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kRealValue(21));
        make.centerY.equalTo(self.contentView);
        make.width.and.height.equalTo(@kRealValue(33));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ftImageView);
        make.left.equalTo(self.ftImageView.mas_right).offset(kRealValue(9));
        make.right.equalTo(self.payButton.mas_left).offset(-kRealValue(9));
        make.height.equalTo(@([UIFont qs_fontOfSize14].lineHeight));
    }];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(kRealValue(15));
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
    
}

#pragma mark - **************** Setter Getter
- (UIImageView *)ftImageView {
    if (!_ftImageView) {
        _ftImageView = [[UIImageView alloc] init];
        _ftImageView.image = [UIImage imageNamed:@"icon_home_pevt"];
    }
    return _ftImageView;
}

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
        _payButton = [UIButton buttonWithImage:@"icon_home_paypeal" taget:self action:@selector(payButtonClicked)];
    }
    return _payButton;
}

@end
