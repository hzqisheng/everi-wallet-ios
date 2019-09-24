//
//  QSBatchCreateNFTSCenterView.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/13.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBatchCreateNFTSCenterView.h"

@implementation QSBatchCreateNFTSCenterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRealValue(20));
        make.top.equalTo(self);
        make.right.equalTo(self.subtractButton.mas_left).offset(-kRealValue(10));
        make.height.equalTo(@kRealValue(45));
    }];
    
    [self.subtractButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.countLabel.mas_left);
        make.centerY.equalTo(self.nameTextField);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kRealValue(20));
        make.centerY.equalTo(self.nameTextField);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.addButton.mas_left);
        make.centerY.equalTo(self.nameTextField);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self.nameTextField.mas_bottom);
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.productButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kRealValue(20));
        make.top.equalTo(self.lineView.mas_bottom).offset(kRealValue(13));
        make.size.mas_equalTo(CGSizeMake(kRealValue(140), kRealValue(24)));
    }];
}

#pragma mark - **************** Event Response
- (void)subtractAction {
    if ([self.countLabel.text integerValue] > 1) {
        self.countLabel.text = [NSString stringWithFormat:@"%ld",[self.countLabel.text integerValue] - 1];
    }
}

- (void)addAction {
    if ([self.countLabel.text integerValue] < 10) {
        self.countLabel.text = [NSString stringWithFormat:@"%ld",[self.countLabel.text integerValue] + 1];
    }
}

- (void)productAction {
    if (self.batchCreateNFTSCenterViewCreateBtnClickedBlock) {
        self.batchCreateNFTSCenterViewCreateBtnClickedBlock();
    }
}

#pragma mark - **************** Setter Getter
- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.placeholder = QSLocalizedString(@"qs_pass_createNFTS_batch_centerView_placeholde");
        _nameTextField.textColor = [UIColor qs_colorBlack333333];
        _nameTextField.font = [UIFont qs_fontOfSize14];
//        [_nameTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
//        [_nameTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        
        //* iOS 13关闭了权限， 不允许KVC给PlaceholderLabel属性赋值 */
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc]  initWithString:QSLocalizedString(@"qs_pass_createNFTS_batch_centerView_placeholde") attributes:@{NSForegroundColorAttributeName : [UIColor qs_colorGrayBBBBBB], NSFontAttributeName : [UIFont qs_fontOfSize14]}];
        _nameTextField.attributedPlaceholder = placeholderString;
        
        _nameTextField.keyboardType = UIKeyboardTypeAlphabet;
        [self addSubview:_nameTextField];
    }
    return _nameTextField;
}

- (UIButton *)subtractButton {
    if (!_subtractButton) {
        _subtractButton = [[UIButton alloc] init];
        [_subtractButton setImage:[UIImage imageNamed:@"icon_wodeyu_minus"] forState:UIControlStateNormal];
        [_subtractButton addTarget:self action:@selector(subtractAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_subtractButton];
    }
    return _subtractButton;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] init];
        [_addButton setImage:[UIImage imageNamed:@"icon_wodeyu_plus"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addButton];
    }
    return _addButton;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.text = @"1";
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.textColor = [UIColor qs_colorGray686868];
        _countLabel.font = [UIFont qs_fontOfSize14];
        [self addSubview:_countLabel];
    }
    return _countLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor qs_colorGrayDDDDDD];
        [self addSubview:_lineView];
    }
    return _lineView;
}

- (UIButton *)productButton {
    if (!_productButton) {
        _productButton = [[UIButton alloc] init];
        _productButton.layer.cornerRadius = kRealValue(2);
        [_productButton setTitle:QSLocalizedString(@"qs_pass_createNFTS_batch_centerView_btn") forState:UIControlStateNormal];
        _productButton.backgroundColor = [UIColor qs_colorBlue4D7BF3];
        [_productButton setTitleColor:[UIColor qs_colorWhiteFFFFFF] forState:UIControlStateNormal];
        _productButton.titleLabel.font = [UIFont qs_fontOfSize13];
        [_productButton addTarget:self action:@selector(productAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_productButton];
    }
    return _productButton;
}

@end
