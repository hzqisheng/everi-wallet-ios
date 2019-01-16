//
//  QSBatchCreateNFTsBottomView.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/13.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBatchCreateNFTsBottomView.h"

@implementation QSBatchCreateNFTsBottomView

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
        make.right.equalTo(self.addButton.mas_left).offset(-kRealValue(24));
        make.centerY.equalTo(self.nameTextField);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kRealValue(20));
        make.centerY.equalTo(self.nameTextField);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self.nameTextField.mas_bottom);
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRealValue(20));
        make.top.equalTo(self.lineView.mas_bottom).offset(kRealValue(18));
        make.right.equalTo(self.deleteButton.mas_left).offset(-kRealValue(20));
        make.height.equalTo(@kRealValue(14));
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kRealValue(20));
        make.centerY.equalTo(self.addressLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
}

#pragma mark - **************** Event Response
- (void)subtractAction {
    if (self.batchCreateNFTsBottomViewScanBtnClickedBlock) {
        self.batchCreateNFTsBottomViewScanBtnClickedBlock();
    }

}

- (void)addAction {
    self.addressLabel.text = self.nameTextField.text;
    self.nameTextField.text = @"";
}

- (void)deleteAction {
    self.addressLabel.text = @"";
}

#pragma mark - **************** Setter Getter
- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.placeholder = QSLocalizedString(@"qs_add_address_item_address_placeholder");
        _nameTextField.textColor = [UIColor qs_colorBlack333333];
        _nameTextField.font = [UIFont qs_fontOfSize14];
        [_nameTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        [_nameTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:_nameTextField];
    }
    return _nameTextField;
}

- (UIButton *)subtractButton {
    if (!_subtractButton) {
        _subtractButton = [[UIButton alloc] init];
        [_subtractButton setImage:[UIImage imageNamed:@"icon_wodeyu_sweep"] forState:UIControlStateNormal];
        [_subtractButton addTarget:self action:@selector(subtractAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_subtractButton];
    }
    return _subtractButton;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] init];
        [_addButton setImage:[UIImage imageNamed:@"icon_wodeyu_plus1"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addButton];
    }
    return _addButton;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor qs_colorGrayDDDDDD];
        [self addSubview:_lineView];
    }
    return _lineView;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.textColor = [UIColor qs_colorGray686868];
        _addressLabel.font = [UIFont qs_fontOfSize14];
        [self addSubview:_addressLabel];
    }
    return _addressLabel;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setImage:[UIImage imageNamed:@"icon_wodeyu_cancel"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_deleteButton];
    }
    return _deleteButton;
}

@end
