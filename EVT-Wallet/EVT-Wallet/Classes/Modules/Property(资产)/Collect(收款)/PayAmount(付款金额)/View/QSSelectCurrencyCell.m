//
//  QSSelectCurrencyCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/6.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSSelectCurrencyCell.h"

@interface QSSelectCurrencyCell ()

/** left imageView */
@property (nonatomic,strong) UIImageView *leftImageView;
/** left titleLabel */
@property (nonatomic,strong) UILabel *leftTitleLabel;
/** right titleLabel */
@property (nonatomic,strong) UILabel *rightTitleLabel;

@end

@implementation QSSelectCurrencyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setupSubviews];
    }
    return self;
}

- (void)p_setupSubviews {
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.leftTitleLabel];
    [self.contentView addSubview:self.rightTitleLabel];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kRealValue(25));
        make.width.and.height.equalTo(@kRealValue(27));
    }];
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.leftImageView.mas_right).offset(kRealValue(14));
        make.right.equalTo(self.rightTitleLabel.mas_left).offset(kRealValue(5));
    }];
    
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-kRealValue(35));
        make.width.lessThanOrEqualTo(@(kScreenWidth/2));
    }];
}

#pragma mark - **************** Setter Getter
- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}

- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [UILabel labelWithName:@"HAO(#2）" font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentLeft];
    }
    return _leftTitleLabel;
}

- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [UILabel labelWithName:@"最大付款金额：10" font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorGrayBBBBBB] textAlignment:NSTextAlignmentLeft];
    }
    return _rightTitleLabel;
}


@end
