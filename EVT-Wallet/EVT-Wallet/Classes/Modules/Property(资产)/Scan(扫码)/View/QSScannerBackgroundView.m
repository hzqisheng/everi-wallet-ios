//
//  QSScannerBackgroundView.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSScannerBackgroundView.h"

@interface QSScannerBackgroundView ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *btmView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;

@end

@implementation QSScannerBackgroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.topView];
        [self addSubview:self.btmView];
        [self addSubview:self.leftView];
        [self addSubview:self.rightView];
    }
    return self;
}

#pragma mark - Public Methods -
- (void)addMasonryWithContainView:(UIView *)containView
{
    UIView *scannerView = containView;
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(self);
        make.bottom.mas_equalTo(scannerView.mas_top);
    }];
    [self.btmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self);
        make.top.mas_equalTo(scannerView.mas_bottom);
    }];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(scannerView.mas_left);
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.bottom.mas_equalTo(self.btmView.mas_top);
    }];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scannerView.mas_right);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.bottom.mas_equalTo(self.btmView.mas_top);
    }];
}

#pragma mark - Getter -
- (UIView *)topView
{
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        [_topView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    }
    return _topView;
}

- (UIView *)btmView
{
    if (_btmView == nil) {
        _btmView = [[UIView alloc] init];
        [_btmView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    }
    return _btmView;
}

- (UIView *)leftView
{
    if (_leftView == nil) {
        _leftView = [[UIView alloc] init];
        [_leftView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    }
    return _leftView;
}

- (UIView *)rightView
{
    if (_rightView == nil) {
        _rightView = [[UIView alloc] init];
        [_rightView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    }
    return _rightView;
}


@end
