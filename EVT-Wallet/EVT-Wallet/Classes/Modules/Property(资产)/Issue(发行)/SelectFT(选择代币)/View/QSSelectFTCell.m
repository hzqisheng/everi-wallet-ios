//
//  QSSelectFTCell.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/11.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSSelectFTCell.h"

@implementation QSSelectFTCell

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
        make.left.equalTo(self.leftImageView.mas_right).offset(kRealValue(16));
        make.right.equalTo(self.moreButton.mas_left).offset(-kRealValue(20));
        make.top.equalTo(self.cornerView).offset(kRealValue(26));
        make.height.equalTo(@kRealValue(15));
    }];
    
    [self.blockchainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRealValue(10));
        make.right.equalTo(self.cornerView).offset(-kRealValue(20));
        make.height.equalTo(@kRealValue(15));
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.cornerView).offset(-kRealValue(17));
        make.top.equalTo(self.cornerView).offset(kRealValue(19));
        make.size.mas_equalTo(CGSizeMake(kRealValue(22), kRealValue(22)));
    }];
}

#pragma mark - **************** Event Response
- (void)moreSettingAction {
    if (self.selectFTCellDidClickMoreButtonBlock) {
        self.selectFTCellDidClickMoreButtonBlock(self);
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
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        _leftImageView.layer.cornerRadius = kRealValue(14.5);
        _leftImageView.layer.masksToBounds = YES;
        [self.cornerView addSubview:_leftImageView];
    }
    return _leftImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.text = @"EOS-wallet";
        _titleLabel.textColor = [UIColor qs_colorBlack333333];
        _titleLabel.font = [UIFont qs_fontOfSize15];
        [self.cornerView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)blockchainLabel {
    if (!_blockchainLabel) {
        _blockchainLabel = [[UILabel alloc] init];
//        _blockchainLabel.text = @"EOS5fKva...UBt7gBagC";
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

- (void)setFtModel:(QSFT *)ftModel {
    _ftModel = ftModel;
    
    self.leftImageView.image = ftModel.assetImage;

    NSArray *totlyList = [ftModel.total_supply componentsSeparatedByString:@" "];
    if (totlyList.count == 2) {
        NSMutableString *test = [NSMutableString stringWithString:totlyList[1]];
        if([test hasPrefix:@"S"]){
            [test deleteCharactersInRange: [test rangeOfString:@"S"]];
        }
        self.titleLabel.text = [NSString stringWithFormat:@"%@(%@)",ftModel.sym_name,test];
    } else {
        self.titleLabel.text = ftModel.name;
    }
    NSString *totlyStr = totlyList[0];
    NSArray *currentList = [ftModel.current_supply componentsSeparatedByString:@" "];
    NSString *currentStr = currentList[0];
    NSInteger last = [totlyStr integerValue] - [currentStr integerValue];
    NSString *lastStr = [NSString stringWithFormat:@"%ld.",(long)last];
    
    NSArray *jinduList = [ftModel.sym componentsSeparatedByString:@","];
    NSString *jinduStr = jinduList[0];
    for (int i = 0; i < [jinduStr integerValue]; i++) {
        lastStr = [lastStr stringByAppendingString:@"0"];
    }
    
    self.blockchainLabel.text = [NSString stringWithFormat:@"%@:%@,%@:%@",QSLocalizedString(@"qs_select_ft_total_ft_titlte"),totlyStr,QSLocalizedString(@"qs_select_ft_remaining_ft_titlte"),lastStr];
}

@end
