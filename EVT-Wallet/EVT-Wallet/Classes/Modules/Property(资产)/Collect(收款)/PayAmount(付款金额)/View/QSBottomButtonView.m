//
//  QSBottomButtonCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/6.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBottomButtonView.h"

@interface QSBottomButtonView ()

@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) ButtonClickedBlock buttonClickedBlock;

@end

@implementation QSBottomButtonView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title clickedBlock:(ButtonClickedBlock)block {
    QSBottomButtonView *view = [[QSBottomButtonView alloc] initWithFrame:frame];
    view.title = title;
    view.buttonClickedBlock = block;
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bottomButton];
        [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kBottomButtonWidth, kBottomButtonHeight));
        }];
    }
    return self;
}

#pragma mark - **************** Setter Getter
- (void)bottomButtonClicked {
    if (self.buttonClickedBlock) {
        self.buttonClickedBlock();
    }
}

#pragma mark - **************** Setter Getter
- (UIButton *)bottomButton {
    if (!_bottomButton) {
        _bottomButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_me_btn_logout") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(bottomButtonClicked)];
        _bottomButton.backgroundColor = [UIColor qs_colorBlack313745];
        _bottomButton.layer.cornerRadius = 4;
    }
    return _bottomButton;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self.bottomButton setTitle:title forState:UIControlStateNormal];
}

@end
