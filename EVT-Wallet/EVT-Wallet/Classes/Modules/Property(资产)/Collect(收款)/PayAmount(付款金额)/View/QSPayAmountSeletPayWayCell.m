//
//  QSPayAmountSeletPayWayCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/6.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSPayAmountSeletPayWayCell.h"
#import "QSPayAmountItem.h"

@interface QSPayAmountSeletPayWayCell ()

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *walletNameLabel;
@property (nonatomic, strong) UILabel *walletTipsLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation QSPayAmountSeletPayWayCell

- (void)configureSubViews {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.walletNameLabel];
    [self.contentView addSubview:self.walletTipsLabel];
    [self.contentView addSubview:self.arrowImageView];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kRealValue(20));
        make.centerY.equalTo(self.contentView);
        make.width.and.height.equalTo(@kRealValue(27));
    }];
    
    [self.walletNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY).offset(-kRealValue(5));
        make.left.equalTo(self.leftImageView.mas_right).offset(kRealValue(14));
        make.right.equalTo(self.arrowImageView.mas_left).offset(-kRealValue(14));
        make.height.equalTo(@([UIFont qs_fontOfSize15].lineHeight));
    }];
    
    [self.walletTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_centerY).offset(kRealValue(5));
        make.left.and.right.equalTo(self.walletNameLabel);
        make.height.equalTo(@([UIFont qs_fontOfSize14].lineHeight));
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftImageView);
        make.right.equalTo(self.contentView).offset(-kRealValue(13));
        make.width.and.height.equalTo(@kRealValue(22));
    }];
}

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    self.item = item;
    QSPayAmountItem *payItem = (QSPayAmountItem *)item;
    QSFT *FTModel = payItem.FTModel;
    
    if (FTModel.assetImage) {
        self.leftImageView.image = FTModel.assetImage;
    } else {
        [self.leftImageView setImage:[UIImage imageNamed:@"icon_fukuan_evt"]];
    }
    
    NSArray *totlyList = [FTModel.asset componentsSeparatedByString:@" "];
    if (totlyList.count == 2) {
        NSMutableString *test = [NSMutableString stringWithString:totlyList[1]];
        if([test hasPrefix:@"S"]){
            [test deleteCharactersInRange: [test rangeOfString:@"S"]];
        }
        self.walletNameLabel.text = [NSString stringWithFormat:@"%@(%@)",FTModel.sym_name,test];
    } else {
        self.walletNameLabel.text = FTModel.name;
    }
}

#pragma mark - **************** Setter Getter
- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"icon_erweima_evt"];
        _leftImageView.layer.cornerRadius = kRealValue(13.5);
        _leftImageView.layer.masksToBounds = YES;
    }
    return _leftImageView;
}

- (UILabel *)walletNameLabel {
    if (!_walletNameLabel) {
        _walletNameLabel = [UILabel labelWithName:@"EVT(#1)" font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentLeft];
    }
    return _walletNameLabel;
}

- (UILabel *)walletTipsLabel {
    if (!_walletTipsLabel) {
        _walletTipsLabel = [UILabel labelWithName:QSLocalizedString(@"qs_pay_amount_select_payway_tips") font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGrayBBBBBB] textAlignment:NSTextAlignmentLeft];
    }
    return _walletTipsLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"icon_fukuan_enter"];
    }
    return _arrowImageView;
}

@end
