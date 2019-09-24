//
//  QSCreateNFTAddGroupViewController.m
//  EVT-Wallet
//
//  Created by SJ on 2019/5/13.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateNFTAddGroupViewController.h"
#import "QSMyGroupViewController.h"

@interface QSCreateNFTAddGroupViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *groupView;
@property (nonatomic, strong) UILabel *groupLabel;
@property (nonatomic, strong) UILabel *chooseGroupLabel;
@property (nonatomic, strong) UIImageView *chooseGroupArrow;

@property (nonatomic, strong) UIView *thresholdView;
@property (nonatomic, strong) UILabel *thresholdLabel;
@property (nonatomic, strong) UIButton *thresholdSubtractButton;
@property (nonatomic, strong) UIButton *thresholdAddButton;
@property (nonatomic, strong) UITextField *thresholdCountTextField;

@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation QSCreateNFTAddGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.groupView];
    [self.groupView addSubview:self.groupLabel];
    [self.groupView addSubview:self.chooseGroupLabel];
    [self.groupView addSubview:self.chooseGroupArrow];
    [self.groupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kRealValue(15));
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
        make.height.equalTo(@kRealValue(50));
    }];
    
    [self.groupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.groupView);
        make.left.equalTo(self.groupView).offset(kRealValue(15));
        make.width.lessThanOrEqualTo(@kRealValue(100));
    }];
    
    [self.chooseGroupArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.groupView).offset(-kRealValue(15));
        make.centerY.equalTo(self.groupView);
        make.width.and.height.equalTo(@kRealValue(22));
    }];
    
    [self.chooseGroupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.chooseGroupArrow.mas_left).offset(-kRealValue(10));
        make.left.equalTo(self.groupLabel.mas_right).offset(kRealValue(10));
        make.centerY.equalTo(self.groupView);
    }];
    
    [self.view addSubview:self.thresholdView];
    [self.thresholdView addSubview:self.thresholdLabel];
    [self.thresholdView addSubview:self.thresholdSubtractButton];
    [self.thresholdView addSubview:self.thresholdAddButton];
    [self.thresholdView addSubview:self.thresholdCountTextField];
    [self.thresholdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.groupView.mas_bottom).offset(kRealValue(10));
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
        make.height.equalTo(@kRealValue(50));
    }];
    
    [self.thresholdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.thresholdView);
        make.left.equalTo(self.thresholdView).offset(kRealValue(15));
        make.width.lessThanOrEqualTo(@kRealValue(100));
    }];
    
    [self.thresholdAddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.thresholdView).offset(-kRealValue(15));
        make.centerY.equalTo(self.thresholdView);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.thresholdCountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.thresholdAddButton.mas_left);
        make.centerY.equalTo(self.thresholdView);
        make.size.mas_equalTo(CGSizeMake(kRealValue(38), kRealValue(24)));
    }];
    
    [self.thresholdSubtractButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.thresholdCountTextField.mas_left);
        make.centerY.equalTo(self.thresholdView);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.view addSubview:self.submitButton];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thresholdView.mas_bottom).offset(kRealValue(30));
        make.left.and.right.equalTo(self.thresholdView);
        make.height.equalTo(@kRealValue(40));
    }];
}

#pragma mark - ***************** Event Response
- (void)submitButtonClicked {
    if ([self.chooseGroupLabel.text isEqualToString:QSLocalizedString(@"qs_pass_createNFTS_add_group_choose_group_title")]) {
        [QSAppKeyWindow showAutoHideHudWithText:self.chooseGroupLabel.text];
        return;
    }
    
    if (self.thresholdCountTextField.text.integerValue < 1) {
        [QSAppKeyWindow showAutoHideHudWithText:self.thresholdLabel.text];
        return;
    }
    
    if (self.createNFTAddGroupConfirmBlock) {
        self.createNFTAddGroupConfirmBlock(self.chooseGroupLabel.text, self.thresholdCountTextField.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)groupViewClicked {
    QSMyGroupViewController *myGroup = [[QSMyGroupViewController alloc] init];
    @weakify(self);
    myGroup.myGroupClickedGroupBlock = ^(NSString * _Nonnull groupName) {
        @strongify(self);
        self.chooseGroupLabel.text = groupName;
    };
    [self.navigationController pushViewController:myGroup animated:YES];
}

- (void)thresholdSubtractAction {
    DLog(@"减少");
    if (self.thresholdCountTextField.text.integerValue <= 1) {
        return;
    }
    
    self.thresholdCountTextField.text = [NSString stringWithFormat:@"%ld", (long)self.thresholdCountTextField.text.integerValue - 1];
}

- (void)thresholdAddAction {
    DLog(@"增加");
    self.thresholdCountTextField.text = [NSString stringWithFormat:@"%ld", self.thresholdCountTextField.text.integerValue + 1];
}

- (void)textFieldDidChange:(UITextField *)textField {

}

#pragma mark - ***************** UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (!textField.text.length) {
        textField.text = @"1";
    }
    return YES;
}

#pragma mark - ***************** Setter Getter
- (UIView *)groupView {
    if (!_groupView) {
        _groupView = [[UIView alloc] init];
        _groupView.layer.cornerRadius = 8;
        _groupView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(groupViewClicked)];
        [_groupView addGestureRecognizer:tap];
    }
    return _groupView;
}

- (UILabel *)groupLabel {
    if (!_groupLabel) {
        _groupLabel = [[UILabel alloc] init];
        _groupLabel.text = QSLocalizedString(@"qs_pass_createNFTS_add_group_group_title");
        _groupLabel.textColor = [UIColor qs_colorBlack313745];
        _groupLabel.font = [UIFont qs_fontOfSize16];
    }
    return _groupLabel;
}

- (UILabel *)chooseGroupLabel {
    if (!_chooseGroupLabel) {
        _chooseGroupLabel = [[UILabel alloc] init];
        _chooseGroupLabel.text = QSLocalizedString(@"qs_pass_createNFTS_add_group_choose_group_title");
        _chooseGroupLabel.textColor = [UIColor qs_colorBlack313745];
        _chooseGroupLabel.font = [UIFont qs_fontOfSize16];
        _chooseGroupLabel.textAlignment = NSTextAlignmentRight;
    }
    return _chooseGroupLabel;
}

- (UIImageView *)chooseGroupArrow {
    if (!_chooseGroupArrow) {
        _chooseGroupArrow = [[UIImageView alloc] init];
        _chooseGroupArrow.image = [UIImage imageNamed:@"icon_wode_enter"];
        _chooseGroupArrow.userInteractionEnabled = YES;
    }
    return _chooseGroupArrow;
}

- (UIView *)thresholdView {
    if (!_thresholdView) {
        _thresholdView = [[UIView alloc] init];
        _thresholdView.layer.cornerRadius = 8;
        _thresholdView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
    }
    return _thresholdView;
}

- (UILabel *)thresholdLabel {
    if (!_thresholdLabel) {
        _thresholdLabel = [[UILabel alloc] init];
        _thresholdLabel.text = QSLocalizedString(@"qs_pass_createNFTS_add_group_weight_title");
        _thresholdLabel.textColor = [UIColor qs_colorBlack313745];
        _thresholdLabel.font = [UIFont qs_fontOfSize16];
    }
    return _thresholdLabel;
}

- (UIButton *)thresholdSubtractButton {
    if (!_thresholdSubtractButton) {
        _thresholdSubtractButton = [[UIButton alloc] init];
        [_thresholdSubtractButton setImage:[UIImage imageNamed:@"icon_wodeyu_minus"] forState:UIControlStateNormal];
        [_thresholdSubtractButton addTarget:self action:@selector(thresholdSubtractAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _thresholdSubtractButton;
}

- (UIButton *)thresholdAddButton {
    if (!_thresholdAddButton) {
        _thresholdAddButton = [[UIButton alloc] init];
        [_thresholdAddButton setImage:[UIImage imageNamed:@"icon_wodeyu_plus"] forState:UIControlStateNormal];
        [_thresholdAddButton addTarget:self action:@selector(thresholdAddAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _thresholdAddButton;
}

- (UITextField *)thresholdCountTextField {
    if (!_thresholdCountTextField) {
        _thresholdCountTextField = [[UITextField alloc] init];
        _thresholdCountTextField.textColor = [UIColor qs_colorBlack313745];
        _thresholdCountTextField.font = [UIFont qs_fontOfSize16];
//        [_thresholdCountTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
//        [_thresholdCountTextField setValue:[UIFont qs_fontOfSize16] forKeyPath:@"_placeholderLabel.font"];
        
        //* iOS 13关闭了权限， 不允许KVC给PlaceholderLabel属性赋值 */
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc]  initWithString:@"" attributes:@{NSForegroundColorAttributeName : [UIColor qs_colorGrayBBBBBB], NSFontAttributeName : [UIFont qs_fontOfSize16]}];
        _thresholdCountTextField.attributedPlaceholder = placeholderString;
        _thresholdCountTextField.textAlignment = NSTextAlignmentCenter;
        _thresholdCountTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_thresholdCountTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _thresholdCountTextField.delegate = self;
        _thresholdCountTextField.text = @"1";
    }
    return _thresholdCountTextField;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_pass_createNFTS_add_group_confirm_btn_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize15] taget:self action:@selector(submitButtonClicked)];
        _submitButton.backgroundColor = [UIColor qs_colorBlack313745];
        _submitButton.layer.cornerRadius = 2;
    }
    return _submitButton;
}

@end
