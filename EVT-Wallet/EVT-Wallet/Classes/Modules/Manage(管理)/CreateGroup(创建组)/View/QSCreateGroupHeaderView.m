//
//  QSCreateGroupHeaderView.m
//  EVT-Wallet
//
//  Created by SJ on 2019/5/7.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateGroupHeaderView.h"

@interface QSCreateGroupHeaderView ()

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIView *nameLine;

@property (nonatomic, strong) UILabel *thresholdLabel;
@property (nonatomic, strong) UIButton *subtractButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UITextField *countTextField;
@property (nonatomic, strong) UIView *sholdLine;

@property (nonatomic, strong) UILabel *nodeLabel;
@property (nonatomic, strong) UIButton *nodeButton;

@end

@implementation QSCreateGroupHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self);
        make.top.equalTo(self).offset(kRealValue(15));
        make.bottom.equalTo(self).offset(-kRealValue(15));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.top.equalTo(self.whiteView).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteView).offset(-kRealValue(20));
        make.centerY.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(55));
    }];
    
    [self.nameLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.right.equalTo(self.whiteView).offset(-kRealValue(20));
        make.top.equalTo(self.whiteView).offset(kRealValue(55));
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
     
    [self.thresholdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.top.equalTo(self.nameLine.mas_bottom).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.subtractButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.countTextField.mas_left);
        make.centerY.equalTo(self.thresholdLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteView).offset(-kRealValue(20));
        make.centerY.equalTo(self.thresholdLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.addButton.mas_left);
        make.centerY.equalTo(self.thresholdLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(28), kRealValue(24)));
    }];
    
    [self.sholdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.right.equalTo(self.whiteView).offset(-kRealValue(20));
        make.top.equalTo(self.nameLine.mas_bottom).offset(kRealValue(55));
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.nodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.top.equalTo(self.sholdLine.mas_bottom).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.nodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteView).offset(-kRealValue(22));
        make.centerY.equalTo(self.nodeLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(30), kRealValue(30)));
    }];
}

- (void)setupDefalutGroupName:(NSString *)groupName threshold:(NSString *)threshold {
    //如果有默认组名 则不能更改
    if (groupName.length) {
        self.nameTextField.enabled = NO;
    }
    self.nameTextField.text = groupName;
    self.countTextField.text = threshold;
    self.subtractButton.enabled = self.countTextField.text.integerValue > 1;
}

#pragma mark - ***************** Event Response
- (void)subtractAction {
    if (self.countTextField.text.integerValue == 1) {
        return;
    }
    self.countTextField.text = [NSString stringWithFormat:@"%ld",(long)(self.countTextField.text.integerValue - 1)];
    self.subtractButton.enabled = self.countTextField.text.integerValue > 1;
}

- (void)addAction {
    if (!self.countTextField.text.length) {
        self.countTextField.text = @"0";
    }
    
    self.countTextField.text = [NSString stringWithFormat:@"%ld",(long)(self.countTextField.text.integerValue + 1)];
    self.subtractButton.enabled = self.countTextField.text.integerValue > 1;
}

- (void)addNodeAction {
    if (self.addNodeClickBlock) {
        self.addNodeClickBlock();
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    self.subtractButton.enabled = self.countTextField.text.integerValue > 1;
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

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = QSLocalizedString(@"qs_add_address_item_name_title");
        _nameLabel.textColor = [UIColor qs_colorBlack333333];
        _nameLabel.font = [UIFont qs_fontOfSize14];
        [self.whiteView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.placeholder = QSLocalizedString(@"qs_add_address_item_name_placeholder");
        _nameTextField.textColor = [UIColor qs_colorBlack333333];
        _nameTextField.font = [UIFont qs_fontOfSize14];
        [_nameTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        [_nameTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        _nameTextField.textAlignment = NSTextAlignmentRight;
        _nameTextField.keyboardType = UIKeyboardTypeAlphabet;
        [self.whiteView addSubview:_nameTextField];
    }
    return _nameTextField;
}

- (UIView *)nameLine {
    if (!_nameLine) {
        _nameLine = [[UIView alloc] init];
        _nameLine.backgroundColor = [UIColor qs_colorGrayDDDDDD];
        [self.whiteView addSubview:_nameLine];
    }
    return _nameLine;
}

- (UILabel *)thresholdLabel {
    if (!_thresholdLabel) {
        _thresholdLabel = [[UILabel alloc] init];
        _thresholdLabel.text = QSLocalizedString(@"qs_manage_createGroup_threshold");
        _thresholdLabel.textColor = [UIColor qs_colorBlack333333];
        _thresholdLabel.font = [UIFont qs_fontOfSize14];
        [self.whiteView addSubview:_thresholdLabel];
    }
    return _thresholdLabel;
}

- (UIButton *)subtractButton {
    if (!_subtractButton) {
        _subtractButton = [[UIButton alloc] init];
        [_subtractButton setImage:[UIImage imageNamed:@"icon_wodeyu_minus"] forState:UIControlStateNormal];
        [_subtractButton addTarget:self action:@selector(subtractAction) forControlEvents:UIControlEventTouchUpInside];
        _subtractButton.enabled = NO;
        [self.whiteView addSubview:_subtractButton];
    }
    return _subtractButton;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] init];
        [_addButton setImage:[UIImage imageNamed:@"icon_wodeyu_plus"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:_addButton];
    }
    return _addButton;
}

- (UITextField *)countTextField {
    if (!_countTextField) {
        _countTextField = [[UITextField alloc] init];
        _countTextField.textColor = [UIColor qs_colorGray686868];
        _countTextField.font = [UIFont qs_fontOfSize14];
        _countTextField.textAlignment = NSTextAlignmentCenter;
        _countTextField.keyboardType = UIKeyboardTypeNumberPad;
        _countTextField.text = @"1";
        [_countTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.whiteView addSubview:_countTextField];
    }
    return _countTextField;
}

- (UIView *)sholdLine {
    if (!_sholdLine) {
        _sholdLine = [[UIView alloc] init];
        _sholdLine.backgroundColor = [UIColor qs_colorGrayDDDDDD];
        [self.whiteView addSubview:_sholdLine];
    }
    return _sholdLine;
}

- (UILabel *)nodeLabel {
    if (!_nodeLabel) {
        _nodeLabel = [[UILabel alloc] init];
        _nodeLabel.text = QSLocalizedString(@"qs_manage_createGroup_node");
        _nodeLabel.textColor = [UIColor qs_colorBlack333333];
        _nodeLabel.font = [UIFont qs_fontOfSize14];
        [self.whiteView addSubview:_nodeLabel];
    }
    return _nodeLabel;
}

- (UIButton *)nodeButton {
    if (!_nodeButton) {
        _nodeButton = [[UIButton alloc] init];
        [_nodeButton setImage:[UIImage imageNamed:@"icon_wodeyu_plus1"] forState:UIControlStateNormal];
        [_nodeButton addTarget: self action:@selector(addNodeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:_nodeButton];
    }
    return _nodeButton;
}

- (NSString *)threshold {
    return self.countTextField.text;
}

- (NSString *)groupName {
    return self.nameTextField.text;
}

@end
