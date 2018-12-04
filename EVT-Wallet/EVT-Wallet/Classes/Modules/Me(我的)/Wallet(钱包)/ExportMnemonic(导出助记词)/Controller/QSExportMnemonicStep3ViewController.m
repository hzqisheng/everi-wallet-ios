//
//  QSExportMnemonicStep3ViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/3.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSExportMnemonicStep3ViewController.h"

@interface QSExportMnemonicStep3ViewController ()

@property (nonatomic, strong) UIView *mnemonicCodeBackgroundView;

@property (nonatomic, strong) NSMutableArray *selectedCodeButtonArray;
@property (nonatomic, strong) NSMutableArray *codeButtonArray;

@property (nonatomic, assign) CGFloat codeButtonW;
@property (nonatomic, assign) CGFloat codeButtonH;
@property (nonatomic, assign) CGFloat codeButtonLeftRightMargin;
@property (nonatomic, assign) CGFloat codeButtonSpace;

@end

@implementation QSExportMnemonicStep3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_export_mnemonic_code_nav_title")];
    [self p_setupDefaultValues];
    [self p_setupSubViews];
}

- (void)p_setupDefaultValues {
    _codeButtonW = kRealValue(68);
    _codeButtonH = kRealValue(29);
    _codeButtonLeftRightMargin = kRealValue(30);
    _codeButtonSpace = kRealValue(15);
}

- (void)p_setupSubViews {
    //tips
    UILabel *tipsLabel = [UILabel labelWithName:QSLocalizedString(@"qs_export_mnemonic_code_item_check_tips_title") font:[UIFont qs_fontOfSize18] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentCenter];
    tipsLabel.numberOfLines = 0;
    tipsLabel.frame = CGRectMake(kRealValue(30), kRealValue(25), kScreenWidth - kRealValue(60), kRealValue(45));
    [self.view addSubview:tipsLabel];
    [tipsLabel sizeToFit];
    
    //tipsDetail
    UILabel *tipsDetailLabel = [UILabel labelWithName:QSLocalizedString(@"qs_export_mnemonic_code_item_check_tips_detail_title") font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    tipsDetailLabel.numberOfLines = 0;
    tipsDetailLabel.frame = CGRectMake(kRealValue(30), tipsLabel.maxY + kRealValue(25), kScreenWidth - kRealValue(60), kRealValue(45));
    [self.view addSubview:tipsDetailLabel];
    [tipsDetailLabel sizeToFit];
    
    //mnemonicCode
    UIView *mnemonicCodeBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(15), tipsDetailLabel.maxY + kRealValue(25), kScreenWidth - kRealValue(30), kRealValue(105))];
    mnemonicCodeBackgroundView.backgroundColor = [UIColor whiteColor];
    mnemonicCodeBackgroundView.layer.cornerRadius = 8;
    [self.view addSubview:mnemonicCodeBackgroundView];
    mnemonicCodeBackgroundView.layer.cornerRadius = 8;
    mnemonicCodeBackgroundView.backgroundColor = [UIColor whiteColor];
    mnemonicCodeBackgroundView.layer.shadowOffset = CGSizeMake(0, 1);
    mnemonicCodeBackgroundView.layer.shadowColor = [UIColor qs_colorGray00267B].CGColor;
    mnemonicCodeBackgroundView.layer.shadowOpacity = 0.1f;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:mnemonicCodeBackgroundView.bounds cornerRadius:8];
    mnemonicCodeBackgroundView.layer.shadowPath = path.CGPath;
    _mnemonicCodeBackgroundView = mnemonicCodeBackgroundView;
    
    //mnemonicCode
    
    for (int i = 0 ; i < 8; i++) {
        UIButton *button = [self createCodeButton];
        CGFloat buttonX = _codeButtonLeftRightMargin + (i%4) * (_codeButtonW + _codeButtonSpace);
        CGFloat buttonY = mnemonicCodeBackgroundView.maxY + kRealValue(20) + (i/4)*(_codeButtonH + _codeButtonSpace);
        button.frame = CGRectMake(buttonX, buttonY, _codeButtonW, _codeButtonH);
        [button setTitle:[NSString stringWithFormat:@"助记词%ld",(long)i] forState:UIControlStateNormal];
        [self.view addSubview:button];
        [self.codeButtonArray addObject:button];
    }
    
    //confirm button
    UIButton *lastCodeButton = self.codeButtonArray.lastObject;
    UIButton *confirmButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_export_mnemonic_code_btn_confirm_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(nextButtonClicked)];
    confirmButton.frame = CGRectMake(kScreenWidth/2 - kBottomButtonWidth/2, lastCodeButton.maxY + kRealValue(30), kBottomButtonWidth, kBottomButtonHeight);
    confirmButton.backgroundColor = [UIColor qs_colorBlack313745];
    confirmButton.layer.cornerRadius = 2;
    [self.view addSubview:confirmButton];
}

#pragma mark - **************** Private Methods
- (UIButton *)createCodeButton {
    UIButton *button = [UIButton buttonWithTitle:@"助记词" titleColor:[UIColor qs_colorBlack333333] font:[UIFont qs_fontOfSize14] taget:self action:@selector(codeButtonClicked:)];
    button.layer.cornerRadius = 3;
    button.layer.cornerRadius = 3;
    button.backgroundColor = [UIColor whiteColor];
    button.layer.shadowOffset = CGSizeMake(0, 1);
    button.layer.shadowColor = [UIColor qs_colorGray00267B].CGColor;
    button.layer.shadowOpacity = 0.1f;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:button.bounds cornerRadius:8];
    button.layer.shadowPath = path.CGPath;
    return button;
}

- (void)addOrRemoveButtonInMnemonicCodeBackgroundViewByTitle:(NSString *)title {
    for (UIButton *button in self.selectedCodeButtonArray) {
        if ([button.titleLabel.text isEqualToString:title]) {
            [button removeFromSuperview];
            //remove
            [self.selectedCodeButtonArray removeObject:button];
            //layout
            [self layoutMnemonicCodeBackgroundView];
            return;
        }
    }
    //add button
    UIButton *button = [self createCodeButton];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = [UIColor qs_colorGrayCCCCCC];
    [self.selectedCodeButtonArray addObject:button];
    //layout
    [self layoutMnemonicCodeBackgroundView];
}

- (void)layoutMnemonicCodeBackgroundView {
    [self.mnemonicCodeBackgroundView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0 ; i < self.selectedCodeButtonArray.count; i++) {
        UIButton *button = self.selectedCodeButtonArray[i];
        CGFloat buttonX = kRealValue(15) + (i%4) * (_codeButtonW + _codeButtonSpace);
        CGFloat buttonY = kRealValue(15) + (i/4)*(_codeButtonH + _codeButtonSpace);
        button.frame = CGRectMake(buttonX, buttonY, _codeButtonW, _codeButtonH);
        [self.mnemonicCodeBackgroundView addSubview:button];
    }
}

#pragma mark - **************** Event Response
- (void)codeButtonClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        sender.backgroundColor = [UIColor qs_colorGrayCCCCCC];
    } else {
        sender.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
    }
    [self addOrRemoveButtonInMnemonicCodeBackgroundViewByTitle:sender.titleLabel.text];
}

- (void)nextButtonClicked {
    
}

#pragma mark - **************** Setter Getter
- (NSMutableArray *)codeButtonArray {
    if (!_codeButtonArray) {
        _codeButtonArray = [NSMutableArray array];
    }
    return _codeButtonArray;
}

- (NSMutableArray *)selectedCodeButtonArray {
    if (!_selectedCodeButtonArray) {
        _selectedCodeButtonArray = [NSMutableArray array];
    }
    return _selectedCodeButtonArray;
}

@end
