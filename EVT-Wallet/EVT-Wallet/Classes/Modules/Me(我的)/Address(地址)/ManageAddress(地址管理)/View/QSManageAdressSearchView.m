//
//  QSManageAdressSearchView.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSManageAdressSearchView.h"
#import "QSSelectMenuView.h"

@interface QSManageAdressSearchView ()

@property (nonatomic, strong) UIView *searchTypeSelectView;
@property (nonatomic, strong) UILabel *searchTypeLabel;
@property (nonatomic, strong) UIImageView *searchTypeMoreImageView;

@property (nonatomic, strong) UIView *searchGroupSelectView;
@property (nonatomic, strong) UILabel *searchGroupLabel;
@property (nonatomic, strong) UIImageView *searchGroupMoreImageView;

@property (nonatomic, strong) UIButton *searchButton;

@end

@implementation QSManageAdressSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    //typeView
    [self addSubview:self.searchTypeSelectView];
    [self.searchTypeSelectView addSubview:self.searchTypeLabel];
    [self.searchTypeSelectView addSubview:self.searchTypeMoreImageView];
    
    [self.searchTypeSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRealValue(15));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kRealValue(105), kRealValue(31)));
    }];
    
    [self.searchTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchTypeSelectView).offset(kRealValue(10));
        make.right.equalTo(self.searchTypeMoreImageView.mas_left).offset(-kRealValue(10));
        make.centerY.equalTo(self.searchTypeSelectView);
    }];
    
    [self.searchTypeMoreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchTypeSelectView);
        make.right.equalTo(self.searchTypeSelectView.mas_right).offset(-kRealValue(3));
        make.width.and.height.equalTo(@kRealValue(22));
    }];
    
    //groupView
    [self addSubview:self.searchGroupSelectView];
    [self.searchGroupSelectView addSubview:self.searchGroupLabel];
    [self.searchGroupSelectView addSubview:self.searchGroupMoreImageView];
    
    [self.searchGroupSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchTypeSelectView.mas_right).offset(kRealValue(7));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kRealValue(105), kRealValue(31)));
    }];
    
    [self.searchGroupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchGroupSelectView).offset(kRealValue(10));
        make.right.equalTo(self.searchGroupMoreImageView.mas_left).offset(-kRealValue(10));
        make.centerY.equalTo(self.searchGroupSelectView);
    }];
    
    [self.searchGroupMoreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchGroupSelectView);
        make.right.equalTo(self.searchGroupSelectView.mas_right).offset(-kRealValue(3));
        make.width.and.height.equalTo(@kRealValue(22));
    }];

    //searchButton
    [self addSubview:self.searchButton];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kRealValue(15));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kRealValue(70), kRealValue(31)));
    }];
}

#pragma mark - **************** Event Response
- (void)searchButtonClicked {
    
}

- (void)searchTypeSelectViewClicked {
    
}

- (void)searchGroupSelectViewClicked {
    
}

#pragma mark - **************** Setter Getter
- (UIView *)searchTypeSelectView {
    if (!_searchTypeSelectView) {
        _searchTypeSelectView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchTypeSelectViewClicked)];
        [_searchTypeSelectView addGestureRecognizer:tap];
        _searchTypeSelectView.layer.borderWidth = 1;
        _searchTypeSelectView.layer.borderColor = [UIColor qs_colorGrayCCCCCC].CGColor;
    }
    return _searchTypeSelectView;
}

- (UILabel *)searchTypeLabel {
    if (!_searchTypeLabel) {
        _searchTypeLabel = [UILabel labelWithName:@"全部" font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentLeft];
    }
    return _searchTypeLabel;
}

- (UIImageView *)searchTypeMoreImageView {
    if (!_searchTypeMoreImageView) {
        _searchTypeMoreImageView = [[UIImageView alloc] init];
        _searchTypeMoreImageView.image = [UIImage imageNamed:@"icon_dizhiguanli_expand"];
    }
    return _searchTypeMoreImageView;
}

- (UIView *)searchGroupSelectView {
    if (!_searchGroupSelectView) {
        _searchGroupSelectView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchGroupSelectViewClicked)];
        [_searchGroupSelectView addGestureRecognizer:tap];
        _searchGroupSelectView.layer.borderWidth = 1;
        _searchGroupSelectView.layer.borderColor = [UIColor qs_colorGrayCCCCCC].CGColor;
    }
    return _searchGroupSelectView;
}

- (UILabel *)searchGroupLabel {
    if (!_searchGroupLabel) {
        _searchGroupLabel = [UILabel labelWithName:@"选择组" font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentLeft];
    }
    return _searchGroupLabel;
}

- (UIImageView *)searchGroupMoreImageView {
    if (!_searchGroupMoreImageView) {
        _searchGroupMoreImageView = [[UIImageView alloc] init];
        _searchGroupMoreImageView.image = [UIImage imageNamed:@"icon_dizhiguanli_expand"];
    }
    return _searchGroupMoreImageView;
}

- (UIButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_manage_address_btn_search") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(searchButtonClicked)];
        _searchButton.backgroundColor = [UIColor qs_colorBlack313745];
    }
    return _searchButton;
}

@end
