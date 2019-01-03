//
//  QSManagerSettingView.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/13.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSManagerSettingView.h"

@interface QSManagerSettingView ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UILabel *thirdLabel;
@property (nonatomic, strong) UIView *firstLine;
@property (nonatomic, strong) UIView *secondLine;
@property (nonatomic, strong) UIButton *firstButton;
@property (nonatomic, strong) UIButton *secondButton;
@property (nonatomic, strong) UIButton *thirdButton;

@property (nonatomic, strong) UIButton *touchFirstButton;
@property (nonatomic, strong) UIButton *touchSecondButton;
@property (nonatomic, strong) UIButton *touchThirdButton;


@end

@implementation QSManagerSettingView

+ (void)showManagerSettingViewWithTag:(NSInteger)btnTag andEditBlock:(void (^)(void))block andSelectBlock:(void (^)(void))selectBlock andEnterKeyBlock:(void (^)(void))enterKeyBlock {
    QSManagerSettingView *view = [[QSManagerSettingView alloc] initWithFrame:kScreenBounds];
    view.managerSettingViewEditBlock = block;
    view.managerSettingViewSelectAddressBlock = selectBlock;
    view.managerSettingViewEnterKeyBlock = enterKeyBlock;
    switch (btnTag) {
        case 1:
        {
            view.firstButton.selected = YES;
            view.secondButton.selected = NO;
            view.thirdButton.selected = NO;
        }
            break;
        case 2:
        {
            view.firstButton.selected = NO;
            view.secondButton.selected = YES;
            view.thirdButton.selected = NO;
        }
            break;
        case 3:
        {
            view.firstButton.selected = NO;
            view.secondButton.selected = NO;
            view.thirdButton.selected = YES;
        }
            break;
    }
    [view showWithAnimation];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.5f];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissWithAnimation)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kRealValue(176));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - kRealValue(60), kRealValue(136)));
    }];
    
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.top.equalTo(self.whiteView).offset(kRealValue(16));
        make.height.equalTo(@kRealValue(15));
    }];
    
    [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteView).offset(-kRealValue(17));
        make.centerY.equalTo(self.firstLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(22), kRealValue(22)));
    }];
    
    [self.firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.whiteView);
        make.top.equalTo(self.whiteView).offset(kRealValue(45));
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.top.equalTo(self.firstLine.mas_bottom).offset(kRealValue(16));
        make.height.equalTo(@kRealValue(15));
    }];
    
    [self.secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteView).offset(-kRealValue(17));
        make.centerY.equalTo(self.secondLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(22), kRealValue(22)));
    }];
    
    [self.secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.whiteView);
        make.top.equalTo(self.firstLine.mas_bottom).offset(kRealValue(45));
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.top.equalTo(self.secondLine.mas_bottom).offset(kRealValue(16));
        make.height.equalTo(@kRealValue(15));
    }];
    
    [self.thirdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteView).offset(-kRealValue(17));
        make.centerY.equalTo(self.thirdLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(22), kRealValue(22)));
    }];
    
    [self.touchFirstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.whiteView);
        make.top.equalTo(self.whiteView);
        make.height.equalTo(@kRealValue(45));
    }];
    
    [self.touchSecondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.whiteView);
        make.top.equalTo(self.firstLine.mas_bottom);
        make.height.equalTo(@kRealValue(45));
    }];
    
    [self.touchThirdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.whiteView);
        make.top.equalTo(self.secondLine.mas_bottom);
        make.height.equalTo(@kRealValue(45));
    }];
}

#pragma mark - **************** Event Response
- (void)didClickButton:(UIButton *)button {
    if (button.tag == 1) {
        if (self.managerSettingViewEditBlock) {
            self.managerSettingViewEditBlock();
        }
    }
    if (button.tag == 2) {
        if (self.managerSettingViewSelectAddressBlock) {
            self.managerSettingViewSelectAddressBlock();
        }
    }
    if (button.tag == 3) {
        if (self.managerSettingViewEnterKeyBlock) {
            self.managerSettingViewEnterKeyBlock();
        }
    }
    [self dismissWithAnimation];
}


#pragma mark - **************** Private Methods
- (void)showWithAnimation {
    [QSAppKeyWindow addSubview:self];
    self.alpha = 0;
    self.whiteView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        self.whiteView.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    } completion:nil];
}

- (void)dismissWithAnimation {
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        self.whiteView.transform = CGAffineTransformMakeScale(0.2,0.2);
        self.whiteView.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - **************** UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.whiteView]) {
        return NO;
    }
    return YES;
}

#pragma mark - **************** Setter Getter
- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _whiteView.layer.cornerRadius = kRealValue(8);
        [self addSubview:_whiteView];
    }
    return _whiteView;
}

- (UILabel *)firstLabel {
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc] init];
        _firstLabel.text = QSLocalizedString(@"qs_manage_createGroup_manager_State1");
        _firstLabel.textColor = [UIColor qs_colorBlack333333];
        _firstLabel.font = [UIFont qs_fontOfSize15];
        [self.whiteView addSubview:_firstLabel];
    }
    return _firstLabel;
}

- (UILabel *)secondLabel {
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc] init];
        _secondLabel.text = QSLocalizedString(@"qs_manage_createGroup_manager_State2");
        _secondLabel.textColor = [UIColor qs_colorBlack333333];
        _secondLabel.font = [UIFont qs_fontOfSize15];
        [self.whiteView addSubview:_secondLabel];
    }
    return _secondLabel;
}

- (UILabel *)thirdLabel {
    if (!_thirdLabel) {
        _thirdLabel = [[UILabel alloc] init];
        _thirdLabel.text = QSLocalizedString(@"qs_manage_createGroup_manager_State3");
        _thirdLabel.textColor = [UIColor qs_colorBlack333333];
        _thirdLabel.font = [UIFont qs_fontOfSize15];
        [self.whiteView addSubview:_thirdLabel];
    }
    return _thirdLabel;
}

- (UIButton *)firstButton {
    if (!_firstButton) {
        _firstButton = [[UIButton alloc] init];
        [_firstButton setImage:[UIImage imageNamed:@"icon_chuangjianzu_selected"] forState:UIControlStateSelected];
        [self.whiteView addSubview:_firstButton];
    }
    return _firstButton;
}

- (UIButton *)secondButton {
    if (!_secondButton) {
        _secondButton = [[UIButton alloc] init];
        [_secondButton setImage:[UIImage imageNamed:@"icon_chuangjianzu_selected"] forState:UIControlStateSelected];
        [self.whiteView addSubview:_secondButton];
    }
    return _secondButton;
}

- (UIButton *)thirdButton {
    if (!_thirdButton) {
        _thirdButton = [[UIButton alloc] init];
        [_thirdButton setImage:[UIImage imageNamed:@"icon_chuangjianzu_selected"] forState:UIControlStateSelected];
        [self.whiteView addSubview:_thirdButton];
    }
    return _thirdButton;
}

- (UIView *)firstLine {
    if (!_firstLine) {
        _firstLine = [[UIView alloc] init];
        _firstLine.backgroundColor = [UIColor qs_colorGrayCCCCCC];
        [self.whiteView addSubview:_firstLine];
    }
    return _firstLine;
}

- (UIView *)secondLine {
    if (!_secondLine) {
        _secondLine = [[UIView alloc] init];
        _secondLine.backgroundColor = [UIColor qs_colorGrayCCCCCC];
        [self.whiteView addSubview:_secondLine];
    }
    return _secondLine;
}

- (UIButton *)touchFirstButton {
    if (!_touchFirstButton) {
        _touchFirstButton = [[UIButton alloc] init];
        _touchFirstButton.backgroundColor = [UIColor clearColor];
        _touchFirstButton.tag = 1;
        [_touchFirstButton addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:_touchFirstButton];
    }
    return _touchFirstButton;
}

- (UIButton *)touchSecondButton {
    if (!_touchSecondButton) {
        _touchSecondButton = [[UIButton alloc] init];
        _touchSecondButton.backgroundColor = [UIColor clearColor];
        _touchSecondButton.tag = 2;
        [_touchSecondButton addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:_touchSecondButton];
    }
    return _touchSecondButton;
}

- (UIButton *)touchThirdButton {
    if (!_touchThirdButton) {
        _touchThirdButton = [[UIButton alloc] init];
        _touchThirdButton.backgroundColor = [UIColor clearColor];
        _touchThirdButton.tag = 3;
        [_touchThirdButton addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:_touchThirdButton];
    }
    return _touchThirdButton;
}

@end
