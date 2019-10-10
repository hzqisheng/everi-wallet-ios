//
//  QSTransactionRecordHeaderView.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSTransactionRecordHeaderView.h"

@interface QSTransactionRecordHeaderView ()

@property (nonatomic, strong) UIImageView *avartarImageView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UILabel *currencyLabel;
@property (nonatomic, strong) UILabel *amountLabel;

@end

@implementation QSTransactionRecordHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.avartarImageView];
    [self addSubview:self.currencyLabel];
    [self addSubview:self.amountLabel];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.avartarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-kRealValue(103));
        make.left.equalTo(self).offset(kRealValue(80));
        make.width.and.height.equalTo(@kRealValue(57));
    }];
    
    [self.currencyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avartarImageView);
        make.left.equalTo(self.avartarImageView.mas_right).offset(kRealValue(15));
        make.right.equalTo(self).offset(-kRealValue(15));
    }];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avartarImageView.mas_bottom).offset(kRealValue(6));
        make.left.equalTo(@kRealValue(10));
        make.right.equalTo(@(-kRealValue(10)));
    }];
}

#pragma mark - **************** Setter Getter
- (UIImageView *)avartarImageView {
    if (!_avartarImageView) {
        _avartarImageView = [[UIImageView alloc] init];
        _avartarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avartarImageView.layer.cornerRadius = kRealValue(28.5);
        _avartarImageView.layer.masksToBounds = YES;
        _avartarImageView.backgroundColor = [UIColor clearColor];
    }
    return _avartarImageView;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.image = [UIImage imageNamed:@"bg_fukuan"];
    }
    return _backgroundImageView;
}

- (UILabel *)currencyLabel {
    if (!_currencyLabel) {
        _currencyLabel = [UILabel labelWithName:@"" font:[UIFont qs_fontOfSize15] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    }
    return _currencyLabel;
}

- (UILabel *)amountLabel {
    if (!_amountLabel) {
        _amountLabel = [UILabel labelWithName:@"" font:[UIFont qs_fontOfSize19] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    }
    return _amountLabel;
}

- (void)setFTModel:(QSFT *)FTModel {
    _FTModel = FTModel;
    
    self.avartarImageView.image = FTModel.assetImage;
    
    NSArray *assetList = [FTModel.asset componentsSeparatedByString:@" "];
    if (assetList.count == 2) {
        self.amountLabel.text = [NSString stringWithFormat:@"%@ %@",assetList[0],FTModel.sym_name];
    }
    
    NSArray *totlyList = [FTModel.asset componentsSeparatedByString:@" "];
    if (totlyList.count == 2) {
        self.amountLabel.text = totlyList[0];
        NSMutableString *test = [NSMutableString stringWithString:totlyList[1]];
        if([test hasPrefix:@"S"]){
            [test deleteCharactersInRange: [test rangeOfString:@"S"]];
        }
        self.currencyLabel.text = [NSString stringWithFormat:@"%@(%@)",FTModel.sym_name,test];
    } else {
        self.currencyLabel.text = FTModel.name;
    }
}

@end
