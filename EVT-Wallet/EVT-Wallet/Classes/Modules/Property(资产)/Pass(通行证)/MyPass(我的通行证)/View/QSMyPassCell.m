//
//  QSMyPassCell.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSMyPassCell.h"

@implementation QSMyPassCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    [self.cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-kRealValue(15));
    }];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cornerView).offset(kRealValue(13));
        make.top.equalTo(self.cornerView).offset(kRealValue(28));
        make.size.mas_equalTo(CGSizeMake(kRealValue(29), kRealValue(29)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cornerView).offset(kRealValue(16));
        make.right.equalTo(self.moreButton.mas_left).offset(-kRealValue(10));
        make.top.equalTo(self.cornerView).offset(kRealValue(26));
        make.height.equalTo(@kRealValue(20));
    }];
    
    [self.blockchainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRealValue(5));
        make.right.equalTo(self.cornerView).offset(-kRealValue(20));
        make.height.equalTo(@kRealValue(20));
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.cornerView).offset(-kRealValue(7));
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(44), kRealValue(44)));
    }];
    _moreButton.hidden = YES;
}

#pragma mark - **************** Event Response
- (void)moreSettingAction {
    if (self.myPassCellClickMoreButtonBlock) {
        self.myPassCellClickMoreButtonBlock(self);
    }
}

#pragma mark - **************** Setter Getter
- (UIView *)cornerView {
    if (!_cornerView) {
        _cornerView = [[UIView alloc] init];
        _cornerView.layer.cornerRadius = kRealValue(8);
        _cornerView.layer.masksToBounds = YES;
        _cornerView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_cornerView];
    }
    return _cornerView;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_leftImageView setImage:[UIImage imageNamed:@"icon_home_peos"]];
        _leftImageView.hidden = YES;
        [self.cornerView addSubview:_leftImageView];
    }
    return _leftImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"EOS-wallet";
        _titleLabel.textColor = [UIColor qs_colorBlack333333];
        _titleLabel.font = [UIFont qs_fontOfSize15];
        [self.cornerView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)blockchainLabel {
    if (!_blockchainLabel) {
        _blockchainLabel = [[UILabel alloc] init];
        _blockchainLabel.text = @"EOS5fKva...UBt7gBagC";
        _blockchainLabel.textColor = [UIColor qs_colorGray686868];
        _blockchainLabel.font = [UIFont qs_fontOfSize13];
        [self.cornerView addSubview:_blockchainLabel];
    }
    return _blockchainLabel;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] init];
        [_moreButton setImage:[UIImage imageNamed:@"icon_xuanzedaibi_more"] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreSettingAction) forControlEvents:UIControlEventTouchUpInside];
        [self.cornerView addSubview:_moreButton];
    }
    return _moreButton;
}

- (void)setNFTModel:(QSNFT *)NFTModel {
    _NFTModel = NFTModel;
    if (NFTModel.metas.count > 0) {
        QSMetas *metas = NFTModel.metas[0];
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:metas.value]];
    }  else {
        [self.leftImageView setImage:[UIImage imageNamed:@"icon_home_pevt"]];
    }
    self.titleLabel.text = NFTModel.name;
    self.blockchainLabel.text = NFTModel.creator;
}

@end
