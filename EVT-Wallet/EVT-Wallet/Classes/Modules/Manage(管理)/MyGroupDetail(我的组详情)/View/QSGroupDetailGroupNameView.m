//
//  QSGroupDetailGroupNameView.m
//  EVT-Wallet
//
//  Created by SJ on 2019/5/10.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSGroupDetailGroupNameView.h"

@interface QSGroupDetailGroupNameView ()

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *nameTitleLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *nameLine;

@property (nonatomic, strong) UILabel *thresholdTitleLabel;
@property (nonatomic, strong) UILabel *thresholdCountLabel;
@property (nonatomic, strong) UIView *sholdLine;

@end

@implementation QSGroupDetailGroupNameView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kRealValue(15));;
        make.bottom.equalTo(self).offset(-kRealValue(15));;
        make.left.and.right.equalTo(self);
    }];
    
    [self.nameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(15));
        make.top.equalTo(self.whiteView).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteView).offset(-kRealValue(15));
        make.centerY.equalTo(self.nameTitleLabel);
        make.left.equalTo(self.nameTitleLabel.mas_right).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(55));
    }];
    
    [self.nameLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(15));
        make.right.equalTo(self.whiteView).offset(-kRealValue(15));
        make.top.equalTo(self.whiteView).offset(kRealValue(55));
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.thresholdTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(15));
        make.top.equalTo(self.nameLine.mas_bottom).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.thresholdCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteView).offset(-kRealValue(15));
        make.centerY.equalTo(self.thresholdTitleLabel);
        make.left.equalTo(self.thresholdTitleLabel.mas_right).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(55));
    }];
    
//    [self.sholdLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.whiteView).offset(kRealValue(15));
//        make.right.equalTo(self.whiteView).offset(-kRealValue(15));
//        make.top.equalTo(self.nameLine.mas_bottom).offset(kRealValue(55));
//        make.height.equalTo(@BORDER_WIDTH_1PX);
//    }];
}

- (void)configureViewByGroupName:(NSString *)groupName threshold:(NSString *)threshold {
    self.nameLabel.text = groupName;
    self.thresholdCountLabel.text = threshold;
}

#pragma mark - ***************** Setter Getter
- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _whiteView.layer.cornerRadius = kRealValue(8);
        [self addSubview:_whiteView];
    }
    return _whiteView;
}

- (UILabel *)nameTitleLabel {
    if (!_nameTitleLabel) {
        _nameTitleLabel = [[UILabel alloc] init];
        _nameTitleLabel.text = QSLocalizedString(@"qs_add_address_item_name_title");
        _nameTitleLabel.textColor = [UIColor qs_colorBlack333333];
        _nameTitleLabel.font = [UIFont qs_fontOfSize14];
        [self.whiteView addSubview:_nameTitleLabel];
    }
    return _nameTitleLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentRight;
        _nameLabel.textColor = [UIColor qs_colorBlack333333];
        _nameLabel.font = [UIFont qs_fontOfSize14];
        [self.whiteView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UIView *)nameLine {
    if (!_nameLine) {
        _nameLine = [[UIView alloc] init];
        _nameLine.backgroundColor = [UIColor qs_colorGrayDDDDDD];
        [self.whiteView addSubview:_nameLine];
    }
    return _nameLine;
}

- (UILabel *)thresholdTitleLabel {
    if (!_thresholdTitleLabel) {
        _thresholdTitleLabel = [[UILabel alloc] init];
        _thresholdTitleLabel.text = QSLocalizedString(@"qs_manage_createGroup_threshold");
        _thresholdTitleLabel.textColor = [UIColor qs_colorBlack333333];
        _thresholdTitleLabel.font = [UIFont qs_fontOfSize14];
        [self.whiteView addSubview:_thresholdTitleLabel];
    }
    return _thresholdTitleLabel;
}

- (UILabel *)thresholdCountLabel {
    if (!_thresholdCountLabel) {
        _thresholdCountLabel = [[UILabel alloc] init];
        _thresholdCountLabel.textAlignment = NSTextAlignmentRight;
        _thresholdCountLabel.textColor = [UIColor qs_colorBlack333333];
        _thresholdCountLabel.font = [UIFont qs_fontOfSize14];
        [self.whiteView addSubview:_thresholdCountLabel];
    }
    return _thresholdCountLabel;
}

- (UIView *)sholdLine {
    if (!_sholdLine) {
        _sholdLine = [[UIView alloc] init];
        _sholdLine.backgroundColor = [UIColor qs_colorGrayDDDDDD];
        [self.whiteView addSubview:_sholdLine];
    }
    return _sholdLine;
}

@end
