//
//  QSQRCodeBottomToolBar.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSQRCodeBottomToolBar.h"
#import "QSTopImageBottomLabelButton.h"

@interface QSQRCodeBottomToolBar()

@property (nonatomic, strong) QSTopImageBottomLabelButton *codeButton;
@property (nonatomic, strong) UIView *verticalLine;
@property (nonatomic, strong) QSTopImageBottomLabelButton *scanButton;

@end

@implementation QSQRCodeBottomToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor qs_colorBlack313745];
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    [self addSubview:self.codeButton];
    [self addSubview:self.verticalLine];
    [self addSubview:self.scanButton];
    
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self);
        make.right.equalTo(self.mas_centerX);
        make.height.equalTo(@kRealValue(65));
    }];
    
    [self.verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kRealValue(14));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kRealValue(1), kRealValue(39)));
    }];

    [self.scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.equalTo(self);
        make.left.equalTo(self.mas_centerX);
        make.height.equalTo(@kRealValue(65));
    }];
}

+ (CGFloat)toolBarHeight {
    return kRealValue(65) + kiPhoneXSafeAreaBottomMagin;
}

#pragma mark - **************** Event Response
- (void)codeButtonClicked {
    if (self.clickedItemBlock) {
        self.clickedItemBlock(0);
    }
}

- (void)scanButtonClicked {
    if (self.clickedItemBlock) {
        self.clickedItemBlock(1);
    }
}

#pragma mark - **************** Setter Getter
- (UIButton *)codeButton {
    if (!_codeButton) {
        _codeButton = [[QSTopImageBottomLabelButton alloc] init];
        [_codeButton setImage:[UIImage imageNamed:@"icon_erweima_pay_unselected"] forState:UIControlStateNormal];
        [_codeButton setImage:[UIImage imageNamed:@"icon_erweima_pay_selected"] forState:UIControlStateSelected];
        [_codeButton addTarget:self action:@selector(codeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _codeButton.titleLabel.font = [UIFont qs_fontOfSize12];
        [_codeButton setTitleColor:[UIColor qs_colorGrayBBBBBB] forState:UIControlStateNormal];
        [_codeButton setTitleColor:[UIColor qs_colorYellowE4B84F] forState:UIControlStateSelected];
        _codeButton.selected = YES;
    }
    return _codeButton;
}

- (UIView *)verticalLine {
    if (!_verticalLine) {
        _verticalLine = [[UIView alloc] init];
        _verticalLine.backgroundColor = [UIColor qs_colorGrayCCCCCC];
    }
    return _verticalLine;
}

- (UIButton *)scanButton {
    if (!_scanButton) {
        _scanButton = [[QSTopImageBottomLabelButton alloc] init];
        [_scanButton setImage:[UIImage imageNamed:@"icon_erweima_sweep_unselected"] forState:UIControlStateNormal];
        [_scanButton setImage:[UIImage imageNamed:@"icon_erweima_sweep_selected"] forState:UIControlStateSelected];
        [_scanButton addTarget:self action:@selector(scanButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _scanButton.titleLabel.font = [UIFont qs_fontOfSize12];
        [_scanButton setTitleColor:[UIColor qs_colorGrayBBBBBB] forState:UIControlStateNormal];
        [_scanButton setTitleColor:[UIColor qs_colorYellowE4B84F] forState:UIControlStateSelected];
    }
    return _scanButton;
}

- (void)setCodeTitle:(NSString *)codeTitle {
    _codeTitle = codeTitle;
    [self.codeButton setTitle:codeTitle forState:UIControlStateNormal];
}

- (void)setScanTitle:(NSString *)scanTitle {
    _scanTitle = scanTitle;
    [self.scanButton setTitle:scanTitle forState:UIControlStateNormal];
}

@end
