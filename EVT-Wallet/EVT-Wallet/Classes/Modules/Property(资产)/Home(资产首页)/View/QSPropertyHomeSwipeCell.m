//
//  QSPropertyHomeSwipeCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/23.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSPropertyHomeSwipeCell.h"

@interface QSPropertyHomeSwipeCell ()

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *blockchainLabel;

@end

@implementation QSPropertyHomeSwipeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    [self.contentView addSubview:self.cardImageView];
    
    [self.cardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cardImageView).offset(kRealValue(30));
        make.top.equalTo(self.cardImageView).offset(kRealValue(20));
        make.size.mas_equalTo(CGSizeMake(kRealValue(29), kRealValue(29)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftImageView);
        make.left.equalTo(self.leftImageView.mas_right).offset(kRealValue(10));
        make.right.equalTo(self.cardImageView).offset(-kRealValue(20));
        make.height.equalTo(@kRealValue(17));
    }];
    
    [self.blockchainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRealValue(5));
        make.right.equalTo(self.cardImageView).offset(-kRealValue(20));
        make.height.equalTo(@kRealValue(33));
    }];
}

#pragma mark - ***************** Event Response
- (void)tap {
    if (self.swipeCellClickedBlock) {
        self.swipeCellClickedBlock(self);
    }
}

#pragma mark - ***************** Setter Getter
- (UIImageView *)cardImageView {
    if (!_cardImageView) {
        _cardImageView = [[UIImageView alloc] init];
        _cardImageView.contentMode = UIViewContentModeScaleAspectFill;
        _cardImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        _cardImageView.image = [UIImage imageNamed:@"img_home_banner"];
        [_cardImageView addGestureRecognizer:tapGes];
    }
    return _cardImageView;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_leftImageView setImage:[UIImage imageNamed:@"icon_fukuan_evt"]];
        _leftImageView.layer.cornerRadius = kRealValue(14.5);
        _leftImageView.layer.masksToBounds = YES;
        [self.cardImageView addSubview:_leftImageView];
    }
    return _leftImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = [QSWalletHelper sharedHelper].currentEvt.evtShowName;
        _titleLabel.textColor = [UIColor qs_colorBlack333333];
        _titleLabel.font = [UIFont qs_fontOfSize15];
        [self.cardImageView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)blockchainLabel {
    if (!_blockchainLabel) {
        _blockchainLabel = [[UILabel alloc] init];
        _blockchainLabel.text = [QSWalletHelper sharedHelper].currentEvt.publicKey;
        _blockchainLabel.textColor = [UIColor qs_colorGray686868];
        _blockchainLabel.font = [UIFont qs_fontOfSize13];
        _blockchainLabel.numberOfLines = 2;
        [self.cardImageView addSubview:_blockchainLabel];
    }
    return _blockchainLabel;
}


@end
